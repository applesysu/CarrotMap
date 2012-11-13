//
//  ACMapViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACMapViewController.h"
#import "SYSUMyAnnotation.h"
#import "SYSUMyAnnoCalloutView.h"
#import "SYSUCarrotCell.h"
#import "JPCarrot.h"
#import "JPDataManager.h"
#import "ACAddCarrotViewController.h"
@interface ACMapViewController ()

@end

@implementation ACMapViewController

@synthesize coordinate;
@synthesize myMapView;
@synthesize myManager;
@synthesize myGeocoder;
@synthesize rightCornerView;
//@synthesize myTapGestureRecognizer;
@synthesize insertCarrot;
@synthesize tapToChangeMode;
@synthesize LocationTrackingView;
@synthesize leftCornerView;
@synthesize leftCornerTableView;
@synthesize leftCornerLayer;
@synthesize leftCornerPan;
@synthesize bunnyUpperRight;
@synthesize dragBunny;
@synthesize userID;

//虚构数据
@synthesize database;
@synthesize theCarrotsISend;
@synthesize carrotOnMap;

//实际能够拿到的数据
@synthesize generalPublicCarrots;
@synthesize generalPrivateCarrots;

@synthesize userType;

- (id)initWithUserType:(NSString *)userLoginType
{
    self = [super init];
    if (self) {
        if ([userLoginType isEqualToString:@"Tourist"]){
            self.userType = userLoginType;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrots) name:@"didGetGeneralPublicCarrots" object:nil];
            [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:@"000000000"];
        }
        else if ([userLoginType isEqualToString:@"RenRenUser"]){
            self.userType = userLoginType;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetUserInfo) name:@"didGetUserInfo" object:nil];
            [[JPDataManager sharedInstance] getUserInfo];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    
    
    //先把interaction设置为NO，等待usersInfo的数据被拉了下来以后
    self.view.userInteractionEnabled=NO;
    
    
    
    self.generalPublicCarrots = [[NSMutableArray alloc] init];
    self.generalPrivateCarrots = [[NSMutableArray alloc] init];
    
    //乱发5个公有的萝卜
    /*JPCarrot *carrot1 = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"38.1" withLatitude:@"22.2" withMessage:@"carrot1" withSenderID:@"0001" withSendedTime:@"00:01"];
    JPCarrot *carrot2 = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"35.1" withLatitude:@"23.2" withMessage:@"carrot2" withSenderID:@"0002" withSendedTime:@"00:02"];
    JPCarrot *carrot3 = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"36.1" withLatitude:@"25.2" withMessage:@"carrot3" withSenderID:@"0003" withSendedTime:@"00:03"];
    JPCarrot *carrot4 = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"10" withLatitude:@"10" withMessage:@"carrot4" withSenderID:@"0004" withSendedTime:@"00:04"];
    JPCarrot *carrot5 = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"22.6" withLatitude:@"36.1" withMessage:@"carrot5" withSenderID:@"0005" withSendedTime:@"00:05"];*/
    
//    
//    //昨晚没有sync成功
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSendACarrotToServer) name:@"didSendACarrotToServer" object:nil];
////    [[JPDataManager sharedInstance] sendACarrotToServer:carrot1];
//    
////    [[JPDataManager sharedInstance] sendACarrotToServer:carrot2];
////    
////    [[JPDataManager sharedInstance] sendACarrotToServer:carrot3];
////   
////    [[JPDataManager sharedInstance] sendACarrotToServer:carrot4];
////   
////    [[JPDataManager sharedInstance] sendACarrotToServer:carrot5];
////    
    
    //初始化虚拟数据
    
    
    /*self.database = [NSArray arrayWithObjects:carrot1, carrot2, carrot3, carrot4, carrot5, nil];*/
    
    
    
    
    
    
//纯代码添加 mapview
    self.myMapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    self.myMapView.mapType=MKMapTypeStandard;
    self.myMapView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.myMapView.delegate=self;
    self.myMapView.userInteractionEnabled=YES;
    self.myMapView.showsUserLocation=YES;
    [self.myMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES ];
    [self.view addSubview:myMapView];
    
    //设定地图起始的区域大小，和具体的地方。选定中国广州附近(由于使用了实时定位，这个以及没用了
    //CLLocationCoordinate2D coordinateForStartRegion=CLLocationCoordinate2DMake(23.0101, 113.3123);
    //self.myMapView.region=MKCoordinateRegionMakeWithDistance(coordinateForStartRegion, 10000, 10000);
    
    // 使用CLLocationManager 来使用定位功能
    if ([CLLocationManager locationServicesEnabled]) {
        myManager=[[CLLocationManager alloc] init];
        self.myManager.delegate=self;
        self.myManager.purpose=@"To provide functionality base on user's location.";
        
        
        //Location功能正式开启。其功能实现主要依靠于 location的8个协议方法，后面我只用了一个。
        [self.myManager startUpdatingLocation];
    }else{
        NSLog(@"Service are not available");
    }
    
/* A Sample location*/
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(23.01, 113.33);
    CLLocation *GLocation=[[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    
    //创建SYSUAnnotation, 这是我们自定义的Annotation
    SYSUMyAnnotation *annotation=[[SYSUMyAnnotation alloc] initWithCoordinate:location title:@"MyAnnotation" subtitle:@"SubTitle"];
    annotation.pinColor=MKPinAnnotationColorPurple;
    [self.myMapView addAnnotation:annotation];
    
    
    
    
    
    
    //用generalPublicCarrots在地图上setup一堆annotation
    /*int i;
    
    self.carrotOnMap = [[NSMutableArray alloc] init];
    for (i = 0; i < [self.generalPublicCarrots count]; i++){
        JPCarrot *tmp = [self.generalPublicCarrots objectAtIndex:i];
        CLLocationCoordinate2D tmplocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        
        [self.carrotOnMap addObject:[[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.carrotID subtitle:tmp.message]];
        
        [self.myMapView addAnnotation:[[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.carrotID subtitle:tmp.message]];
    }*/
    
    
    //获取具体地址，并赋值给我们的Pin
    self.myGeocoder=[[CLGeocoder alloc] init];
    [self.myGeocoder reverseGeocodeLocation:GLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error==nil&&[placemarks count]>0) {
            CLPlacemark *placemark=[placemarks objectAtIndex:0];
            //   NSLog(@"%@",placemark);
            //  NSLog(@"%@ : %@ : %@", placemark.subLocality,placemark.name, placemark.locality);
            annotation.title=placemark.name;
            annotation.subtitle=placemark.subLocality;
        } else if(error==nil&&[placemarks count]==0){
            NSLog(@"No Results returns");
        }else if (error!=nil){
            NSLog(@"Error=%@",error);
        }
    }];

    
    
//1. 目的是放置一键插萝卜功能
    UIImage *rightCorner=[UIImage imageNamed:@"Icon.png"];
    rightCornerView=[[UIImageView alloc] initWithImage:rightCorner];
    self.rightCornerView.center=CGPointMake(290, 430);
    self.rightCornerView.userInteractionEnabled=YES;
    [self.view addSubview:self.rightCornerView];
    
    //插萝卜函数    
    self.insertCarrot=[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(PushCarrot:)];
    self.insertCarrot.numberOfTapsRequired=1;
    self.insertCarrot.delegate=self;
    
    [self.rightCornerView addGestureRecognizer:self.insertCarrot];
    
//2. 定位图标，用来提供给用户，用以回到自己位置并开始实时定位
    UIImage *locationTracking=[UIImage  imageNamed:@"Icon.png"];
    LocationTrackingView=[[UIImageView alloc] initWithImage:locationTracking];
    self.LocationTrackingView.center=CGPointMake(230, 430);
    self.LocationTrackingView.userInteractionEnabled=YES;
    [self.view addSubview:self.LocationTrackingView];
    
    //寻找自己的位置并实时定位函数
    self.tapToChangeMode=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChangeMode:)];
    self.tapToChangeMode.numberOfTouchesRequired=1;
    self.tapToChangeMode.numberOfTapsRequired=1;
    self.tapToChangeMode.delegate=self;
    [self.LocationTrackingView addGestureRecognizer:tapToChangeMode];
    
    
    
//3. 拉兔兔喽
    self.leftCornerView=[[UIView alloc] init];
    //WithImage:image];
    self.leftCornerView.userInteractionEnabled=YES;
    self.leftCornerView.frame=CGRectMake(0, 460, 120, 480);
    self.leftCornerView.center=CGPointMake(60, 600);
    
    //弄一个Bar出来，以识别拉动的是tableView还是Bar
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:self.leftCornerView.bounds];
    [navBar setTintColor:[UIColor greenColor]];
    
    [leftCornerView addSubview:navBar];
    
    //萝卜列表tableView
    CGRect tableBounds;
    tableBounds.origin.x = 15;
    tableBounds.origin.y = 15;
    tableBounds.size.width = self.leftCornerView.bounds.size.width - 30;
    tableBounds.size.height = self.leftCornerView.bounds.size.height - 30;
    self.leftCornerTableView = [[UITableView alloc] initWithFrame:tableBounds style:UITableViewStylePlain];
    self.leftCornerTableView.backgroundColor = [UIColor orangeColor];
    self.leftCornerTableView.separatorColor = [UIColor colorWithWhite:0 alpha:.2];
    self.leftCornerTableView.delegate = self;
    self.leftCornerTableView.dataSource = self;
    
    [self.leftCornerView addSubview:self.leftCornerTableView];
    
    //最终把左下角的View加入Map中！！
    [self.myMapView addSubview:self.leftCornerView];
    
    //Layer
    leftCornerLayer=[CALayer layer];
    leftCornerLayer.frame=leftCornerView.bounds;
    leftCornerLayer.cornerRadius=10.0f;
    [leftCornerView.layer addSublayer:leftCornerLayer];
    
    //为拉兔子添加一个gesture
    leftCornerPan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    leftCornerPan.maximumNumberOfTouches=1;
    leftCornerPan.minimumNumberOfTouches=1;
    [self.leftCornerView addGestureRecognizer:leftCornerPan];

    
    
//4. 右上角拉动兔子出来
    self.bunnyUpperRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
    [self.bunnyUpperRight setFrame:CGRectMake(250, 0, 60, 60)];
    [self.bunnyUpperRight sizeToFit];
    self.bunnyUpperRight.userInteractionEnabled = YES;
    [self.myMapView addSubview:self.bunnyUpperRight];
    //添加PanGesture
    self.dragBunny = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanBunnyUpperRight:)];
    [self.bunnyUpperRight addGestureRecognizer:self.dragBunny];
    
}

- (void)viewDidUnload
{
    self.leftCornerPan=nil;
    self.leftCornerLayer=nil;
    self.leftCornerView=nil;
    self.myMapView=nil;
    self.myManager=nil;
    self.myGeocoder=nil;
    self.myGeocoder=nil;
    //   self.myTapGestureRecognizer=nil;
    self.insertCarrot=nil;
    self.tapToChangeMode=nil;
    self.LocationTrackingView=nil;
    [self.myManager stopUpdatingLocation];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CLLocation Delegate 

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //协议方法－－CClocation  一旦实施定位开启后，这个函数会在极短的时间内反复调用（即使你没有挪窝，这时两个位置参数的值一样）
/*    NSLog(@"Latitude=%f, Longtitude=%f  ------",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    
    NSLog(@"Latitude=%f, Longtitude=%f   $$$$$$",oldLocation.coordinate.latitude,oldLocation.coordinate.longitude);
*/
}

#pragma mark - MKMapView Delegate

-(void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    //    if (mode==MKUserTrackingModeNone) {
    //       // NSLog(@"None!");
    //        self.myMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;
    //    }
    //    
    //    if (mode==MKUserTrackingModeFollowWithHeading) {
    //      //  NSLog(@"Heading!");
    //         self.myMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;
    //    }
    //    
    //    if (mode==MKUserTrackingModeFollow) {
    //       // NSLog(@"Follow");
    //         self.myMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;
    //    }
}



//应用这个delegate method来实现callout是不同的信息（depend on距离）
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //把mapView上面的annotation里面的calloutView内容都更新一遍
    
    /*int i;
     for (i = 0; i < [carrotOnMap count]; i++){
     
     SYSUMyAnnotation *pin = [carrotOnMap objectAtIndex:i];
     CLLocationCoordinate2D locationOfPinCoordinate = [pin coordinate];
     CLLocation *locationOfPin = [[CLLocation alloc] initWithLatitude:locationOfPinCoordinate.latitude longitude:locationOfPinCoordinate.longitude];
     double distanceMeters = [userLocation.location getDistanceFrom:locationOfPin];
     double distanceMiles = (distanceMeters / 1609.344);*/
    
    //如果距离太远，设置callout里面的信息为“距离太远啦哥！！走进再拔啊哥！！”
    
    
    
    
    
    //怎么实现？？通过annotation get它的calloutView
    
    
    
    
    //距离足够近，设置callout里面的信息为“可以拔了哥！”
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //更正：这个不是AnnotationDelegate的函数，而是MKMapViewDelegate的函数，尽管它的发起者是Annotation
    
    //这个协议方法是由一个Annotation发起的，因此它需要创建一个MKAnnotationView，这个View会中被绘制在地图上并提供交互。IOS提供了一个定义好的（包括图片，颜色等属性）的MKAnnotation的子类，叫做MKPinAnnotation。你可以用它放置熟悉的大头针。
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[SYSUMyAnnotation class]]){
        
        SYSUMyAnnoCalloutView* pinView = (SYSUMyAnnoCalloutView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"SYSUMyAnnoCalloutView"];
        if (!pinView){
            pinView = [[SYSUMyAnnoCalloutView alloc] initWithAnnotation:annotation
                                                        reuseIdentifier:@"SYSUMyAnnoCalloutView"];
            NSLog(@"Build up a new MKAnnotationView");
            UIImage *pinImage=[UIImage imageNamed:@"Icon.png"];
            if (pinImage!=nil) {
                pinView.image=pinImage;
            }//靠...为毛不起作用
            
            [pinView setPinColor:MKPinAnnotationColorPurple];
            [pinView setAnimatesDrop:YES];
            [pinView setCanShowCallout:NO];//这样就不会弹出系统默认的Callout
            [pinView setDraggable:NO];
        }
        else
            pinView.annotation = annotation;
        
        
        return pinView;
    }
    
    return nil;
    
    
    /*MKAnnotationView *result=nil;
     if ([annotation isKindOfClass:[SYSUMyAnnotation class]]==NO) {
     return result;
     }
     
     if ([mapView isEqual:myMapView]==NO) {
     return result;
     }
     
     SYSUMyAnnotation *senderAnnotation=(SYSUMyAnnotation *)annotation;
     
     NSString *pinReusableIdentifier=[SYSUMyAnnotation reusableIdentifierForPinColor:senderAnnotation.pinColor];
     MKAnnotationView *annota=(MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
     
     //初次定义MKAnnotationView
     if (annota==nil) {
     annota=[[MKAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
     [annota setCanShowCallout:YES];
     
     }
     
     
     
     result=annota;
     UIImage *pinImage=[UIImage imageNamed:@"Icon.png"];
     if (pinImage!=nil) {
     annota.image=pinImage;
     } 
     
     result=annota;
     
     return result;*/
    
}

#pragma mark - GestureRecognizer HandleTaps

// 用来提供手工地图放置萝卜的函数
/*
 -(void)handleTaps:(UITapGestureRecognizer *)parasender{
 
 CLLocationCoordinate2D coordinate=[self.myMapView convertPoint:[parasender locationInView:self.myMapView] toCoordinateFromView:self.myMapView];
 
 //    NSLog(@"%f  :  %f ",coordinate.latitude,coordinate.longitude);
 SYSUMyAnnotation *annotation=[[SYSUMyAnnotation alloc] initWithCoordinate:coordinate title:@"MyAnnotation" subtitle:@"SubTitle"];
 [self.myMapView addAnnotation:annotation];
 
 }
 */

//插萝卜函数

//需要修改！！到时要改成进入一个发萝卜的View里面，然后发萝卜才会成功
//现在数组里面的元素只能暂时是Annotation，而不能是JPCarrot，因为在发萝卜的View里面
//才能由用户输入来确定萝卜中的数据

-(void)PushCarrot:(UITapGestureRecognizer  *)parasender{
    
    if(parasender.state==UIGestureRecognizerStateEnded){
        MKUserLocation *usrLocation=self.myMapView.userLocation;
        CLLocation *location=usrLocation.location;
        CLLocationCoordinate2D location2D=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        NSLog(@"%f : %f",location2D.latitude,location2D.longitude);
//        SYSUMyAnnotation *tapAnnotation=[[SYSUMyAnnotation alloc] initWithCoordinate:location2D title:@"兔子军团" subtitle:@"萝卜世界"];
//        
//        
//        //在这个地方把新加的Pin加入虚构的数据库
//        [self.theCarrotsISend addObject:tapAnnotation];
//        
//        
//        
//        [self.myMapView addAnnotation:tapAnnotation];
        ACAddCarrotViewController *addCarrotViewController=[[ACAddCarrotViewController alloc] initWithLatitude:location2D.latitude withLongtitude:location2D.longitude];
        [self presentModalViewController:addCarrotViewController animated:YES];
    
    }
    
    /*Pin下降最终定下的Core Animation
     if (parasender.state==UIGestureRecognizerStateEnded) {
     CGMutablePathRef thePath=CGPathCreateMutable();
     CGPathMoveToPoint(thePath, NULL, 16.0f, 16.0f);
     CGPathAddLineToPoint(thePath, NULL, 16.0f, 160.0f);
     
     CAKeyframeAnimation *theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
     
     theAnimation.path=thePath;
     CAAnimationGroup *theGroup=[CAAnimationGroup animation];
     theGroup.animations=[NSArray arrayWithObject:theAnimation];
     
     theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
     theGroup.duration=2.0;
     
     CFRelease(thePath);
     [self.LocationTrackingView.layer addAnimation:theGroup forKey:@"positon"];
     
     }*/
    
    
}
//实时定位函数
-(void)ChangeMode:(UITapGestureRecognizer *)parasender{
    if (parasender.state==UIGestureRecognizerStateEnded) {
        self.myMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;
    }
}

//左边的兔子和列表
-(void)pan:(UIPanGestureRecognizer*)paramSender{
    
    
    if(paramSender.state==UIGestureRecognizerStateEnded) {
        
        if (paramSender.view.center.y==600.0f) {
            
            //CG上拉路径设置
            CGMutablePathRef thePath=CGPathCreateMutable();
            CGPathMoveToPoint(thePath, NULL, 60.0f, 600.0f);
            CGPathAddLineToPoint(thePath, NULL, 60.0f, 160.0f);
            CGPathAddCurveToPoint(thePath, NULL, 60.0f, 145.0f, 60.0f, 170.0f, 60.0f, 154.0f);
            CGPathAddLineToPoint(thePath, NULL, 60.0f, 160.0f);
            CAKeyframeAnimation *theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            //CA path设置
            theAnimation.path=thePath;
            CAAnimationGroup *theGroup=[CAAnimationGroup animation];
            theGroup.animations=[NSArray arrayWithObject:theAnimation];
            
            theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            theGroup.duration=1.0f;
            
            CFRelease(thePath);
            [self.leftCornerView.layer addAnimation:theGroup forKey:@"positon"];
            paramSender.view.center=CGPointMake(60.0f, 160.0f);
            
            
        }
        
        else if(paramSender.view.center.y==160){
            CGMutablePathRef thePath=CGPathCreateMutable();
            CGPathMoveToPoint(thePath, NULL, 60.0f, 160.0f);
            CGPathAddLineToPoint(thePath, NULL, 60.0f, 600.0f);
            CGPathAddCurveToPoint(thePath, NULL, 60.0f, 610.0f, 60.0f, 595.0f, 60.0f,597.0f);
            CGPathAddLineToPoint(thePath, NULL, 60.0f, 600.0f);
            CAKeyframeAnimation *theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            theAnimation.path=thePath;
            CAAnimationGroup *theGroup=[CAAnimationGroup animation];
            theGroup.animations=[NSArray arrayWithObject:theAnimation];
            
            theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            theGroup.duration=0.2f;
            
            CFRelease(thePath);
            [self.leftCornerView.layer addAnimation:theGroup forKey:@"position"];
            paramSender.view.center=CGPointMake(60.0f, 600.0f);
            
        }
    }
    
}

- (void)PanBunnyUpperRight:(UIPanGestureRecognizer *)paramSender
{
    CGPoint translation = [paramSender translationInView:self.view];
    paramSender.view.center = CGPointMake(paramSender.view.center.x + translation.x,paramSender.view.center.y + translation.y);
    [paramSender setTranslation:CGPointMake(0, 0) inView:self.view];
    //可以在这里直接添加摇屁股的Core Animation
    
    
    //手势暂停以后，UIImageView变大并且出现个人信息页面
    
    static bool didBecomeBigger = NO;//识别是否第一次操作
    
    if (paramSender.state == UIGestureRecognizerStateEnded){
        CGPoint judge= [paramSender locationInView:paramSender.view.superview];
        if ((judge.x>30&&judge.x<300&&judge.y>30&&judge.y<430) && !didBecomeBigger) {
            //把bunny放大
            CABasicAnimation *pulseAnimation=[CABasicAnimation animation];
            CATransform3D transfromMakeLayerScale=CATransform3DMakeScale(5.0, 5.0, 1.0);
            pulseAnimation.keyPath=@"transform.scale";
            pulseAnimation.fromValue=[NSNumber numberWithFloat:1.0];
            pulseAnimation.toValue=[NSNumber numberWithFloat:5.0];
            pulseAnimation.duration = 1.0f;
            pulseAnimation.fillMode=kCAFillModeForwards;
            pulseAnimation.autoreverses=NO;
            pulseAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [paramSender.view.layer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
            paramSender.view.layer.transform=transfromMakeLayerScale;
            
            //把bunny移到屏幕中间
            CGMutablePathRef moveToMiddle=CGPathCreateMutable();
            CGPathMoveToPoint(moveToMiddle, NULL, judge.x, judge.y);
            CGPathAddLineToPoint(moveToMiddle, NULL, 160, 240);//目标地址是MapView中点
            CAKeyframeAnimation *moveAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            moveAnimation.path=moveToMiddle;
            [paramSender.view.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
            
            //设置Group来共同执行Animation
            /*CAAnimationGroup *group=[CAAnimationGroup animation];
             group.animations=[NSArray arrayWithObjects:pulseAnimation, moveToMiddle, nil];
             
             [paramSender.view.layer addAnimation:group forKey:nil];*/
            
            didBecomeBigger = NO;//设成已经移动过了就不可以再移动了
        }
    }
}

#pragma mark - TableView DataSource
//多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int result = 0;
    if ([tableView isEqual:self.leftCornerTableView]){
        return 2;
    }
    return result;
}

//每个section里面有多少个row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = 0;
    if ([tableView isEqual:self.leftCornerTableView]){
//        NSLog(@"Numbers of row in section %u", ([self.generalPublicCarrots count] + [self.generalPrivateCarrots count]));
//        return ([self.generalPublicCarrots count] + [self.generalPrivateCarrots count]);
        if (section == 0){
            return [self.generalPrivateCarrots count];
        }
        else if (section == 1){
            return [self.generalPublicCarrots count];
        }
    }
    return result;
}

//定制每一个Cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYSUCarrotCell *cell = nil;
    NSString *identifier = @"Carrot";
    if ([tableView isEqual:self.leftCornerTableView]){
        cell = (SYSUCarrotCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[SYSUCarrotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
            
            
            //第一个section：私有的萝卜
            //第二个section:公有的萝卜
            
            if (indexPath.section == 0){
                JPCarrot *tmp = [self.generalPrivateCarrots objectAtIndex:indexPath.row];
                cell.title.text = tmp.carrotID;
                cell.subtitle.text = tmp.message;
            }
            else {
                JPCarrot *tmp = [self.generalPublicCarrots objectAtIndex:indexPath.row];
                cell.title.text = tmp.carrotID;
                cell.subtitle.text = tmp.message;
            }
            
    
            return cell;
        }
    }
    return cell;
}

//设置每一个section的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result = nil;
    if ([tableView isEqual:self.leftCornerTableView]) {
        if (section == 0) {
            return @"私有萝卜";
        }
        else {
            return @"公有萝卜";
        }
    }
    return result;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float result = 0.0f;
    if ([tableView isEqual:self.leftCornerTableView]){
        return 60.0f;
    }
    
    return result;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        JPCarrot *tmp = [self.generalPrivateCarrots objectAtIndex:indexPath.row];
        CLLocationCoordinate2D tmpLocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        [self.myMapView setCenterCoordinate:tmpLocation animated:YES];
    }
    else {
        JPCarrot *tmp = [self.generalPublicCarrots objectAtIndex:indexPath.row];
        CLLocationCoordinate2D tmpLocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        [self.myMapView setCenterCoordinate:tmpLocation animated:YES];
    }
}

#pragma mark - 异步的函数，实现和拉用户数据，拉萝卜有关的函数

- (void)didGetUserInfo
{
    NSLog(@"didGetUserInfo");
    //拿到用户的信息数据
    NSDictionary *dict=[[NSDictionary alloc] initWithDictionary:[[JPDataManager sharedInstance] userInfo]];
    self.userID = [dict objectForKey:@"uid"];
    [dict objectForKey:@"name"];
    [dict objectForKey:@"tinyurl"];
    

    
    //进入页面以后开始拉私有的萝卜
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPrivateCarrots) name:@"didGetGeneralPrivateCarrots" object:nil];
    [[JPDataManager sharedInstance] getGeneralPrivateCarrotsWithUid:self.userID];
}

- (void)didGetGeneralPrivateCarrots
{
    //把拉到的私有萝卜存储在ViewController里面的数组里面
    NSLog(@"didGetGeneralPrivateCarrots");
    [self.generalPrivateCarrots addObjectsFromArray:[JPDataManager sharedInstance].GeneralprivateCarrots];
    NSLog(@"Numbers of Carrots in the View's general private carrots %u", [self.generalPrivateCarrots count]);
    NSLog(@"Numbers of Carrots in the DataManager's general private carrots %u", [[JPDataManager sharedInstance].GeneralprivateCarrots count]);
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralprivateCarrots );
    
    
    //拉完私有萝卜以后就可以开始拉公有的萝卜
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrots) name:@"didGetGeneralPublicCarrots" object:nil];
    [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:self.userID withNumber:5];
}

- (void)didGetGeneralPublicCarrots
{
    NSLog(@"didGetGeneralPublicCarrots");
    //把拉到的公有萝卜存储在ViewController里面的数组里面
    [self.generalPublicCarrots addObjectsFromArray:[JPDataManager sharedInstance].GeneralpublicCarrots];
    NSLog(@"Numbers of Carrots in the View's general public carrots %u", [self.generalPublicCarrots count]);
    NSLog(@"Numbers of Carrots in the DataManager's general public carrots %u", [[JPDataManager sharedInstance].GeneralpublicCarrots count]);
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralpublicCarrots);
    
    
    //拉到数据以后重新reload一下 TableView(包括它的Cells)
    [self.leftCornerTableView reloadData];
//    [self.myMapView addAnnotations:self.generalPublicCarrots];
//    [self.myMapView addAnnotations:self.generalPrivateCarrots];
 
    
    //把所有的公有萝卜转化成Annotation然后加到mapView里面
    self.carrotOnMap = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [self.generalPublicCarrots count]; i++){
        JPCarrot *tmp = [self.generalPublicCarrots objectAtIndex:i];
        CLLocationCoordinate2D tmplocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        SYSUMyAnnotation *tmpAnno = [[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.carrotID subtitle:tmp.message];
        
        [self.carrotOnMap addObject:tmpAnno];
        [self.myMapView addAnnotation:tmpAnno];
    }
    //把所有的私有萝卜转化成Annotation然后加到mapView里面
    for (i = 0; i < [self.generalPrivateCarrots count]; i++){
        JPCarrot *tmp = [self.generalPrivateCarrots objectAtIndex:i];
        CLLocationCoordinate2D tmplocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        SYSUMyAnnotation *tmpAnno = [[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.carrotID subtitle:tmp.message];
        
        [self.carrotOnMap addObject:tmpAnno];
        [self.myMapView addAnnotation:tmpAnno];
    }
    
    //在这个异步结束的地方，最后最后把view 的interaction改成YES
    self.view.userInteractionEnabled = YES; 
    
    if ([self.userType isEqualToString:@"Tourist"]){
        self.rightCornerView.userInteractionEnabled = NO;
    }
}

/*- (void) didSendACarrotToServer
{
    NSLog(@"Send a carrot");
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrots) name:@"didGetGeneralPublicCarrots" object:nil];
    [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:@"311260621" withNumber:5];
}*/

@end
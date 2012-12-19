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
#import "SYSUMyCalloutImageView.h"
#import "SYSUCarrotCell.h"
#import "JPCarrot.h"
#import "JPDataManager.h"
#import "ACAddCarrotViewController.h"
#import "ACMyViewViewController.h"
#import "ACCarrotDetialViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MyUIButton.h"

@interface ACMapViewController ()

@end

@implementation ACMapViewController

@synthesize coordinate;
@synthesize myMapView;
@synthesize myManager;
@synthesize myGeocoder;
@synthesize rightCornerView;
@synthesize leftCornerBackground;
//@synthesize myTapGestureRecognizer;
@synthesize insertCarrot;
@synthesize tapToChangeMode;
@synthesize LocationTrackingView;
@synthesize leftCornerView;
@synthesize leftCornerTableView;
@synthesize leftCornerLayer;
@synthesize leftCornerPan;
@synthesize tapOnPins;
@synthesize bunnyUpperRight;
@synthesize dragBunny;
@synthesize userID;
@synthesize userInfo;

//虚构数据
@synthesize database;
@synthesize theCarrotsISend;
@synthesize carrotOnMap;

//实际能够拿到的数据
@synthesize generalPublicCarrots;
@synthesize generalPrivateCarrots;

@synthesize userType;

//id-Mapping Dictionary
@synthesize idMappingDictionary;

//nearbyCarrot
@synthesize nearbyCarrot;

- (id)initWithUserType:(NSString *)userLoginType
{
    self = [super init];
    if (self) {
        if ([userLoginType isEqualToString:@"Tourist"]){
            self.userType = userLoginType;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrotsMapView) name:@"didGetGeneralPublicCarrots" object:nil];
            [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:@"000000000"];
        }
        else if ([userLoginType isEqualToString:@"RenRenUser"]){
            self.userType = userLoginType;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetUserInfoMapView) name:@"didGetUserInfo" object:nil];
            [[JPDataManager sharedInstance] getUserInfo];
        }
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"view did appear function called");
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    //进入更新机制
    //[self renewData];
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
    
///* A Sample location*/
//    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(23.01, 113.33);
//    CLLocation *GLocation=[[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
//    
//    //创建SYSUAnnotation, 这是我们自定义的Annotation
//    SYSUMyAnnotation *annotation=[[SYSUMyAnnotation alloc] initWithCoordinate:location title:@"MyAnnotation" subtitle:@"SubTitle"];
//    annotation.pinColor=MKPinAnnotationColorPurple;
//    [self.myMapView addAnnotation:annotation];
//    
//    
//    
//    //获取具体地址，并赋值给我们的Pin
//    self.myGeocoder=[[CLGeocoder alloc] init];
//    [self.myGeocoder reverseGeocodeLocation:GLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (error==nil&&[placemarks count]>0) {
//            CLPlacemark *placemark=[placemarks objectAtIndex:0];
//            //   NSLog(@"%@",placemark);
//            //  NSLog(@"%@ : %@ : %@", placemark.subLocality,placemark.name, placemark.locality);
//            annotation.title=placemark.name;
//            annotation.subtitle=placemark.subLocality;
//        } else if(error==nil&&[placemarks count]==0){
//            NSLog(@"No Results returns");
//        }else if (error!=nil){
//            NSLog(@"Error=%@",error);
//        }
//    }];

    
    
//1. 目的是放置一键插萝卜功能
    UIImage *rightCorner=[UIImage imageNamed:@"1add.png"];
    rightCornerView=[[UIImageView alloc] initWithImage:rightCorner];
    [self.rightCornerView setFrame:CGRectMake(270, 405, 45, 52)];
    //self.rightCornerView.center=CGPointMake(290, 430);
    self.rightCornerView.userInteractionEnabled=YES;
    [self.view addSubview:self.rightCornerView];
    
    //插萝卜函数    
    self.insertCarrot=[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(PushCarrot:)];
    self.insertCarrot.numberOfTapsRequired=1;
    self.insertCarrot.delegate=self;
    
    [self.rightCornerView addGestureRecognizer:self.insertCarrot];
    
//2. 定位图标，用来提供给用户，用以回到自己位置并开始实时定位
    UIImage *locationTracking=[UIImage  imageNamed:@"1locate.png"];
    self.LocationTrackingView=[[UIImageView alloc] initWithImage:locationTracking];
    [self.LocationTrackingView setFrame:CGRectMake(220, 405, 45, 52)];
    //self.LocationTrackingView.center=CGPointMake(230, 430);
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
    self.leftCornerView.frame=CGRectMake(0, 388, 160, 320);
    self.leftCornerView.backgroundColor = [UIColor clearColor];
    
    //设定兔子板的背景图片
    self.leftCornerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1board.png"]];
    [self.leftCornerBackground setFrame:self.leftCornerView.bounds];
    [self.leftCornerView addSubview:self.leftCornerBackground];
    
    //萝卜列表tableView
    CGRect tableBounds;
    tableBounds.origin.x = 6;
    tableBounds.origin.y = 70.5;
    tableBounds.size.width = self.leftCornerView.bounds.size.width-10.5;
    tableBounds.size.height = self.leftCornerView.bounds.size.height - 77;
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
    self.bunnyUpperRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1info.png"]];
    [self.bunnyUpperRight setFrame:CGRectMake(250, 10, 60, 40)];
    
    //暂时将interaction设置成NO
    self.bunnyUpperRight.userInteractionEnabled = NO;
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
    self.leftCornerBackground=nil;
    self.myMapView=nil;
    self.myManager=nil;
    self.myGeocoder=nil;
    self.leftCornerPan=nil;
    self.insertCarrot=nil;
    self.tapToChangeMode=nil;
    self.LocationTrackingView=nil;
    self.rightCornerView=nil;
    self.bunnyUpperRight=nil;
    self.dragBunny=nil;
    self.database=nil;
    self.tapOnPins=nil;
    [self.myManager stopUpdatingLocation];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

#pragma mark - CLLocation Delegate 

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
////   NSLog(@"Latitude=%f, Longtitude=%f  ------",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
////    
////    NSLog(@"Latitude=%f, Longtitude=%f   $$$$$$",oldLocation.coordinate.latitude,oldLocation.coordinate.longitude);
// //   NSLog(@"Location Delegate called");
//    int i;
//    for (i = 0; i < [carrotOnMap count]; i++){
//        
//        SYSUMyAnnotation *pin = [carrotOnMap objectAtIndex:i];
//        
//        //用来计算距离
//        CLLocationCoordinate2D locationOfPinCoordinate = [pin coordinate];
//        CLLocation *locationOfPin = [[CLLocation alloc] initWithLatitude:locationOfPinCoordinate.latitude longitude:locationOfPinCoordinate.longitude];
//        double distanceMeters = [newLocation distanceFromLocation:locationOfPin];
//        
//        NSLog(@"Test for the distanceMeters: %lf from %@", distanceMeters, pin.title);
//        
//        //如果距离太远，设置callout里面的信息为“距离太远啦哥！！走进再拔啊哥！！”
//        if (distanceMeters<700) {
//            pin.calloutViewOfPin.calloutImageView.messageLabelSecond.text = @"摇动手机拔萝卜吧！";
//        }
//        else {
//            pin.calloutViewOfPin.calloutImageView.messageLabelSecond.text = @"太远了！先靠近这根萝卜吧！";
//        }
//    }
//    
//    
//    //以下部分是设置nearbyCarrot
//    //Private的萝卜优先
//    if (self.nearbyCarrot != nil){
//        return;
//    }
//
//    for (i = 0; i < [[JPDataManager sharedInstance].GeneralprivateCarrots count]; i++){
//        JPCarrot *tmpCarrot = [[JPDataManager sharedInstance].GeneralprivateCarrots objectAtIndex:i];
//        CLLocation *tmpCarrotLocation = [[CLLocation alloc] initWithLatitude:tmpCarrot.latitude longitude:tmpCarrot.longitude];
//        double distanceMeters = [newLocation distanceFromLocation:tmpCarrotLocation];
//        if (distanceMeters < 700){
//            if (self.nearbyCarrot != nil){
//                return;
//            }
//            self.nearbyCarrot = tmpCarrot;
//        }
//    }
//    
//    for (i = 0; i < [[JPDataManager sharedInstance].GeneralpublicCarrots count]; i++){
//        JPCarrot *tmpCarrot = [[JPDataManager sharedInstance].GeneralpublicCarrots objectAtIndex:i];
//        CLLocation *tmpCarrotLocation = [[CLLocation alloc] initWithLatitude:tmpCarrot.latitude longitude:tmpCarrot.longitude];
//        double distanceMeters = [newLocation distanceFromLocation:tmpCarrotLocation];
//        if (distanceMeters < 700){
//            if (self.nearbyCarrot != nil){
//                return;
//            }
//            self.nearbyCarrot = tmpCarrot;
//        }
//    }
}

#pragma mark - MKMapView Delegate

-(void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    
//    NSLog(@"%d",mode);
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
/*- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //把mapView上面的annotation里面的calloutView内容都更新一遍
    
    int i;
    for (i = 0; i < [carrotOnMap count]; i++){
     
        SYSUMyAnnotation *pin = [carrotOnMap objectAtIndex:i];
        CLLocationCoordinate2D locationOfPinCoordinate = [pin coordinate];
        CLLocation *locationOfPin = [[CLLocation alloc] initWithLatitude:locationOfPinCoordinate.latitude longitude:locationOfPinCoordinate.longitude];
        double distanceMeters = [userLocation.location distanceFromLocation:locationOfPin];
    
    //如果距离太远，设置callout里面的信息为“距离太远啦哥！！走进再拔啊哥！！”
        if (distanceMeters<5000) {
            pin.calloutViewOfPin.calloutImageView.messageLabel.text = @"That's near enough";
        }
        else {
            pin.calloutViewOfPin.calloutImageView.messageLabel.text = @"That's too far";
        }
    }
}*/

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    //更正：这个不是AnnotationDelegate的函数，而是MKMapViewDelegate的函数，尽管它的发起者是Annotation
    
    //这个协议方法是由一个Annotation发起的，因此它需要创建一个MKAnnotationView，这个View会中被绘制在地图上并提供交互。IOS提供了一个定义好的（包括图片，颜色等属性）的MKAnnotation的子类，叫做MKPinAnnotation。你可以用它放置熟悉的大头针。
    
    MKAnnotationView *result=nil;
    if ([annotation isKindOfClass:[SYSUMyAnnotation class]]==NO) {
        return result;
    }
     
    if ([mapView isEqual:myMapView]==NO) {
        return result;
    }
     
    SYSUMyAnnotation *senderAnnotation=(SYSUMyAnnotation *)annotation;
     
    NSString *pinReusableIdentifier=[SYSUMyAnnotation reusableIdentifierForPinColor:senderAnnotation.pinColor];
    SYSUMyAnnoCalloutView *annota=(SYSUMyAnnoCalloutView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    annota.calloutImageView.messageLabel.text = @"来自:";
    
    //添加一个按钮
    //[annota.calloutImageView.detailButton setCarrot:senderAnnotation.carrot];
    //[annota.calloutImageView.detailButton addTarget:self action:@selector(clickForDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([senderAnnotation.title isEqualToString:self.userID]){
        NSLog(@"%@", [self.userInfo objectForKey:@"name"]);
        annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:[self.userInfo objectForKey:@"name"]];
    }
    else {
        NSLog(@"%d", [senderAnnotation.title intValue]);
        annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:[self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[senderAnnotation.title intValue]]]];
    }
    annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:@"的一条信息"];
    senderAnnotation.calloutViewOfPin = annota;
    
     //初次定义MKAnnotationView
    if (annota==nil) {
        //第一件事情：initWithAnnotation
        annota=[[SYSUMyAnnoCalloutView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
        annota.calloutImageView.messageLabel.text = @"来自:";
        
        //添加一个按钮
        //[annota.calloutImageView.detailButton setCarrot:senderAnnotation.carrot];
        //[annota.calloutImageView.detailButton addTarget:self action:@selector(clickForDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([senderAnnotation.title isEqualToString:self.userID]){
            annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:[self.userInfo objectForKey:@"name"]];
        }
        else {
            annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:[self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[senderAnnotation.title intValue]]]];
        }
        annota.calloutImageView.messageLabel.text = [annota.calloutImageView.messageLabel.text stringByAppendingString:@"的一条信息"];
        senderAnnotation.calloutViewOfPin = annota;
        [annota setCanShowCallout:NO];
    }
     
     
     
    result=annota;
    UIImage *pinImage=[UIImage imageNamed:@"smile.png"];
    if (pinImage!=nil) {
        annota.image=pinImage;
    } 
     
    result=annota;
     
    return result;
    
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
    NSLog(@"detect the sendCarrot-button pressed");
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
        ACAddCarrotViewController *addCarrotViewController=[[ACAddCarrotViewController alloc] initWithLatitude:location2D.latitude withLongtitude:location2D.longitude withUserInfo:self.userInfo];
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
        float setY = 304.0f;//拉上去的Y点
        float beforeSetY = 548.0f;
        if (paramSender.view.center.y==beforeSetY) {
            
            //CG上拉路径设置
            
            CGMutablePathRef thePath=CGPathCreateMutable();
            CGPathMoveToPoint(thePath, NULL, 80.0f, beforeSetY);
            CGPathAddLineToPoint(thePath, NULL, 80.0f, setY);
            CGPathAddCurveToPoint(thePath, NULL, 80.0f, setY-15, 80.0f, setY+10, 80.0f, setY-6);
            CGPathAddLineToPoint(thePath, NULL, 80.0f, setY);
            CAKeyframeAnimation *theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            //CA path设置
            theAnimation.path=thePath;
            CAAnimationGroup *theGroup=[CAAnimationGroup animation];
            theGroup.animations=[NSArray arrayWithObject:theAnimation];
            
            theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            theGroup.duration=1.0f;
            
            CFRelease(thePath);
            [self.leftCornerView.layer addAnimation:theGroup forKey:@"positon"];
            paramSender.view.center=CGPointMake(80.0f, setY);
            
          //  NSLog(@"testtesttesttesttesttest %f", self.leftCornerView.center.y);
        }
        
        else if(paramSender.view.center.y==setY){
            CGMutablePathRef thePath=CGPathCreateMutable();
            CGPathMoveToPoint(thePath, NULL, 80.0f, setY);
            CGPathAddLineToPoint(thePath, NULL, 80.0f, beforeSetY);
            CGPathAddCurveToPoint(thePath, NULL, 80.0f, beforeSetY+10, 80.0f, beforeSetY-5, 80.0f,beforeSetY-3);
            CGPathAddLineToPoint(thePath, NULL, 80.0f, beforeSetY);
            CAKeyframeAnimation *theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            theAnimation.path=thePath;
            CAAnimationGroup *theGroup=[CAAnimationGroup animation];
            theGroup.animations=[NSArray arrayWithObject:theAnimation];
            
            theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            theGroup.duration=0.2f;
            
            CFRelease(thePath);
            [self.leftCornerView.layer addAnimation:theGroup forKey:@"position"];
            paramSender.view.center=CGPointMake(80.0f, beforeSetY);
            
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
//            CGMutablePathRef moveToMiddle=CGPathCreateMutable();
//            CGPathMoveToPoint(moveToMiddle, NULL, judge.x, judge.y);
//            CGPathAddLineToPoint(moveToMiddle, NULL, 160, 240);//目标地址是MapView中点
//            CAKeyframeAnimation *moveAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//            
//            moveAnimation.path=moveToMiddle;
//            [paramSender.view.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
//            
            //设置Group来共同执行Animation
            /*CAAnimationGroup *group=[CAAnimationGroup animation];
             group.animations=[NSArray arrayWithObjects:pulseAnimation, moveToMiddle, nil];
             
             [paramSender.view.layer addAnimation:group forKey:nil];*/
            
            ACMyViewViewController *myViewViewController = [[ACMyViewViewController alloc]initWithUserInfo:[JPDataManager sharedInstance].userInfo];
            [self presentModalViewController:myViewViewController animated:YES];
            
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

        if (section == 0){
            return [[[JPDataManager sharedInstance] GeneralprivateCarrots] count];
        }
        else if (section == 1){
            return [[[JPDataManager sharedInstance ]GeneralpublicCarrots] count];
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
                JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralprivateCarrots] objectAtIndex:indexPath.row];
                /*cell.title.text = @"From";
                cell.title.text = [cell.title.text stringByAppendingString:[self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[tmp.senderID intValue]]]];*/
                if ([tmp.senderID isEqualToString:self.userID]) {
                    cell.title.text = [self.userInfo objectForKey:@"name"];
                }
                else{
                    cell.title.text = [self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[tmp.senderID intValue]]];
                    /*cell.subtitle.text = tmp.message;*/
                }
            }
            else {
                JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralpublicCarrots] objectAtIndex:indexPath.row];
                /*cell.title.text = @"From:";
                cell.title.text = [cell.title.text stringByAppendingString:[self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[tmp.senderID intValue]]]];*/
                
                if ([tmp.senderID isEqualToString:self.userID]) {
                    cell.title.text = [self.userInfo objectForKey:@"name"];
                }
                else{
                    cell.title.text = [self.idMappingDictionary objectForKey:[NSNumber numberWithInt:[tmp.senderID intValue]]];
                    /*cell.subtitle.text = tmp.message;*/
                }
                /*cell.subtitle.text = tmp.message;*/           
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
            NSString *numbersOfPrivate = [[NSString alloc] init];
            numbersOfPrivate = [numbersOfPrivate stringByAppendingString:@"私有萝卜 "];
            numbersOfPrivate = [numbersOfPrivate stringByAppendingString:[NSString stringWithFormat:@"%d", [[JPDataManager sharedInstance].GeneralprivateCarrots count]]];
            return numbersOfPrivate;
        }
        else {
            NSString *numbersOfPublic = [[NSString alloc] init];
            numbersOfPublic = [numbersOfPublic stringByAppendingString:@"公有萝卜 "];
            numbersOfPublic = [numbersOfPublic stringByAppendingString:[NSString stringWithFormat:@"%d", [[JPDataManager sharedInstance].GeneralpublicCarrots count]]];
            return numbersOfPublic;
        }
    }
    return result;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float result = 0.0f;
    if ([tableView isEqual:self.leftCornerTableView]){
        return 44.0f;
    }
    
    return result;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralprivateCarrots] objectAtIndex:indexPath.row];
        CLLocationCoordinate2D tmpLocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        [self.myMapView setCenterCoordinate:tmpLocation animated:YES];
    }
    else {
        JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralpublicCarrots] objectAtIndex:indexPath.row];
        CLLocationCoordinate2D tmpLocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        [self.myMapView setCenterCoordinate:tmpLocation animated:YES];
    }
}

#pragma mark - 异步的函数，实现和拉用户数据，拉萝卜有关的函数

- (void)didGetUserInfoMapView
{
    NSLog(@"didGetUserInfo");
    //拿到用户的信息数据
    self.userInfo =[[NSDictionary alloc] initWithDictionary:[[JPDataManager sharedInstance] userInfo]];
    self.userID = [self.userInfo objectForKey:@"uid"];
    [self.userInfo objectForKey:@"name"];
    [self.userInfo objectForKey:@"tinyurl"];
    NSLog(@"%@", self.userID);
    
    
    
    //拉了用户数据以后开始拉id-Mapping
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetIdMappingMapView) name:@"didGetIdMapping" object:nil];
    [[JPDataManager sharedInstance] getIdMapping];
}

- (void)didGetIdMappingMapView
{
    NSLog(@"didGetIdMapping");
    self.idMappingDictionary = [JPDataManager sharedInstance].idMapping;
    
    //拉了id-Mapping以后开始拉私有的萝卜
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPrivateCarrotsMapView) name:@"didGetGeneralPrivateCarrots" object:nil];
    [[JPDataManager sharedInstance] getGeneralPrivateCarrotsWithUid:self.userID];
}

- (void)didGetGeneralPrivateCarrotsMapView
{
    //把拉到的私有萝卜存储在ViewController里面的数组里面
    NSLog(@"didGetGeneralPrivateCarrots");
    [self.generalPrivateCarrots addObjectsFromArray:[JPDataManager sharedInstance].GeneralprivateCarrots];
    NSLog(@"Numbers of Carrots in the View's general private carrots %u", [self.generalPrivateCarrots count]);
    NSLog(@"Numbers of Carrots in the DataManager's general private carrots %u", [[JPDataManager sharedInstance].GeneralprivateCarrots count]);
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralprivateCarrots );
    
    
    //拉完私有萝卜以后就可以开始拉公有的萝卜
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrotsMapView) name:@"didGetGeneralPublicCarrots" object:nil];
    [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:self.userID withNumber:5];
}

- (void)didGetGeneralPublicCarrotsMapView
{
    NSLog(@"didGetGeneralPublicCarrots");
    //把拉到的公有萝卜存储在ViewController里面的数组里面
    [self.generalPublicCarrots addObjectsFromArray:[JPDataManager sharedInstance].GeneralpublicCarrots];
    NSLog(@"Numbers of Carrots in the View's general public carrots %u", [self.generalPublicCarrots count]);
    NSLog(@"Numbers of Carrots in the DataManager's general public carrots %u", [[JPDataManager sharedInstance].GeneralpublicCarrots count]);
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralpublicCarrots);
    
    
    //拉到数据以后重新reload一下 TableView(包括它的Cells)
    [self.leftCornerTableView reloadData];
 
    
    
    //把所有的公有萝卜转化成Annotation然后加到mapView里面
    self.carrotOnMap = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [[[JPDataManager sharedInstance] GeneralpublicCarrots] count]; i++){
        JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralpublicCarrots] objectAtIndex:i];
        CLLocationCoordinate2D tmplocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        SYSUMyAnnotation *tmpAnno = [[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.senderID subtitle:tmp.message];
        tmpAnno.carrot = tmp;
        [self.carrotOnMap addObject:tmpAnno];
        [self.myMapView addAnnotation:tmpAnno];
    }
    //把所有的私有萝卜转化成Annotation然后加到mapView里面
    for (i = 0; i < [[[JPDataManager sharedInstance] GeneralprivateCarrots] count]; i++){
        JPCarrot *tmp = [[[JPDataManager sharedInstance] GeneralprivateCarrots] objectAtIndex:i];
        CLLocationCoordinate2D tmplocation = CLLocationCoordinate2DMake(tmp.latitude, tmp.longitude);
        SYSUMyAnnotation *tmpAnno = [[SYSUMyAnnotation alloc] initWithCoordinate:tmplocation title:tmp.senderID subtitle:tmp.message];
        tmpAnno.carrot = tmp;
        [self.carrotOnMap addObject:tmpAnno];
        [self.myMapView addAnnotation:tmpAnno];
    }
    
    //在这个异步结束的地方，最后最后把view 的interaction改成YES
    self.view.userInteractionEnabled = YES; 
    
    if ([self.userType isEqualToString:@"Tourist"]){
        self.rightCornerView.userInteractionEnabled = NO;
        self.bunnyUpperRight.userInteractionEnabled = NO;
    }

}

#pragma mark - 摇动手机拔萝卜有关的函数

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    NSLog(@"shake motion detected");
//    static BOOL didShake = 0;
//    if (event.type==UIEventSubtypeMotionShake && !didShake && self.nearbyCarrot != nil) {
//        
//        NSLog(@"the nearbyCarrot to be pulled out %@", self.nearbyCarrot);
//        NSLog(@"the carrotID of the nearbyCarrot %@", self.nearbyCarrot.carrotID);
//        
//        didShake = 1;
//        //去拉萝卜detail的数据，当然主要是message，对它是公有还是私有作判断
//        if (self.nearbyCarrot.isPublic == 1){
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPublicCarrotMapView) name:@"didGetDetailPublicCarrots" object:nil];
//            [[JPDataManager sharedInstance] getDetailPublicCarrotWithGeneralCarrot:self.nearbyCarrot];
//        }
//        else {
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPrivateCarrotMapView) name:@"didGetDetailPrivateCarrots" object:nil];
//            [[JPDataManager sharedInstance] getDetailPrivateCarrotWithGeneralCarrot:self.nearbyCarrot];
//        }
//    }
}

//- (void)clickForDetail:(id)sender
//{
//    MyUIButton *button = (MyUIButton*)sender;
////    NSLog(@"%@", button.carrot);
//}

- (void)didGetDetailPublicCarrotMapView
{
    NSLog(@"didGetDetailPublicCarrotMapView");
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
    
    //初始化一个DetailView
    
    
    //这里如果是private的话可能出现一个bug
    //就是因为已经getDetailPrivate了的话会把萝卜从数据库上面清除掉，然后就没有办法来init了
    
    ACCarrotDetialViewController *detailViewController = [[ACCarrotDetialViewController alloc] initWithCarrot:[JPDataManager sharedInstance].detailCarrot];
    detailViewController.view.backgroundColor = [UIColor greenColor];
    [detailViewController.view setFrame:CGRectMake(50, 50, 150, 150)];
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (void)didGetDetailPrivateCarrotMapView
{
    NSLog(@"didGetDetailPrivateCarrotMapView");
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
    
    ACCarrotDetialViewController *detailViewController = [[ACCarrotDetialViewController alloc] initWithCarrot:[JPDataManager sharedInstance].detailCarrot];
    detailViewController.view.backgroundColor = [UIColor greenColor];
    [detailViewController.view setFrame:CGRectMake(50, 50, 150, 150)];
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationSlideBottomBottom];
    
    //最后进入更新机制
    [self renewData];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - 更新机制
//两种种情况下需要更新机制
//发了萝卜以后（viewDidAppear）
//拔了私有萝卜以后
- (void)renewData
{
//    2. annotation（在didGetGeneral用JP单例初始化）
//    3. annotationView （mapView的一个delegate，见到annotation后调用）
//    (property)carrotOnMap（储存pin）（init:在didGetGeneralPublic后；用:在CLLocation Delegate里面）
 
    
    //  已经解决的问题
    //    4. (property)generalPublicCarrots（储存carrot）
    //    (property)generalPrivateCarrot（解决方法：全部改成JP单例）

//1. 重新加载cell
    [self.leftCornerTableView reloadData];

//2. 重新加载annotation
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefreshGeneralPrivateCarrots) name:@"didGetGeneralPrivateCarrots" object:nil];
    [[JPDataManager sharedInstance] refreshGeneralPrivateCarrotsWithUid:self.userID];
}

- (void)didRefreshGeneralPrivateCarrots
{
    NSLog(@"didRefreshGeneralPrivateCarrots");
}

@end
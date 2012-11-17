//
//  BBViewController.m
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-15.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "BBViewController.h"
#import "BBCell.h"
#import <QuartzCore/QuartzCore.h>

#define KEY_TITLE @"title"
#define KEY_IMAGE_NAME @"image_name"
#define KEY_IMAGE @"image"

@interface BBViewController ()
-(void)setupShapeFormationInVisibleCells;
-(void)loadDataSource;
-(float)getDistanceRatio;
@end

@implementation BBViewController

@synthesize mTableView;
@synthesize mDataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mTableView = [[UITableView alloc] init];
    [mTableView setBackgroundColor:[UIColor clearColor]];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.opaque=NO;
    mTableView.showsHorizontalScrollIndicator=NO;
    mTableView.showsVerticalScrollIndicator=NO;
    
    UILabel *mainTitle = (UILabel*) [self.view viewWithTag:100];
    mainTitle.text = @"CRICKET \n LEGENDS";
    [self loadDataSource];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupShapeFormationInVisibleCells];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupShapeFormationInVisibleCells];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mDataSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *test = @"table";
    BBCell *cell = (BBCell*)[tableView dequeueReusableCellWithIdentifier:test];
    if( !cell )
    {
        cell = [[BBCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
        
    }
    NSDictionary *info = [mDataSource objectAtIndex:indexPath.row];
    [cell setCellTitle:[info objectForKey:KEY_TITLE]];
    [cell setIcon:[info objectForKey:KEY_IMAGE]];
    
    return cell;
}


#define HORIZONTAL_RADIUS_RATIO 0.8
#define VERTICAL_RADIUS_RATIO 1.2
#define HORIZONTAL_TRANSLATION -130.0;


-(float)getDistanceRatio
{
    return (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? VERTICAL_RADIUS_RATIO : HORIZONTAL_RADIUS_RATIO);
}

//本身就有的函数
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setupShapeFormationInVisibleCells];
}

//在转动的时候改变形状，通过改变每一个Cell的起始点x,y和angle
-(void)setupShapeFormationInVisibleCells
{
    NSArray *indexpaths = [mTableView indexPathsForVisibleRows];
    float shift = ((int)mTableView.contentOffset.y % (int)mTableView.rowHeight);  
    int totalVisibleCells =[indexpaths count];
    float y = 0.0;
    float radius = mTableView.frame.size.height/2.0f;//半径是整个tableView高度的一半
    float xRadius = radius;
    
    for( NSUInteger index =0; index < totalVisibleCells; index++ )
    {
        BBCell *cell = (BBCell*)[mTableView cellForRowAtIndexPath:[ indexpaths objectAtIndex:index]];
        CGRect frame = cell.frame;
        //we get the yPoint on the circle of this Cell
        y = (radius-(index*mTableView.rowHeight) );//ideal yPoint if the scroll offset is zero
        y+=shift;//add the scroll offset
        
        
        //We can find the x Point by finding the Angle from the Ellipse Equation of finding y
        //i.e. Y= vertical_radius * sin(t )
        // t= asin(Y / vertical_radius) or asin = sin inverse
        float angle = asinf(y/(radius));
        
        //Apply Angle in X point of Ellipse equation
        //i.e. X = horizontal_radius * cos( t )
        //here horizontal_radius would be some percentage off the vertical radius. percentage is defined by HORIZONTAL_RADIUS_RATIO
        //HORIZONTAL_RADIUS_RATIO of 1 is equal to circle
        float x = (floorf(xRadius*[self getDistanceRatio])) * cosf(angle );
        x = x + HORIZONTAL_TRANSLATION;
        
        frame.origin.x = x ;
        if( !isnan(x))
        {
            cell.frame = frame;
        }
    }
}



//实现把data.plist里面的图片装载进去mDataSource
-(void)loadDataSource
{
    //用plist 去load dataSource
    NSMutableArray *dataSource = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    mDataSource = [[NSMutableArray alloc] init];
    
    
    //这里是什么意思
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //包装好了的，实现画圆形头像的功能
        //generate image clipped in a circle
        for( NSDictionary * dataInfo in dataSource )
        {
            NSMutableDictionary *info = [dataInfo mutableCopy];
            UIImage *image = [UIImage imageNamed:[info objectForKey:KEY_IMAGE_NAME]];
            UIImage *finalImage = nil;
            UIGraphicsBeginImageContext(image.size);
            {
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                
                CGAffineTransform trnsfrm = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0, -1.0));//y轴倒影
                
                trnsfrm = CGAffineTransformConcat(trnsfrm, CGAffineTransformMakeTranslation(0.0, image.size.height));//平移
                
                CGContextConcatCTM(ctx, trnsfrm);//将transform应用在ctx上
                CGContextBeginPath(ctx);//beginPath
                CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height));//画椭圆
                CGContextClip(ctx);//clip:变成圆形
                CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);//在圆形里面画图
                finalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
            
            //最终把头像加到mDataSource
            [info setObject:finalImage forKey:KEY_IMAGE];
            
            [mDataSource addObject:info];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mTableView reloadData];
            [self setupShapeFormationInVisibleCells];
        });
    });
}

@end

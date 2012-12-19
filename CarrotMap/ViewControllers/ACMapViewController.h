//
//  ACMapViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
@interface ACMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

//地图有关
@property (nonatomic, strong) MKMapView *myMapView;
@property (nonatomic, strong) CLLocationManager* myManager;
@property (nonatomic, strong) CLGeocoder *myGeocoder;

@property (nonatomic, strong) UIImageView *rightCornerView;
@property (nonatomic, strong) UIImageView *LocationTrackingView;
@property (nonatomic, strong) UIImageView *leftCornerBackground;
@property (nonatomic, strong) UIView *leftCornerView;
@property (nonatomic, strong) UITableView *leftCornerTableView;
@property (nonatomic, strong) CALayer *leftCornerLayer;

@property (nonatomic, strong) UITapGestureRecognizer *insertCarrot;
@property (nonatomic, strong) UITapGestureRecognizer *tapToChangeMode;
@property (nonatomic, strong) UIPanGestureRecognizer *leftCornerPan;
@property (nonatomic, strong) UITapGestureRecognizer *tapOnPins;

//右上角有关新加
@property (nonatomic, strong) UIImageView *bunnyUpperRight;
@property (nonatomic, strong) UIPanGestureRecognizer *dragBunny;

//虚构出来的数据 给我的萝卜
//数组储存的是JPCarrot
@property (nonatomic, strong) NSArray *database;


//虚构数据之二 一键插萝卜以后 能够把萝卜添加进这个数组里面
//数组储存的是Annotation（正确的应该是萝卜）
@property (nonatomic, strong) NSMutableArray *theCarrotsISend;




//一下的property用于储存DataManager从数据库中拉到的信息／数据



//储存拉到的萝卜
@property (nonatomic, strong) NSMutableArray *generalPublicCarrots;
@property (nonatomic, strong) NSMutableArray *generalPrivateCarrots;


//储存用户的info
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSDictionary *userInfo;

//储存Pin所需要的Annotation信息
//需要把“萝卜”转换成Annotation
@property (nonatomic, strong) NSMutableArray *carrotOnMap;

@property (nonatomic, strong) NSString *userType;


//添加一个ID-Mapping列表来储存所有的用户信息
@property (nonatomic, strong) NSDictionary *idMappingDictionary;

//添加一个nearbyCarrot储存一个可以拔的萝卜
@property (nonatomic, strong) JPCarrot *nearbyCarrot;


- (id)initWithUserType:(NSString *)userLoginType;

@end
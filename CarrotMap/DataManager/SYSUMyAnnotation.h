//
//  SYSUMyAnnotation.h
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-10.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

//系统提供了一个继承于AnnotationView的Pin(我们常见的大头针)，然后提供了3种可选颜色给我们，就是以下三种。（这个宏的作用已经没有了，因为在新版本代码里我们自定义了Pin）
#define REUSABLE_PIN_RED @"Red" 
#define REUSABLE_PIN_GREEN @"Green" 
#define REUSABLE_PIN_PURPLE @"Purple"

@class SYSUMyAnnoCalloutView;
@class JPCarrot;

@interface SYSUMyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString * subtitle;
@property (nonatomic, unsafe_unretained)MKPinAnnotationColor pinColor;
@property (nonatomic, strong) SYSUMyAnnoCalloutView *calloutViewOfPin;
@property (nonatomic, strong) JPCarrot* carrot;


//增加一个CalloutView，使得通过大头针能访问它自己的CalloutView
/*@property (nonatomic, strong) SYSUMyAnnoCalloutView *calloutView;*/

//初始化我们的Annotation
-(id)initWithCoordinate:(CLLocationCoordinate2D)paramcoordinate title:(NSString *)paramtitle subtitle:(NSString *)paramsubtitle;

- (void)setWithCoordinate:(CLLocationCoordinate2D)paramcoordinate title:(NSString *)paramtitle subtitle:(NSString *)paramsubtitle;

//使用系统提供的PinAnnotation时的遗留产物，现在还在用仅是为了获取一个 Identifier(字符串，red,green,purple）
+(NSString *)reusableIdentifierForPinColor:(MKPinAnnotationColor)paramColor;

@end
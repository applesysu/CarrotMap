//
//  SYSUMyAnnotation.m
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-10.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SYSUMyAnnotation.h"
#import "SYSUMyAnnoCalloutView.h"
#import "SYSUMyAnnoCalloutView.h"
#import "JPCarrot.h"

@implementation SYSUMyAnnotation

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;
@synthesize pinColor;
@synthesize calloutViewOfPin;
@synthesize carrot;

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    coordinate = newCoordinate;
    
}

- (void)setWithCoordinate:(CLLocationCoordinate2D)paramcoordinate title:(NSString *)paramtitle subtitle:(NSString *)paramsubtitle
{
    
    self.coordinate=paramcoordinate;
    title=paramtitle;
    subtitle=paramsubtitle;
    pinColor=MKPinAnnotationColorGreen;
        
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)paramcoordinate title:(NSString *)paramtitle subtitle:(NSString *)paramsubtitle
{
    
    self=[super init];
    if (self!=nil) {
        self.coordinate=paramcoordinate;
        title=paramtitle;
        subtitle=paramsubtitle;
        pinColor=MKPinAnnotationColorGreen;
        
        self.carrot = [[JPCarrot alloc] init];
    }
    return  self;
}

+(NSString *)reusableIdentifierForPinColor:(MKPinAnnotationColor)paramColor{
    NSString *result=nil;
    
    switch (paramColor) {
        case MKPinAnnotationColorRed:
            result=REUSABLE_PIN_RED;
            break;
        case MKPinAnnotationColorGreen:
            result=REUSABLE_PIN_GREEN;
            break;
        case MKPinAnnotationColorPurple:
            result=REUSABLE_PIN_PURPLE;
            break;
    }
    return result;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


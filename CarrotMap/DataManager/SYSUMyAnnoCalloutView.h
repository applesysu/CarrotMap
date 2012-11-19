//
//  SYSUMyAnnoCalloutView.h
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-10.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <MapKit/MapKit.h>

@class SYSUMyCalloutImageView;
@class SYSUMyAnnotation;

@interface SYSUMyAnnoCalloutView : MKPinAnnotationView

@property (nonatomic, strong) SYSUMyCalloutImageView *calloutImageView;
@property (nonatomic, strong) SYSUMyAnnotation *correspondingAnnotation;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end

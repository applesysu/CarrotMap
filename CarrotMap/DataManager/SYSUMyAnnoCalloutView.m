//
//  SYSUMyAnnoCalloutView.m
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-10.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SYSUMyAnnoCalloutView.h"
#import "SYSUMyAnnotation.h"
#import "SYSUMyCalloutImageView.h"

@implementation SYSUMyAnnoCalloutView

@synthesize calloutImageView;
@synthesize correspondingAnnotation;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.calloutImageView = [[SYSUMyCalloutImageView alloc] initWithImage:[UIImage imageNamed:@"1callout.png"]];
        self.calloutImageView.messageLabel.text = annotation.title;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //demo需要定制
    //1.0版本需要根据ann的距离信息，然后定制View的内容，到时需要把UIImageView改成UIView，UIView里面包含一个label，然后根据距离的不同显示不同的信息
    
    
    //SYSUMyAnnotation *ann = self.annotation;
    
    //定制每个Pin callout的View
    if (selected){
        [self.calloutImageView setFrame:CGRectMake(-75, -100, 230, 130)];
        
        [self animateCalloutAppearance];
        [self addSubview:self.calloutImageView];
        [self setCanShowCallout:NO];
    }
    else
    {
        //Remove your custom view...
        [self.calloutImageView removeFromSuperview];
    }
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    self.calloutImageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 100);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        self.calloutImageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            self.calloutImageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                self.calloutImageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
}

@end
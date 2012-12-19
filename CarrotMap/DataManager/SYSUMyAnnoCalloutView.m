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
#import "ACCarrotDetialViewController.h"
#import "JPDataManager.h"
#import "UIViewController+MJPopupViewController.h"
#import "MyUIButton.h"

@implementation SYSUMyAnnoCalloutView

@synthesize calloutImageView;
@synthesize correspondingAnnotation;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.correspondingAnnotation = [[SYSUMyAnnotation alloc] init];
        self.correspondingAnnotation = annotation;
        
        self.calloutImageView = [[SYSUMyCalloutImageView alloc] initWithImage:[UIImage imageNamed:@"1callout.png"]];
        self.calloutImageView.messageLabel.text = annotation.title;
    }
    return self;//解释就是这里的return 没有成功
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
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
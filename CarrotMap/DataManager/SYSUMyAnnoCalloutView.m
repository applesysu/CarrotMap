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

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //demo需要定制
    //1.0版本需要根据ann的距离信息，然后定制View的内容，到时需要把UIImageView改成UIView，UIView里面包含一个label，然后根据距离的不同显示不同的信息
    
    
//    SYSUMyAnnotation *ann = self.annotation;
    
    //定制每个Pin callout的View
    if (selected){
        self.imageView = [[SYSUMyCalloutImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
        self.imageView.messageLabel.text = @"提示信息";
        [self.imageView setFrame:CGRectMake(0, 0, 0, 0)];
        [self.imageView sizeToFit];
        
        [self animateCalloutAppearance];
        [self addSubview:self.imageView];
    }
    else
    {
        //Remove your custom view...
        [self.imageView removeFromSuperview];
    }
    
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    self.imageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        self.imageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            self.imageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                self.imageView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
}

@end
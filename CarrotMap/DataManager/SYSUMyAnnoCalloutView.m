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
    
    
    SYSUMyAnnotation *ann = self.annotation;
    
    //定制每个Pin callout的View
    if (selected){
        self.imageView = [[SYSUMyCalloutImageView alloc] initWithImage:[UIImage imageNamed:@"Icon@2x.png"]];
        self.imageView.messageLabel.text = @"提示信息";
        [self.imageView setFrame:CGRectMake(24, 35, 0, 0)];
        [self.imageView sizeToFit];
        
        [self addSubview:self.imageView];
    }
    
}

@end
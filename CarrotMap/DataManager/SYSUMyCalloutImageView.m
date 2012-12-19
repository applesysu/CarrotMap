//
//  SYSUMyCalloutImageView.m
//  CarrotMap_demo_map
//
//  Created by 林 初阳 on 12-11-8.
//  Copyright (c) 2012年 王 瑞. All rights reserved.
//

#import "SYSUMyCalloutImageView.h"
#import "MyUIButton.h"

@implementation SYSUMyCalloutImageView

@synthesize messageLabel;
@synthesize detailButton;

- (id)initWithFrame:(CGRect)frame
{
    if (self){
        [self setUserInteractionEnabled:YES];
        //第一个Label
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 50;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabel];
        
        
        //初始化detailButton
//        CGRect buttonRect;
//        buttonRect.origin.x = 20;
//        buttonRect.origin.y = 75;
//        buttonRect.size.width = boundsForLabel.size.width-50;
//        buttonRect.size.height = 30;
//        self.detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [self.detailButton setFrame:buttonRect];
//        [self.detailButton setTitle:@"Click for detail" forState:UIControlStateNormal];
//        self.detailButton.userInteractionEnabled = YES;
//        //[self.detailButton addTarget:self action:@selector(clickForDetail) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.detailButton];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self){
        [self setUserInteractionEnabled:YES];
        //第一个Label
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 50;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabel];
        
        
        //初始化detailButton
//        CGRect buttonRect;
//        buttonRect.origin.x = 20;
//        buttonRect.origin.y = 75;
//        buttonRect.size.width = boundsForLabel.size.width-50;
//        buttonRect.size.height = 30;
//        self.detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [self.detailButton setFrame:buttonRect];
//        [self.detailButton setTitle:@"Click for detail" forState:UIControlStateNormal];
//        self.detailButton.userInteractionEnabled = YES;
//        //[self.detailButton addTarget:self action:@selector(clickForDetail) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.detailButton];
    }
    return self;//这里的return是成功的
}

@end

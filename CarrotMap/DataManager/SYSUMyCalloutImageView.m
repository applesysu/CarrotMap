//
//  SYSUMyCalloutImageView.m
//  CarrotMap_demo_map
//
//  Created by 林 初阳 on 12-11-8.
//  Copyright (c) 2012年 王 瑞. All rights reserved.
//

#import "SYSUMyCalloutImageView.h"

@implementation SYSUMyCalloutImageView

@synthesize messageLabel;
@synthesize messageLabelSecond;
@synthesize messageLabelThird;
@synthesize detailButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        //第一个Label
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 50;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabelSecond.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:self.messageLabel];
        //第二个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 80;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelSecond = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelSecond.backgroundColor = [UIColor clearColor];
        self.messageLabelSecond.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:self.messageLabelSecond];
        //第三个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 110;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelThird = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelThird.backgroundColor = [UIColor clearColor];
        self.messageLabelSecond.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:self.messageLabelThird];
        
        //初始化detailButton
        CGRect buttonRect;
        buttonRect.origin.x = boundsForLabel.origin.x;
        buttonRect.origin.y = boundsForLabel.origin.y + 40;
        buttonRect.size.width = boundsForLabel.size.width;
        buttonRect.size.height = boundsForLabel.size.height;
        self.detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.detailButton setFrame:buttonRect];
        [self.detailButton setTitle:@"Click for detail" forState:UIControlStateNormal];
        [self addSubview:self.detailButton];
        NSLog(@"ADD SUBVIEW");
        [self.detailButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
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
        CGRect buttonRect;
        buttonRect.origin.x = 20;
        buttonRect.origin.y = 80;
        buttonRect.size.width = boundsForLabel.size.width-50;
        buttonRect.size.height = 30;
        self.detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.detailButton setFrame:buttonRect];
        [self.detailButton setTitle:@"Click for detail" forState:UIControlStateNormal];
        self.detailButton.userInteractionEnabled = YES;
        [self addSubview:self.detailButton];
    }
    return self;
}

@end

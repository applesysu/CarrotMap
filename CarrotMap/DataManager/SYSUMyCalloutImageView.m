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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //第一个Label
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 50;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabel];
        //第二个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 80;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelSecond = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelSecond.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabelSecond];
        //第三个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 110;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelThird = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelThird.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabelThird];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self){
        //第一个Label
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 50;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabel];
        //第二个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 80;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelSecond = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelSecond.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabelSecond];
        //第三个Label
        boundsForLabel.origin.x = 20;
        boundsForLabel.origin.y = 110;
        boundsForLabel.size.width = self.bounds.size.width - 100;
        boundsForLabel.size.height = 20;
        self.messageLabelThird = [[UILabel alloc] initWithFrame:boundsForLabel];
        self.messageLabelThird.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageLabelThird];
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

@end

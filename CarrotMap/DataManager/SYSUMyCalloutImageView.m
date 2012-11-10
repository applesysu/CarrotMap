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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 10;
        boundsForLabel.origin.y = 10;
        boundsForLabel.size.width = self.bounds.size.width - 20;
        boundsForLabel.size.height = self.bounds.size.height - 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self){
        CGRect boundsForLabel;
        boundsForLabel.origin.x = 10;
        boundsForLabel.origin.y = 10;
        boundsForLabel.size.width = self.bounds.size.width - 20;
        boundsForLabel.size.height = self.bounds.size.height - 20;
        self.messageLabel = [[UILabel alloc] initWithFrame:boundsForLabel];
        
        [self addSubview:self.messageLabel];
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

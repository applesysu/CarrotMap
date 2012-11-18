//
//  SYSUMyCalloutImageView.h
//  CarrotMap_demo_map
//
//  Created by 林 初阳 on 12-11-8.
//  Copyright (c) 2012年 王 瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYSUMyCalloutImageView : UIImageView

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *messageLabelSecond;
@property (nonatomic, strong) UILabel *messageLabelThird;

- (id)initWithFrame:(CGRect)frame;

@end

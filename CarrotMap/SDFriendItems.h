//
//  SDFriendItems.h
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDFriendItems : UIView


@property(strong, nonatomic) UIImageView *friendHeader;



-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withLabel:(NSString *)name;
-(void)setImage:(UIImage *)image;
@end

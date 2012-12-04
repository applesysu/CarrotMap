//
//  SDFriendItems.h
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDFriendItems : UIView
{
    UIImageView *friendHeader;
    
}

@property(strong, nonatomic) UIImageView *friendHeader;
@property(strong, nonatomic) UIImageView *nameBackground;
@property(strong, nonatomic) UILabel *nameLabel;

-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withLabel:(NSString *)name;
-(void)setImage:(UIImage *)image;
@end

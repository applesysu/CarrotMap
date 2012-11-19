//
//  ACLoginViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACLoginViewController : UIViewController



@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *touristBtn;
@property (strong, nonatomic) UILabel *orLabel;
@property (strong, nonatomic) UIImageView *orImage;
@property (strong, nonatomic) UIImageView *logoView;
@property (strong, nonatomic) UIImageView *boxView;

- (void)loginBtnPressed;
- (void)TouristBtnPressed;
@end

//
//  ACMyViewViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMyCarrotsListViewController.h"

@interface ACMyViewViewController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *accountLabel;

@property (nonatomic, strong) UIButton *mySendedListButton;
@property (nonatomic, strong) UIButton *myReceivedListButton;
@property (nonatomic, strong) UIButton *myPublicListButton;

@property (nonatomic, strong) ACMyCarrotsListViewController *mySendedListController;
@property (nonatomic, strong) ACMyCarrotsListViewController *myReceivedListController;
@property (nonatomic, strong) ACMyCarrotsListViewController *myPublicListController;

//初始化接收到的用户信息
@property (nonatomic, strong) NSDictionary *userInformation;
/*@property (nonatomic) int numbersOfCarrotsSended;
@property (nonatomic) int numbersOfCarrotsReceived;*/


- (id)initWithUserInfo:(NSDictionary*)userInfo;

@end

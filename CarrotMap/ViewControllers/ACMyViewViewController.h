//
//  ACMyViewViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMyCarrotsListViewController.h"
#import "RNExpandingButtonBar.h"

@class RNExpandingButtonBar;

@interface ACMyViewViewController : UIViewController<RNExpandingButtonBarDelegate>{
    RNExpandingButtonBar *_bar;
}


@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageUpperView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImage *imageUpper;
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

@property (nonatomic, strong) RNExpandingButtonBar *bar;


- (id)initWithUserInfo:(NSDictionary*)userInfo;

@end

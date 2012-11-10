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

@property (nonatomic, strong) ACMyCarrotsListViewController *mySendedListController;
@property (nonatomic, strong) ACMyCarrotsListViewController *myReceivedListController;
@property (nonatomic, strong) ACMyCarrotsListViewController *myPublicListController;

- (id)initWithUserInfo:(NSDictionary*)userInfo withSendeds:(int)sendeds withReceiveds:(int)receiveds;

@end

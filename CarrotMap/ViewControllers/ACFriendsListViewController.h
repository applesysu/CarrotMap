//
//  ACFriendsListViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface ACFriendsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{

    UIToolbar *toolBar;
    UITableView *tableView;
    UIScrollView *theRecentScollView;
    UIScrollView *friendLineListView;
    NSArray *friendList;
    NSMutableArray *receiverIDList;
    
};

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *theRecentScollView;
@property (strong, nonatomic) NSMutableArray *friendNames;
@property (strong, nonatomic) UIScrollView *friendLineListView;
@property (strong, nonatomic) NSArray *friendList;
@property (strong, nonatomic) NSMutableArray *receiverIDList;


- (id)initWithFriendsList:(NSArray*)friendsList;


@end

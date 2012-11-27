//
//  ACFriendsListViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface ACFriendsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{

    UIToolbar *toolBar;
    UITableView *atableView;
    UIScrollView *theRecentScollView;
    UIScrollView *friendLineListView;
    NSArray *friendList;
    NSMutableArray *receiverIDList;
    int numOfScoll;
    
};

@property (strong, nonatomic) UITableView *atableView;
@property (strong, nonatomic) UIScrollView *theRecentScollView;
@property (strong, nonatomic) NSMutableArray *friendNames;
@property (strong, nonatomic) UIScrollView *friendLineListView;
@property (strong, nonatomic) NSArray *friendList;
@property (strong, nonatomic) NSMutableArray *receiverIDList;
@property (strong, nonatomic) UIImageView *connectMeLabelView;
@property (strong, nonatomic) UIImageView *littleCarrotView;
@property (strong, nonatomic) UIImageView *theWholeFriendListBackground;
@property (strong, nonatomic) UIImageView *recentScollViewBackground;

@property (strong, nonatomic) UISearchBar *searchForSingleFriend;
@property (strong, nonatomic) NSMutableArray *friendItemsUserForSearch;


- (id)initWithFriendsList:(NSArray*)friendsList;


@end

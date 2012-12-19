//
//  ACAddCarrotViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFriendsListViewController.h"
#import <CoreData/CoreData.h>
@interface ACAddCarrotViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    float laitutude;
    float longtitude;
    
    
    NSMutableArray *friendNames;
    UITextField *selectField;
    NSMutableArray *temparray;
    NSMutableArray * firstWord;
    NSMutableArray * firstTwoWords;
    UITableView *tipsTableView;
    UIButton *buttonToFriend;
    UIButton *buttonToPushCarrot;
    UITextView *testRestrict;
    NSArray *theSelectedFriends;
    NSArray *friendList;
    NSArray *receviers;
}



@property (nonatomic, strong) ACFriendsListViewController *friendsListViewController;

@property (strong, nonatomic) NSArray *receviers;
@property (strong, nonatomic) NSArray *friendList;
@property (strong, nonatomic) NSManagedObjectContext *manageedObjectContext;
@property (strong, nonatomic) NSMutableArray *friendNames;
@property (strong, nonatomic) UITextField *selectField;
@property (strong, nonatomic) NSMutableArray *temparray;
@property (strong, nonatomic) UITableView *tipsTableView;
@property (strong, nonatomic) NSMutableArray *firstWord;
@property (strong, nonatomic) NSMutableArray *firstTwoWords;
@property (strong, nonatomic) UIButton *buttonToFriend;
@property (strong, nonatomic) UITextView *testRestrict;
@property (strong, nonatomic) UIButton *buttonToPushCarrot;
@property (strong, nonatomic) NSArray *theSelectedFriends;
@property (strong, nonatomic) NSDictionary *ausrInfo;
@property (strong, nonatomic) UIImageView *theWholeBackground;
@property (strong, nonatomic) UIToolbar *topNavigation;
@property (strong, nonatomic) UIBarButtonItem *leftBackBar;
@property (strong, nonatomic) UIBarButtonItem *rightSenderBar;
@property (strong, nonatomic) UIToolbar *viewAddForKeyBaord;
@property (strong, nonatomic) UIImageView *smileImage;
@property (strong, nonatomic) UIImageView *sadImage;

-(id)initWithLatitude:(float)alatitude withLongtitude:(float)alongtitude withUserInfo:(NSDictionary *)userInformation;
@end

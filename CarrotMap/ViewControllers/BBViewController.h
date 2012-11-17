//
//  BBViewController.h
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-15.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBViewController : UIViewController<UITableViewDataSource,UIScrollViewDelegate>


@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *mDataSource;
@end
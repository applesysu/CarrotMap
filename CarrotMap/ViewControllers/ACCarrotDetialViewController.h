//
//  ACCarrotDetialViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-6.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCarrotDetialViewController : UIViewController

@property (nonatomic, strong) UILabel *senderNameLabel;
@property (nonatomic, strong) UILabel *detailMessageLabel;

- (id)initWithCarrot:(JPCarrot*)carrot;

@end

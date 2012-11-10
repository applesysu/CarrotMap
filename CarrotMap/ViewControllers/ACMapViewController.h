//
//  ACMapViewController.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACAddCarrotViewController.h"

@interface ACMapViewController : UIViewController

@property (nonatomic, strong) ACAddCarrotViewController *addCarrotViewController;

- (id)initWithGeneralCarrots:(NSArray*)generalCarrots;

@end

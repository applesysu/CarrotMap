//
//  ACMyViewViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACMyViewViewController.h"

@interface ACMyViewViewController ()

@end

@implementation ACMyViewViewController

@synthesize mySendedListController;
@synthesize myReceivedListController;
@synthesize myPublicListController;

@synthesize userInfo;

- (id)initWithUserInfo:(NSDictionary*)userInfo withSendeds:(int)sendeds withReceiveds:(int)receiveds
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

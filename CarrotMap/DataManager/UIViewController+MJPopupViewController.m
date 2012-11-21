//
//  UIViewController+MJPopupViewController.m
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-21.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "UIViewController+MJPopupViewController.h"

@interface UIViewController_MJPopupViewController ()

@end

@implementation UIViewController_MJPopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

//
//  ACCarrotDetialViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-6.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACCarrotDetialViewController.h"
@interface ACCarrotDetialViewController ()

@end

@implementation ACCarrotDetialViewController

@synthesize senderNameLabel;
@synthesize detailMessageLabel;

- (id)initWithCarrot:(JPCarrot*)carrot
{
    self = [super init];
    if (self) {
        self.senderNameLabel = [[UILabel alloc] init];
        [self.senderNameLabel setFrame:CGRectMake(5, 5, 120, 20)];
        self.senderNameLabel.text = carrot.senderID;
        [self.view addSubview:self.senderNameLabel];
        
        self.detailMessageLabel = [[UILabel alloc] init];
        [self.detailMessageLabel setFrame:CGRectMake(5, 30, 120, 70)];
        self.detailMessageLabel.text = carrot.message;
        [self.view addSubview:self.detailMessageLabel];
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

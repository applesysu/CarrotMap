//
//  ACMyViewViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACMyViewViewController.h"
#import "JPDataManager.h"

@interface ACMyViewViewController ()

@end

@implementation ACMyViewViewController

@synthesize backgroundImageView;
@synthesize imageView;
@synthesize headImageView;
@synthesize image;
@synthesize headImage;
@synthesize usernameLabel;
@synthesize accountLabel;

@synthesize myPublicListButton;
@synthesize mySendedListButton;
@synthesize myReceivedListButton;

@synthesize mySendedListController;
@synthesize myReceivedListController;
@synthesize myPublicListController;

@synthesize userInformation;

- (id)initWithUserInfo:(NSDictionary*)userInfo
{
    self = [super init];
    if (self) {
        self.userInformation = userInfo;
        /*self.numbersOfCarrotsSended = sendeds;
        self.numbersOfCarrotsReceived = receiveds;*/
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //设置背景图片
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infoBackground.png"]];
    [self.backgroundImageView setFrame:self.view.bounds];
    [self.view addSubview:self.backgroundImageView];
    
    //设置上方页面图片
    self.image = [UIImage imageNamed:@"infoUpper.png"];
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.imageView setFrame:CGRectMake(15, 15, 290, 200)];
    [self.backgroundImageView addSubview:self.imageView];
    
    //设置头像
    self.headImage = [self.userInformation objectForKey:@"tinyurl"];
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    [self.headImageView setFrame:CGRectMake(30, 30, 50, 50)];
    [self.backgroundImageView addSubview:self.headImageView];
    
    //设置label
    self.usernameLabel = [[UILabel alloc] init];
    [self.usernameLabel setFrame:CGRectMake(70, 70, 100, 20)];
    self.usernameLabel.text = [self.userInformation objectForKey:@"name"];
    [self.imageView addSubview:self.usernameLabel];
    
    self.accountLabel = [[UILabel alloc] init];
    [self.accountLabel setFrame:CGRectMake(70, 90, 100, 20)];
    self.accountLabel.text = [self.userInformation objectForKey:@"uid"];
    [self.imageView addSubview:self.accountLabel];
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

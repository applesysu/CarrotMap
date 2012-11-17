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
@synthesize imageUpperView;
@synthesize headImageView;
@synthesize imageUpper;
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

@synthesize bar = _bar;

- (id)initWithUserInfo:(NSDictionary*)userInfo
{
    self = [super init];
    if (self) {
        self.userInformation = userInfo;
        
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
    self.imageUpper = [UIImage imageNamed:@"infoUpper.png"];
    self.imageUpperView = [[UIImageView alloc] initWithImage:self.imageUpper];
    [self.imageUpperView setFrame:CGRectMake(15, 15, 290, 200)];
    [self.backgroundImageView addSubview:self.imageUpperView];
    
    //设置头像
    self.headImage = [self.userInformation objectForKey:@"tinyurl"];
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    [self.headImageView setFrame:CGRectMake(30, 30, 50, 50)];
    [self.backgroundImageView addSubview:self.headImageView];
    
    //设置label
    self.usernameLabel = [[UILabel alloc] init];
    [self.usernameLabel setFrame:CGRectMake(70, 70, 100, 20)];
    self.usernameLabel.text = [self.userInformation objectForKey:@"name"];
    [self.imageUpperView addSubview:self.usernameLabel];
    
    self.accountLabel = [[UILabel alloc] init];
    [self.accountLabel setFrame:CGRectMake(70, 90, 100, 20)];
    self.accountLabel.text = [self.userInformation objectForKey:@"uid"];
    [self.imageUpperView addSubview:self.accountLabel];
    
    
    
    
    
    
    
    UIImage *image = [UIImage imageNamed:@"red_plus_up.png"];
    UIImage *selectedImage = [UIImage imageNamed:@"red_plus_down.png"];
    UIImage *toggledImage = [UIImage imageNamed:@"red_x_up.png"];
    UIImage *toggledSelectedImage = [UIImage imageNamed:@"red_x_down.png"];
    
    /* ---------------------------------------------------------
     * Create the center for the main button and origin of animations
     * -------------------------------------------------------*/
    CGPoint center = CGPointMake(30.0f, 370.0f);
    
    /* ---------------------------------------------------------
     * Setup buttons
     * Note: I am setting the frame to the size of my images
     * -------------------------------------------------------*/
    CGRect buttonFrame = CGRectMake(0, 0, 32.0f, 32.0f);
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b1 setFrame:buttonFrame];
    [b1 setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(onNext) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b2 setImage:[UIImage imageNamed:@"lightbulb.png"] forState:UIControlStateNormal];
    [b2 setFrame:buttonFrame];
    [b2 addTarget:self action:@selector(onAlert) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b3 setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [b3 setFrame:buttonFrame];
    [b3 addTarget:self action:@selector(onModal) forControlEvents:UIControlEventTouchUpInside];
    NSArray *buttons = [NSArray arrayWithObjects:b1, b2, b3, nil];
    
    /* ---------------------------------------------------------
     * Init method, passing everything the bar needs to work
     * -------------------------------------------------------*/
    RNExpandingButtonBar *bar = [[RNExpandingButtonBar alloc] initWithImage:image selectedImage:selectedImage toggledImage:toggledImage toggledSelectedImage:toggledSelectedImage buttons:buttons center:center];
    
    /* ---------------------------------------------------------
     * Settings
     * -------------------------------------------------------*/
    [bar setDelegate:self];
    [bar setSpin:YES];
    
    /* ---------------------------------------------------------
     * Set our property and add it to the view
     * -------------------------------------------------------*/
    [self setBar:bar];
    [[self view] addSubview:[self bar]];
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

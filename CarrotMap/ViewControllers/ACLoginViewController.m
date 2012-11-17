//
//  ACLoginViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACLoginViewController.h"
#import "JPDataManager.h"
#import "ACMapViewController.h"
@interface ACLoginViewController ()

@end

@implementation ACLoginViewController

@synthesize loginBtn;
@synthesize touristBtn;
@synthesize orImage;
@synthesize orLabel;
@synthesize logoView;
@synthesize boxView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //登录按钮
        self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40,140,90,90)];
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"renren.png"] forState:UIControlStateNormal];
        //        [self.loginBtn setTitle:@"人人登录" forState:UIControlStateNormal];
        [self.loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
   
        //or分隔线
//        self.orImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"or.png"]];
//        [self.orImage setFrame:CGRectMake(30, 220, self.orImage.frame.size.width/2, self.orImage.frame.size.height/2)];
//        self.orLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 205, 30, 30)];
//        self.orLabel.text = @"or";
        
        //游客浏览按钮
        self.touristBtn = [[UIButton alloc] initWithFrame:CGRectMake(160,140,80, 90)];
        [self.touristBtn setBackgroundImage:[UIImage imageNamed:@"guest.png"] forState:UIControlStateNormal];
        //        [self.touristBtn setTitle:@"以游客身份浏览" forState:UIControlStateNormal];
        //        [self.touristBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.touristBtn addTarget:self action:@selector(TouristBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(id)init{
    self=[super init];
    if (self) {
        //登录按钮
        self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40,140,90,90)];
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"renren.png"] forState:UIControlStateNormal];
//        [self.loginBtn setTitle:@"人人登录" forState:UIControlStateNormal];
        [self.loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        //or分隔线
//        self.orImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"or.png"]];
//        [self.orImage setFrame:CGRectMake(30, 220, self.orImage.frame.size.width/2, self.orImage.frame.size.height/2)];
//        self.orLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 205, 30, 30)];
//        self.orLabel.text = @"or";
        
        //游客浏览按钮
        self.touristBtn = [[UIButton alloc] initWithFrame:CGRectMake(160,140,80, 90)];
        [self.touristBtn setBackgroundImage:[UIImage imageNamed:@"guest.png"] forState:UIControlStateNormal];
//        [self.touristBtn setTitle:@"以游客身份浏览" forState:UIControlStateNormal];
//        [self.touristBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.touristBtn addTarget:self action:@selector(TouristBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.logoView=[[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.logoView.image=[UIImage imageNamed:@"logoview.png"];
    [self.view addSubview:self.logoView];
    
    
    self.boxView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 280, 265)];
    self.boxView.image=[UIImage imageNamed:@"box.png"];
    self.boxView.userInteractionEnabled=YES;
    [self.view addSubview:self.boxView];
//    
    //关闭键盘背景按钮
//    UIButton *bgBtn = [[UIButton alloc] initWithFrame:self.view.frame];
//    [bgBtn addTarget:self action:@selector(bgPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bgBtn];
    
    
    
    
    //把控件添加到页面上
    [self.boxView addSubview:self.loginBtn];
//    [self.view addSubview:self.orImage];
//    [self.view addSubview:self.orLabel];
    [self.boxView addSubview:self.touristBtn];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.loginBtn=nil;
    self.orImage=nil;
    self.touristBtn=nil;
    self.orLabel=nil;
    self.logoView=nil;

}

- (void)loginBtnPressed;
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRenrenLogin) name:@"didRenrenLogin" object:nil];
    
    [[JPDataManager sharedInstance] RenrenLogin];

}

- (void)TouristBtnPressed
{
    ACMapViewController *mapViewController=[[ACMapViewController alloc] initWithUserType:@"Tourist"];
    [self presentModalViewController:mapViewController animated:YES];
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)didRenrenLogin{
    ACMapViewController *mapViewController=[[ACMapViewController alloc] initWithUserType:@"RenRenUser"];
       [self presentModalViewController:mapViewController animated:YES];
}
@end

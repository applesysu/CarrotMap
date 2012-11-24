//
//  ACTestViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-9.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACTestViewController.h"
#import "JPDataManager.h"
#import "JPLocalDataManager.h"
#import "Avatars.h"

@interface ACTestViewController ()

@end

@implementation ACTestViewController

@synthesize textView;

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"登录人人" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 20, 120, 40)];
    [btn addTarget:self action:@selector(btn1Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"拉好友" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(180, 20, 120, 40)];
    [btn addTarget:self action:@selector(btn2Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"拉公共萝卜概要" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 80, 120, 40)];
    [btn addTarget:self action:@selector(btn3Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"拉私有萝卜概要" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(180, 80, 120, 40)];
    [btn addTarget:self action:@selector(btn4Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"拉详细公共萝卜" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 140, 120, 40)];
    [btn addTarget:self action:@selector(btn5Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"拉详细私用萝卜" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(180, 140, 120, 40)];
    [btn addTarget:self action:@selector(btn6Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"发1公共萝卜" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 200, 120, 40)];
    [btn addTarget:self action:@selector(btn7Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"更新公共萝卜概" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(180, 200, 120, 40)];
    [btn addTarget:self action:@selector(btn8Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"发1私有萝卜" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 260, 120, 40)];
    [btn addTarget:self action:@selector(btn9Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"更新私用萝卜概" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(180, 260, 120, 40)];
    [btn addTarget:self action:@selector(btn10Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 320, 280, 280)];
    [self.textView setText:@"测试开始"];
    [self.view addSubview:self.textView];
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

#pragma mark - Btn Event

- (void) btn1Pressed
{
    NSLog(@"Button 1 Pressed");
    
    [[JPDataManager sharedInstance] RenrenLogout];
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRenrenLogin) name:@"didRenrenLogin" object:nil];
    
    [[JPDataManager sharedInstance] RenrenLogin];
}

- (void)didRenrenLogin
{
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetUserInfo) name:@"didGetUserInfo" object:nil];
    
    [[JPDataManager sharedInstance] getUserInfo];
}

- (void)didGetUserInfo
{
    [self.textView setText:[[JPDataManager sharedInstance].userInfo description]];
    NSLog(@"%@", [JPDataManager sharedInstance].userInfo);
}

- (void) btn2Pressed
{
    NSLog(@"Button 2 Pressed");
    
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetFriendsList) name:@"didGetFriendsList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDownloadAnAvatar:) name:@"didDownloadAnAvatar" object:nil];

    
    [[JPDataManager sharedInstance] getFriendsList];
    
}

- (void)didDownloadAnAvatar:(NSNotification*)ntf
{
    NSLog(@"didDownloadAnAvatar");
    NSLog(@"%d", [[JPDataManager sharedInstance].avatarMapping count] );
    NSLog(@"%@", [ntf.userInfo objectForKey:@"id"]);
}

- (void)didGetFriendsList
{
    [self.textView setText:@"拉好友成功"];
}

- (void) btn3Pressed
{
    NSLog(@"Button 3 Pressed");
    
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrots) name:@"didGetGeneralPublicCarrots" object:nil];
    
    [[JPDataManager sharedInstance] getGeneralPublicCarrotsWithUid:@"245318989" withNumber:10];
}

- (void)didGetGeneralPublicCarrots
{
    [self.textView setText:[[JPDataManager sharedInstance].GeneralpublicCarrots description]];
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralpublicCarrots );
}

- (void) btn4Pressed
{
    NSLog(@"Button 4 Pressed");
    
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPrivateCarrots) name:@"didGetGeneralPrivateCarrots" object:nil];
    
    [[JPDataManager sharedInstance] getGeneralPrivateCarrotsWithUid:@"245318989"];
}

- (void) didGetGeneralPrivateCarrots
{
    [self.textView setText:[[JPDataManager sharedInstance].GeneralprivateCarrots description]];
    NSLog(@"%d", [[JPDataManager sharedInstance].GeneralprivateCarrots count]);
    NSLog(@"%@", [JPDataManager sharedInstance].GeneralprivateCarrots);
}

- (void) btn5Pressed
{
    NSLog(@"Button 5 Pressed");
    
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPublicCarrots) name:@"didGetDetailPublicCarrots" object:nil];
    
    [[JPDataManager sharedInstance] getDetailPublicCarrotWithGeneralCarrot:[[JPDataManager sharedInstance].GeneralpublicCarrots objectAtIndex:0]];
    
}

- (void) didGetDetailPublicCarrots
{
    [self.textView setText:[[JPDataManager sharedInstance].detailCarrot description]];
    
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
}

- (void) btn6Pressed
{
    NSLog(@"Button 6 Pressed");
    
    //监听特定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPrivateCarrots) name:@"didGetDetailPrivateCarrots" object:nil];
    
    [[JPDataManager sharedInstance] getDetailPrivateCarrotWithGeneralCarrot:[[JPDataManager sharedInstance].GeneralprivateCarrots objectAtIndex:0]];
}

- (void) didGetDetailPrivateCarrots
{
    [self.textView setText:[[JPDataManager sharedInstance].detailCarrot description]];
    
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
}

- (void) btn7Pressed
{
    NSLog(@"Button 7 Pressed");
    
    JPCarrot *carrot = [[JPCarrot alloc] initPublicCarrotWithLogitude:@"1111.1" withLatitude:@"22222.2" withMessage:@"一根公共萝卜" withSenderID:@"245318989" withSendedTime:@"2012-11-8 11:02"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSendACarrotToServer) name:@"didSendACarrotToServer" object:nil];
    [[JPDataManager sharedInstance] sendACarrotToServer:carrot];
}

- (void) btn8Pressed
{
    NSLog(@"Button 8 Pressed");
    
//    [[JPDataManager sharedInstance] refreshGeneralPublicCarrotsWithUid:@"245318989" withNumber:10];
    
    [[JPDataManager sharedInstance] getIdMapping];
    
    NSLog(@"%@",[JPDataManager sharedInstance].idMapping );
}

- (void) btn9Pressed
{
    NSLog(@"Button 9 Pressed");
    
    NSString *message = [NSString stringWithFormat:@"山兔测试测试"];
    NSString *sendedTime = [NSString stringWithFormat:@"2012-11-8 2:10"];
    JPCarrot *carrot = [[JPCarrot alloc] initPrivateCarrotWithLogitude:@"22222.4" withLatitude:@"22222.4" withMessage:message withSenderID:@"245318989" withReceiversID:[NSArray arrayWithObjects:@"245318989", @"417923427", @"123456789", nil] withSendedTime:sendedTime];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSendACarrotToServer) name:@"didSendACarrotToServer" object:nil];
    
    [[JPDataManager sharedInstance] sendACarrotToServer:carrot];
}

- (void) didSendACarrotToServer
{
    NSLog(@"%@", [JPDataManager sharedInstance].detailCarrot);
    [self.textView setText:[[JPDataManager sharedInstance].detailCarrot description]];
}

- (void) btn10Pressed
{
    NSLog(@"Button 10 Pressed");
    
    //原刷新测试
    //[[JPDataManager sharedInstance] refreshGeneralPrivateCarrotsWithUid:@"245318989"];
    
    //数据库添加删除测试
//    JPLocalDataManager *local = [[JPLocalDataManager alloc] init];
//    JPCarrot *carrot = [[JPCarrot alloc] initForTest];
//    [local saveAReceivedCarrot:carrot withUid:@"245318989"];
//    [local saveASendedCarrot:carrot withUid:@"245318989"];
//    [local saveASawPublicCarrot:carrot withUid:@"245318989"];
//    
//    NSArray *arr1 = [local getMyReceivedCarrotsWithUid:@"245318989"];
//    NSArray *arr2 = [local getMySendedCarrotsWithUid:@"245318989"];
//    NSArray *arr3 = [local getSawPublicCarrotsWithUid:@"245318989"];
//    NSLog(@"%@",arr1);
//    NSLog(@"%@",arr2);
//    NSLog(@"%@",arr3);
    
    //真正意义上的萝卜测试
//    NSLog(@"%d", [[[JPDataManager sharedInstance] getSawPublicCarrotsWithUid:@"245318989"] count]);
//    NSLog(@"%d", [[[JPDataManager sharedInstance] getMySendedCarrotsWithUid:@"245318989"] count]);
//    NSLog(@"%d", [[[JPDataManager sharedInstance] getMyReceivedCarrotsWithUid:@"245318989"] count]);
    
    // 一些数据库测试函数
    //[[JPLocalDataManager sharedInstance] testLocalDataManager];
    
    //NSLog(@"%d", [[[JPLocalDataManager sharedInstance] visitPublicCarrots] count]);
    
    //更新好友列表
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetFriendsList) name:@"didGetFriendsList" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDownloadAnAvatar:) name:@"didDownloadAnAvatar" object:nil];
//    
//    [[JPDataManager sharedInstance] refreshFriendsList];
    
    
    // 测试之后，数据数有东西的
    NSArray *arr = [[JPLocalDataManager sharedInstance] visitAvatars];
    Avatars *a = [arr objectAtIndex:0];
    NSLog(@"%@", a.avatar);
}

@end

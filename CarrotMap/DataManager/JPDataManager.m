//
//  JPDataManager.m
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import "JPDataManager.h"
#import "JPParseServer.h"
#import "JPLocalDataManager.h"
#import "JPAvatarsDownloadOperation.h"

@interface JPDataManager ()
{
    JPParseServer *parseServer;
}

- (void)didGetGeneralPublicCarrots:(NSDictionary*)dict;
- (void)didgetGeneralPrivateCarrots:(NSDictionary*)dict;
- (void)didGetDetailPublicCarrot:(NSDictionary*)dict;
- (void)didGetDetailPrivateCarrot:(NSDictionary*)dict;


@end

@implementation JPDataManager

@synthesize userInfo;
@synthesize friendsList;
@synthesize idMapping;
@synthesize avatarMapping;
@synthesize GeneralpublicCarrots;
@synthesize GeneralprivateCarrots;
@synthesize detailCarrot;

+ (JPDataManager *)sharedInstance
{
    static JPDataManager *instance;
    
    @synchronized(self) {
        if (!instance) {
            instance = [[JPDataManager alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        parseServer = [[JPParseServer alloc] init];
        self.friendsList = [[NSArray alloc] init];
        self.idMapping = [[NSDictionary alloc] init];
        self.GeneralpublicCarrots = [[NSArray alloc] init];
        self.GeneralprivateCarrots = [[NSArray alloc] init];
    }
    return self;
}

- (void)RenrenLogin
{
    if ([[Renren sharedRenren] isSessionValid]) {
        NSLog(@"登录成功");
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didRenrenLogin" object:self];
    }
    else
        [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:self];
}

- (void)RenrenLogout
{
    if (![[Renren sharedRenren] isSessionValid]) {
        NSLog(@"退出成功");
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didRenrenLogout" object:self];
    }
    else
        [[Renren sharedRenren] logout:self];
}

- (void)getUserInfo
{
    if ( [self.userInfo count] != 0 ) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetUserInfo" object:self];
    }
    else {
        //从本地拉数据
        self.userInfo = [[JPLocalDataManager sharedInstance] getUserInfo];
        if ( [userInfo count] == 0 ) {
            //拉取用户信息
            ROUserInfoRequestParam *requestParam = [[ROUserInfoRequestParam alloc] init];
            requestParam.fields = [NSString stringWithFormat:@"uid,name,tinyurl"];
            [[Renren sharedRenren] getUsersInfo:requestParam andDelegate:self];
        }
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetUserInfo" object:self];
    }
}

- (void)getFriendsList
{
    if ([self.friendsList count] != 0 ) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetFriendsList" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didDownloadAllAvatars" object:self];
    }
    else {
        //从本地拉数据
        self.friendsList = [[JPLocalDataManager sharedInstance] getFriendsList];
        self.avatarMapping = [[JPLocalDataManager sharedInstance] getAvatars];
        if ( [friendsList count] == 0 )
            [self refreshFriendsList];
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetFriendsList" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didDownloadAllAvatars" object:self];
        }
    }
}

- (void)refreshFriendsList
{
    //拉取好友信息
    //设置参数，然后调用Renren单实例的方法就行了
    ROGetFriendsInfoRequestParam *requestParam_ = [[ROGetFriendsInfoRequestParam alloc] init];
    requestParam_.count = @"";   //当count变量为@“”时，才会拉到全部好友
    requestParam_.fields = @"id,name,tinyurl";
    [[Renren sharedRenren] getFriendsInfo:requestParam_ andDelegate:self];
}

- (void)getIdMapping
{
    if ( [self.idMapping count] != 0 ) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetIdMapping" object:self];
    }
    else{
        self.idMapping = [[JPLocalDataManager sharedInstance] getIdMapping];
        if ( [self.idMapping count] == 0 ) {
            [[JPDataManager sharedInstance] refreshFriendsList];
        }
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetIdMapping" object:self];
    }
}

- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid
{
    [self getGeneralPublicCarrotsWithUid:uid withNumber:10];
}

- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid withNumber:(int)number
{
    if ( [self.GeneralpublicCarrots count] != 0 ) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetGeneralPublicCarrots" object:self];
    }
    else {
        [self refreshGeneralPublicCarrotsWithUid:uid withNumber:number];
    }
}

- (void)getGeneralPrivateCarrotsWithUid:(NSString *)uid
{
    if ( [self.GeneralprivateCarrots count] != 0 ) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetGeneralPrivateCarrots" object:self];
    }
    else {
        [self refreshGeneralPrivateCarrotsWithUid:uid];
    }
}

- (void)getDetailPublicCarrotWithGeneralCarrot:(JPCarrot *)generalCarrot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPublicCarrot:) name:@"interNTF_getAPublicDetialCarrot" object:nil];
    
    [parseServer getAPublicDetialCarrot:generalCarrot];
}

- (void)getDetailPrivateCarrotWithGeneralCarrot:(JPCarrot *)generalCarrot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetDetailPrivateCarrot:) name:@"interNTF_getAPrivateDetialCarrot" object:nil];
    [parseServer getAPrivateDetialCarrot:generalCarrot];
}

- (void)sendACarrotToServer:(JPCarrot*)carrot
{
    self.detailCarrot = carrot;
    [parseServer sendACarrotToSever:carrot];
}

- (void)refreshGeneralPublicCarrotsWithUid:(NSString *)uid
{
    [self refreshGeneralPublicCarrotsWithUid:uid withNumber:10];
}

- (void)refreshGeneralPublicCarrotsWithUid:(NSString *)uid withNumber:(int)number
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetGeneralPublicCarrots:) name:@"interNTF_getGeneralPublicCarrots" object:nil];
    
    [parseServer getGeneralPublicCarrotsWithUid:uid withNum:number];
}

- (void)refreshGeneralPrivateCarrotsWithUid:(NSString*)uid
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didgetGeneralPrivateCarrots:) name:@"interNTF_getGeneralPrivateCarrots" object:nil];
    
    [parseServer getGeneralPrivateCarrots:uid];
}


- (NSArray*)getMySendedCarrotsWithUid:(NSString*)uid
{
    return [[JPLocalDataManager sharedInstance] getMySendedCarrotsWithUid:uid];
}

- (NSArray*)getMyReceivedCarrotsWithUid:(NSString*)uid
{
    return [[JPLocalDataManager sharedInstance] getMyReceivedCarrotsWithUid:uid];
}

- (NSArray*)getSawPublicCarrotsWithUid:(NSString *)uid
{
    return [[JPLocalDataManager sharedInstance] getSawPublicCarrotsWithUid:uid];
}

#pragma mark - Renren Delegate
- (void)renrenDidLogin:(Renren *)renren
{
    NSLog(@"登录成功");
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didRenrenLogin" object:self];
}

- (void)renrenDidLogout:(Renren *)renren
{
    NSLog(@"退出成功");
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didRenrenLogout" object:self];
}

- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse *)response
{
    
    NSArray *responseArray = (NSArray *)(response.rootObject);
    if ([responseArray count] == 1) {
        NSLog(@"拉取用户信息");
        ROUserResponseItem *item = [responseArray objectAtIndex:0];
        //取值
        NSMutableDictionary *tmpUserInfo = [[NSMutableDictionary alloc] init];
        [tmpUserInfo setObject:item.userId forKey:@"uid"];
        [tmpUserInfo setObject:item.name forKey:@"name"];
        [tmpUserInfo setObject:item.tinyUrl forKey:@"tinyUrl"];
        self.userInfo = [NSDictionary dictionaryWithDictionary:tmpUserInfo];
        
        //保存到本地
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:@"userInfo"];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetUserInfo" object:self];
    }
    else {
        NSLog(@"拉取好友成功");
        NSMutableArray *tmpFriendsList = [[NSMutableArray alloc] init];
        NSMutableDictionary *tmpIdMapping = [[NSMutableDictionary alloc] init];
        for ( int i = 0; i < [responseArray count]; i++  )
        {
            NSDictionary *tmpDict = [[responseArray objectAtIndex:i] responseDictionary];
            [tmpFriendsList addObject:tmpDict];
            [tmpIdMapping setObject:[tmpDict objectForKey:@"name"] forKey:[tmpDict objectForKey:@"id"]];
        }
        self.friendsList = [NSArray arrayWithArray:tmpFriendsList];
        self.idMapping = (NSDictionary *)[[NSDictionary alloc] initWithDictionary:tmpIdMapping copyItems:YES];
        NSLog(@"%@", self.friendsList);
        NSLog(@"%@", self.idMapping);
        
        //新建线程拉好友头像
        [[JPLocalDataManager sharedInstance] removeAvatars];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDownloadAnAvatar:) name:@"inter-NTF:didDownloadAnAvatar" object:nil];
        JPAvatarsDownloadOperation *avatarsDownloadOperaton = [[JPAvatarsDownloadOperation alloc] initWithFriendsList:self.friendsList];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:avatarsDownloadOperaton];
        
        //保存到本地
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.idMapping];
        [userDefaults setObject:self.friendsList forKey:@"friendsList"];
        [userDefaults setObject:data forKey:@"idMapping"];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetFriendsList" object:self];
    }
}

#pragma mark - Private Methods

- (void)didGetGeneralPublicCarrots:(NSNotification *)notification
{
    NSArray *pfObjectArr = [notification.userInfo objectForKey:@"content"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    // 此处有一个很荒谬的现象，为保证每一个接口的耦合性，这里为了保存时各用户查看过的本地公共萝卜能区分，
    // 把uid赋值给receiverID，这里的可怜的uid又JPDataManager到ParseServer，然后又通过各种Notification回到JPDataManager这里，uid这东东在程序里游走了一圈，真是个可怜的家伙
    // 在完成的最后的最后，我想出了一个解决这个东东的方法了
    for (PFObject *object in pfObjectArr) {
        JPCarrot *tmpCarrot = [[JPCarrot alloc] initWithPFObject:object];
        NSLog(@"%@",[notification.userInfo objectForKey:@"uid"]);
        NSLog(@"%@",tmpCarrot);
        tmpCarrot.receiverID = [notification.userInfo objectForKey:@"uid"];
        NSLog(@"%@",tmpCarrot);
        [tmpArr addObject:tmpCarrot];
    }
    
    self.GeneralpublicCarrots = [[NSArray alloc] initWithArray:tmpArr];
    NSLog(@"%@", self.GeneralpublicCarrots);
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetGeneralPublicCarrots" object:self];
}

- (void)didgetGeneralPrivateCarrots:(NSNotification *)notification
{
    NSArray *pfObjectArr = [notification.userInfo objectForKey:@"content"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (PFObject *object in pfObjectArr)
        [tmpArr addObject:[[JPCarrot alloc] initWithPFObject:object]];
    
    self.GeneralprivateCarrots = [[NSArray alloc] initWithArray:tmpArr];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetGeneralPrivateCarrots" object:self];
}

- (void)didGetDetailPublicCarrot:(NSNotification*)notification
{
    self.detailCarrot = [notification.userInfo objectForKey:@"content"];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetDetailPublicCarrots" object:self];
}

- (void)didGetDetailPrivateCarrot:(NSNotification*)notification
{
    self.detailCarrot = [notification.userInfo objectForKey:@"content"];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetDetailPrivateCarrots" object:self];
    
}

- (void)didDownloadAnAvatar:(NSNotification*)notification
{
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.avatarMapping];
    [tmpDict setObject:[notification.userInfo objectForKey:@"content"] forKey:[notification.userInfo objectForKey:@"uid"]];
    self.avatarMapping = [NSDictionary dictionaryWithDictionary:tmpDict];
    
    //保存到本地
    [[JPLocalDataManager sharedInstance] saveAnAvatarWithUid:[notification.userInfo objectForKey:@"uid"] withAvatar:[notification.userInfo objectForKey:@"content"]];
}

@end

//
//  JPDataManager.h
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPDataManager : NSObject <RenrenDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSArray *friendsList;
@property (nonatomic, strong) NSDictionary *idMapping;
@property (nonatomic, strong) NSDictionary *avatarMapping;

@property (nonatomic, strong) NSArray *GeneralpublicCarrots;
@property (nonatomic, strong) NSArray *GeneralprivateCarrots;
@property (nonatomic, strong) JPCarrot *detailCarrot;

+ (JPDataManager *)sharedInstance;

// 人人接口
- (void)RenrenLogin;
- (void)RenrenLogout;
- (void)getUserInfo;
- (void)getFriendsList;
- (void)refreshFriendsList;
- (void)getIdMapping;

// 萝卜接口
- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid;
- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid withNumber:(int)number;
- (void)getGeneralPrivateCarrotsWithUid:(NSString *)uid;
- (void)getDetailPublicCarrotWithGeneralCarrot:(JPCarrot *)generalCarrot;
- (void)getDetailPrivateCarrotWithGeneralCarrot:(JPCarrot *)generalCarrot;
- (void)sendACarrotToServer:(JPCarrot*)carrot;
- (void)refreshGeneralPublicCarrotsWithUid:(NSString *)uid;
- (void)refreshGeneralPublicCarrotsWithUid:(NSString *)uid withNumber:(int)number;
- (void)refreshGeneralPrivateCarrotsWithUid:(NSString*)uid;

// 本地萝卜接口
- (NSArray*)getMySendedCarrotsWithUid:(NSString*)uid;
- (NSArray*)getMyReceivedCarrotsWithUid:(NSString*)uid;
- (NSArray*)getSawPublicCarrotsWithUid:(NSString*)uid;

@end

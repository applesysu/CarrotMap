//
//  JPLocalDataManager.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-9.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPLocalDataManager : NSObject

+ (JPLocalDataManager *)sharedInstance;

- (NSDictionary*) getUserInfo;
- (NSArray*) getFriendsList;
- (NSDictionary*) getIdMapping;
- (void) saveUserInfo:(NSDictionary*)userInfo;
- (void) saveFriendsList:(NSArray*)friendsList;
- (void) saveIdMapping:(NSDictionary*)idMapping;
- (void) saveAnAvatarWithUid:(NSString*)uid withAvatar:(NSData*)data;
- (NSDictionary *) getAvatars;
- (void) removeAvatars;

- (NSArray*) getMySendedCarrotsWithUid:(NSString*)uid;
- (NSArray*) getMyReceivedCarrotsWithUid:(NSString*)uid;
- (NSArray*) getSawPublicCarrotsWithUid:(NSString*)uid;
- (BOOL) saveASendedCarrot:(JPCarrot*)carrot;
- (BOOL) saveAReceivedCarrot:(JPCarrot*)carrot;
- (BOOL) saveASawPublicCarrot:(JPCarrot*)carrot;

- (void) testLocalDataManager;
- (NSArray*) visitPublicCarrots;
- (NSArray*)visitAvatars;

@end

//
//  JPAvatarsDownloadOperation.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-19.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "JPAvatarsDownloadOperation.h"

@implementation JPAvatarsDownloadOperation

- (id)initWithFriendsList:(NSArray *)argFriendsList
{
    self = [super init];
    if (self) {
        friendsList = argFriendsList;
    }
    return self;
}

- (void) main
{
    NSLog(@"Operaton Start!");
    for (NSDictionary *friend in friendsList) {
        NSURL *url = [NSURL URLWithString:[friend objectForKey:@"tinyurl"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[friend objectForKey:@"id"] forKey:@"uid"];
        [dict setObject:data forKey:@"content"];
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"inter-NTF:didDownloadAnAvatar" object:self userInfo:dict]];
    }
    NSLog(@"Operaton Finish!");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didDownloadAllAvatars" object:self];
}

@end

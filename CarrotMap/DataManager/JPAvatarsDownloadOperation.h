//
//  JPAvatarsDownloadOperation.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPAvatarsDownloadOperation : NSOperation
{
    NSArray *friendsList;
}

- (id) initWithFriendsList:(NSArray *)argFriendsList;

@end

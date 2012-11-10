//
//  JPParseServer.h
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface JPParseServer : NSObject
{
    int sendTime;
}

- (void)sendACarrotToSever:(JPCarrot*)carrot;
- (void)getAPublicDetialCarrot:(JPCarrot *)generalCarrot;
- (void)getAPrivateDetialCarrot:(JPCarrot *)generalCarrot;
- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid withNum:(int)number;
- (void)getGeneralPrivateCarrots:(NSString*)uid;

@end

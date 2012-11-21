//
//  JPParseServer.m
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import "JPParseServer.h"
#import "JPDataManager.h"
#import "JPLocalDataManager.h"

@interface JPParseServer()
{
    JPCarrot *keepArgCarrot;
}

- (void) sendDetail:(JPCarrot*)carrot;
- (void) getAPrivateDetialCarrot_cont:(PFObject*)pfObject;
- (void) sendAErrorNotification;

@end

@implementation JPParseServer

- (void)sendACarrotToSever:(JPCarrot*)carrot
{
    NSArray *arr = [carrot getGeneralPFObjects];
    sendTime = [arr count];
    for (PFObject *object in arr) {
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                sendTime--;
                if (sendTime == 0)
                    [self sendDetail:carrot];
            }
            else
                [self sendAErrorNotification];
        }];
    }
}

- (void)getAPublicDetialCarrot:(JPCarrot *)generalCarrot
{
    keepArgCarrot = generalCarrot;
    PFQuery *dataTable = [PFQuery queryWithClassName:@"PublicDetailCarrot"];
    
    //Test
    NSLog(@"CarrotID: %@", generalCarrot.carrotID);
    
    [dataTable whereKey:@"carrotID" equalTo:generalCarrot.carrotID];
    [dataTable findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ( !error ) {
            //完成萝卜
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [keepArgCarrot setByDetailPFObject:[objects objectAtIndex:0]];
            [dict setObject:keepArgCarrot forKey:@"content"];
            //保存萝卜
            [[JPLocalDataManager sharedInstance] saveASawPublicCarrot:keepArgCarrot];
            //发送内部通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"interNTF_getAPublicDetialCarrot" object:self userInfo:dict];
        }
        else
            [self sendAErrorNotification];
    }];
}

- (void)getAPrivateDetialCarrot:(JPCarrot *)generalCarrot
{
    keepArgCarrot = generalCarrot;
    PFQuery *dataTable = [PFQuery queryWithClassName:@"PrivateDetailCarrot"];
    [dataTable whereKey:@"carrotID" equalTo:generalCarrot.carrotID];
    [dataTable findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //完成萝卜
            PFObject *object = [objects objectAtIndex:0];
            [keepArgCarrot setByDetailPFObject:object];
            //看详细萝卜的引用计数（这可能会产生同步问题）
            int retainCount = [[object objectForKey:@"retainCount"] intValue];
            retainCount--;
            if ( retainCount > 0 ) {
                [object setObject:[NSNumber numberWithInt:retainCount] forKey:@"retainCount"];
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error)
                        [self getAPrivateDetialCarrot_cont:generalCarrot.pfObject];
                    else
                        [self sendAErrorNotification];
                }];
            }
            else {
                [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded)
                        [self getAPrivateDetialCarrot_cont:generalCarrot.pfObject];
                    else
                        [self sendAErrorNotification];
                }];
            }
        }
        else
            [self sendAErrorNotification];
    }];
}

- (void)getGeneralPublicCarrotsWithUid:(NSString *)uid withNum:(int)number
{
    PFQuery *dataTable = [PFQuery queryWithClassName:@"PublicGeneralCarrot"];
    dataTable.limit = number;
    [dataTable addDescendingOrder:@"sendedTime"];
    [dataTable findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //发送内部通知
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:objects forKey:@"content"];
            [dict setObject:uid forKey:@"uid"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"interNTF_getGeneralPublicCarrots" object:self userInfo:dict];
        }
        else
            [self sendAErrorNotification];
    }];
}

- (void)getGeneralPrivateCarrots:(NSString*)uid
{
    PFQuery *dataTable = [PFQuery queryWithClassName:@"PrivateGeneralCarrot"];
    //NSString *regule = [NSString stringWithFormat:@".*%@.*", uid];
    [dataTable whereKey:@"receiverID" equalTo:uid];
    [dataTable findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //发送内部通知
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:objects forKey:@"content"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"interNTF_getGeneralPrivateCarrots" object:self userInfo:dict];
        }
        else
            [self sendAErrorNotification];
    }];
    
}

#pragma mark - Private Method

- (void) sendDetail:(JPCarrot*)carrot
{
    [[carrot getDetialPFObjects] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if ( !error ) {
            NSLog(@"发送萝卜成功！");
            //储存本地
            [[JPLocalDataManager sharedInstance] saveASendedCarrot:carrot];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didSendACarrotToServer" object:self];
        }
        else
            [self sendAErrorNotification];
    } ];
}

- (void) getAPrivateDetialCarrot_cont:(PFObject*)pfObject
{
    //删除
    [pfObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //Make me superise!! objc支持闭包这个东东！！！开心死我了！！
            //保存萝卜
            [[JPLocalDataManager sharedInstance] saveAReceivedCarrot:keepArgCarrot];
            //发送内部通知
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:keepArgCarrot forKey:@"content"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"interNTF_getAPrivateDetialCarrot" object:self userInfo:dict];
        }
        else
            [self sendAErrorNotification];
    } ];
}

- (void) sendAErrorNotification
{
    NSLog(@"您的网络状态不太理想，数据上传不成功，请重试");
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Netwrok Error!" object:self];
}

@end

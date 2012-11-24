//
//  JPLocalDataManager.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-9.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "JPLocalDataManager.h"
#import "SendedCarrots.h"
#import "ReceivedCarrots.h"
#import "SawPublicCarrots.h"
#import "ACAppDelegate.h"
#import "Avatars.h"
#import "Test.h"

@interface JPLocalDataManager()
{
    NSManagedObjectContext *managedObjectContext;
}

@end

@implementation JPLocalDataManager

+ (JPLocalDataManager *)sharedInstance
{
    static JPLocalDataManager *instance;
    
    @synchronized(self) {
        if (!instance) {
            instance = [[JPLocalDataManager alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        managedObjectContext = [(ACAppDelegate*)[[UIApplication sharedApplication] delegate]managedObjectContext];
    }
    return self;
}

- (NSDictionary*) getUserInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
}

- (NSArray*) getFriendsList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"friendsList"];
}


- (NSDictionary*) getIdMapping
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"idMapping"];
    if (data != nil)
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    else
        return nil;
}


- (void) saveUserInfo:(NSDictionary*)userInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
}


- (void) saveFriendsList:(NSArray*)friendsList
{
    [[NSUserDefaults standardUserDefaults] setObject:friendsList forKey:@"frindsList"];
}


- (void) saveIdMapping:(NSDictionary*)idMapping
{
    [[NSUserDefaults standardUserDefaults] setObject:idMapping forKey:@"idMapping"];
}

- (void)saveAnAvatarWithUid:(NSString *)uid withAvatar:(NSData *)data
{
    Avatars *avatars = (Avatars*)[NSEntityDescription insertNewObjectForEntityForName:@"Avatars" inManagedObjectContext:managedObjectContext];
    avatars.uid = [NSString stringWithFormat:@"%@", uid];
    avatars.avatar = data;
    
    NSError *error;
    if ([managedObjectContext save:&error]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:uid forKey:@"id"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didDownloadAnAvatar" object:self userInfo:dict];
    }
    else
        NSLog(@"本地存储失败");
    
}

- (NSDictionary *)getAvatars
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Avatars" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for ( Avatars *avatars in result ) {
//        NSLog(@"%@", avatars.avatar);
        [dict setObject:avatars.avatar forKey:avatars.uid];
    }
    
    return dict;
}

- (void)removeAvatars
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Avatars" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    
    for ( Avatars *avatar in result ) {
        [managedObjectContext deleteObject:avatar];
    }
}



- (NSArray*) getMySendedCarrotsWithUid:(NSString*)uid
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SendedCarrots" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"senderID = %@", uid];
    [request setPredicate:predicate];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    JPCarrot *carrot;
    for ( SendedCarrots *sendedCarrot in result ) {
        carrot = [[JPCarrot alloc] init];
        carrot.carrotID = sendedCarrot.carrotID;
        carrot.longitude = [sendedCarrot.longitude floatValue];
        carrot.latitude = [sendedCarrot.latitude floatValue];
        carrot.isPublic = [sendedCarrot.isPublic boolValue];
        carrot.senderID = sendedCarrot.senderID;
        carrot.sendedTime = sendedCarrot.sendedTime;
        carrot.message = sendedCarrot.message;
        carrot.image = sendedCarrot.image;
        carrot.voice = sendedCarrot.vioce;
        carrot.video = sendedCarrot.video;
        [tmpArr addObject:carrot];
    }
    
    return tmpArr;
}


- (NSArray*) getMyReceivedCarrotsWithUid:(NSString*)uid
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ReceivedCarrots" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"receiverID = %@", uid];
    [request setPredicate:predicate];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    JPCarrot *carrot;
    for ( ReceivedCarrots *receivedCarrot in result ) {
        carrot = [[JPCarrot alloc] init];
        carrot.carrotID = receivedCarrot.carrotID;
        carrot.longitude = [receivedCarrot.longitude floatValue];
        carrot.latitude = [receivedCarrot.latitude floatValue];
        carrot.isPublic = [receivedCarrot.isPublic boolValue];
        carrot.senderID = receivedCarrot.senderID;
        carrot.receiverID = receivedCarrot.receiverID;
        carrot.sendedTime = receivedCarrot.sendedTime;
        carrot.message = receivedCarrot.message;
        carrot.image = receivedCarrot.image;
        carrot.voice = receivedCarrot.vioce;
        carrot.video = receivedCarrot.video;
        [tmpArr addObject:carrot];
    }
    
    return tmpArr;
}

- (NSArray *)getSawPublicCarrotsWithUid:(NSString*)uid
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SawPublicCarrots" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"receiverID = %@", uid];
    [request setPredicate:predicate];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    JPCarrot *carrot;
    for ( SawPublicCarrots *sawPublicCarrot in result ) {
        carrot = [[JPCarrot alloc] init];
        carrot.carrotID = sawPublicCarrot.carrotID;
        carrot.longitude = [sawPublicCarrot.longitude floatValue];
        carrot.latitude = [sawPublicCarrot.latitude floatValue];
        carrot.isPublic = [sawPublicCarrot.isPublic boolValue];
        carrot.senderID = sawPublicCarrot.senderID;
        carrot.receiverID = sawPublicCarrot.receiverID;
        carrot.sendedTime = sawPublicCarrot.sendedTime;
        carrot.message = sawPublicCarrot.message;
        carrot.image = sawPublicCarrot.image;
        carrot.voice = sawPublicCarrot.vioce;
        carrot.video = sawPublicCarrot.video;
        [tmpArr addObject:carrot];
    }
    
    return tmpArr;
}

- (BOOL) saveASendedCarrot:(JPCarrot*)carrot
{
    SendedCarrots *sendedCarrot = (SendedCarrots*)[NSEntityDescription insertNewObjectForEntityForName:@"SendedCarrots" inManagedObjectContext:managedObjectContext];
    
    sendedCarrot.carrotID = carrot.carrotID;
    sendedCarrot.longitude = [NSNumber numberWithFloat:carrot.longitude];
    sendedCarrot.latitude = [NSNumber numberWithFloat:carrot.latitude];
    sendedCarrot.isPublic = [NSNumber numberWithBool:carrot.isPublic];
    sendedCarrot.senderID = carrot.senderID;
    sendedCarrot.receiversID = [carrot.receiversID description];
    sendedCarrot.sendedTime = carrot.sendedTime;
    sendedCarrot.message = carrot.message;
    sendedCarrot.image = carrot.image;
    sendedCarrot.vioce = carrot.voice;
    sendedCarrot.video = carrot.video;
    
    NSError *error;
    if ([managedObjectContext save:&error]) {
        NSLog(@"本地存储成功");
        return YES;
    }
    else {
        NSLog(@"本地存储失败");
        return NO;
    }
    
}

- (BOOL) saveAReceivedCarrot:(JPCarrot*)carrot
{
    ReceivedCarrots *receivedCarrot = (ReceivedCarrots*)[NSEntityDescription insertNewObjectForEntityForName:@"ReceivedCarrots" inManagedObjectContext:managedObjectContext];
    
    receivedCarrot.carrotID = carrot.carrotID;
    receivedCarrot.longitude = [NSNumber numberWithFloat:carrot.longitude];
    receivedCarrot.latitude = [NSNumber numberWithFloat:carrot.latitude];
    receivedCarrot.isPublic = [NSNumber numberWithBool:carrot.isPublic];
    receivedCarrot.senderID = carrot.senderID;
    receivedCarrot.receiverID = carrot.receiverID;
    receivedCarrot.receiversID = [carrot.receiversID description];
    receivedCarrot.sendedTime = carrot.sendedTime;
    receivedCarrot.message = carrot.message;
    receivedCarrot.image = carrot.image;
    receivedCarrot.vioce = carrot.voice;
    receivedCarrot.video = carrot.video;
    
    NSError *error;
    if ([managedObjectContext save:&error]) {
        NSLog(@"本地存储成功");
        return YES;
    }
    else {
        NSLog(@"本地存储失败");
        return NO;
    }
}

- (BOOL)saveASawPublicCarrot:(JPCarrot *)carrot
{
    SawPublicCarrots *sawPublicCarrot = (SawPublicCarrots*)[NSEntityDescription insertNewObjectForEntityForName:@"SawPublicCarrots" inManagedObjectContext:managedObjectContext];
    
    sawPublicCarrot.carrotID = carrot.carrotID;
    sawPublicCarrot.longitude = [NSNumber numberWithFloat:carrot.longitude];
    sawPublicCarrot.latitude = [NSNumber numberWithFloat:carrot.latitude];
    sawPublicCarrot.isPublic = [NSNumber numberWithBool:carrot.isPublic];
    sawPublicCarrot.senderID = carrot.senderID;
    sawPublicCarrot.receiverID = carrot.receiverID;
    sawPublicCarrot.sendedTime = carrot.sendedTime;
    sawPublicCarrot.message = carrot.message;
    sawPublicCarrot.image = carrot.image;
    sawPublicCarrot.vioce = carrot.voice;
    sawPublicCarrot.video = carrot.video;
    
    NSError *error;
    if ([managedObjectContext save:&error]) {
        NSLog(@"本地存储成功");
        return YES;
    }
    else {
        NSLog(@"本地存储失败");
        return NO;
    }
}

- (void)testLocalDataManager
{
    Test *test = (Test*)[NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:managedObjectContext];
    test.name = @"TTTTTTT";
    NSError *error;
    if ([managedObjectContext save:&error])
        NSLog(@"YES");
    else
        NSLog(@"NO");
}

- (NSArray *)visitPublicCarrots
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SawPublicCarrots" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    return result;
}

- (NSArray *)visitAvatars
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Avatars" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    return result;
}

@end

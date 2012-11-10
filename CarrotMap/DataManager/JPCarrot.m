//
//  JPCarrot.m
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import "JPCarrot.h"
#import <Parse/Parse.h>

@interface JPCarrot()

@end

@implementation JPCarrot

@synthesize carrotID;
@synthesize longitude;
@synthesize latitude;
@synthesize isPublic;
@synthesize senderID;
@synthesize receiverID;
@synthesize receiversID;
@synthesize sendedTime;
@synthesize message;
@synthesize image;
@synthesize voice;
@synthesize video;
@synthesize pfObject;

- (id) initForTest
{
    self = [super init];
    if (self) {
        self.carrotID = [NSString stringWithFormat:@"idididididid"];
        self.longitude = 12.3;
        self.latitude = 45.6;
        self.message = [NSString stringWithFormat:@"messagemessage"];;
        self.isPublic = NO;
        self.senderID = @"sendIDsendID";
        self.receiverID = @"245318989";
        self.receiversID = [NSArray arrayWithObjects:@"receiverID1", @"receiverID2", @"receiverID3", nil];
        self.sendedTime = @"sendedTimesendedTime";
    }
    return self;
}

- (id) initPrivateCarrotWithLogitude:(NSString*)argLongitude withLatitude:(NSString*)argLatitude withMessage:(NSString*)argMessage withSenderID:(NSString*)argSenderID withReceiversID:(NSArray*)argReceiversID withSendedTime:(NSString*)argSendedTime
{
    self = [super init];
    if (self) {
        self.carrotID = [NSString stringWithFormat:@"%@ %@", argSenderID, argSendedTime];
        self.longitude = [argLongitude floatValue];
        self.latitude = [argLatitude floatValue];
        self.message = argMessage;
        self.isPublic = NO;
        self.senderID = argSenderID;
        self.receiversID = argReceiversID;
        self.sendedTime = argSendedTime;
    }
    return self;
}

- (id) initPublicCarrotWithLogitude:(NSString*)argLongitude withLatitude:(NSString*)argLatitude withMessage:(NSString*)argMessage withSenderID:(NSString*)argSenderID withSendedTime:(NSString*)argSendedTime
{
    self = [super init];
    if (self) {
        self.carrotID = [NSString stringWithFormat:@"%@ %@", argSenderID, argSendedTime];
        self.longitude = [argLongitude floatValue];
        self.latitude = [argLatitude floatValue];
        self.message = argMessage;
        self.isPublic = YES;
        self.senderID = argSenderID;
        self.sendedTime = argSendedTime;
    }
    return self;
}

- (id) initWithPFObject:(PFObject*)PFObject
{
    if ([PFObject objectForKey:@"receiversID"]) {
        self = [self initPrivateCarrotWithLogitude:[PFObject objectForKey:@"longitude"]
                                      withLatitude:[PFObject objectForKey:@"latitude"]
                                       withMessage:[PFObject objectForKey:@"message"]
                                      withSenderID:[PFObject objectForKey:@"senderID"]
                                   withReceiversID:[PFObject objectForKey:@"receiversID"]
                                    withSendedTime:[PFObject objectForKey:@"sendedTime"]];
        self.receiverID = [PFObject objectForKey:@"receiverID"];
    }
    else
        self = [self initPublicCarrotWithLogitude:[PFObject objectForKey:@"longitude"]
                                     withLatitude:[PFObject objectForKey:@"latitude"]
                                      withMessage:[PFObject objectForKey:@"message"]
                                     withSenderID:[PFObject objectForKey:@"senderID"]
                                   withSendedTime:[PFObject objectForKey:@"sendedTime"]];
    
    self.pfObject = PFObject;
    NSLog(@"%@",self.carrotID);
    return self;
}

- (void) setByDetailPFObject:(PFObject*)PFObject
{
    if ([PFObject objectForKey:@"message"])
        self.message = [PFObject objectForKey:@"message"];
    if ([PFObject objectForKey:@"image"])
        self.image = [PFObject objectForKey:@"image"];
    if ([PFObject objectForKey:@"voice"])
        self.voice = [PFObject objectForKey:@"voice"];
    if ([PFObject objectForKey:@"video"])
        self.video = [PFObject objectForKey:@"video"];
}

- (NSArray*) getGeneralPFObjects
{
    PFObject *dataRecord;
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    if ( self.isPublic ) {
        dataRecord = [PFObject objectWithClassName:@"PublicGeneralCarrot"];
        [dataRecord setObject:[NSNumber numberWithFloat:self.longitude] forKey:@"longitude"];
        [dataRecord setObject:[NSNumber numberWithFloat:self.latitude] forKey:@"latitude"];
        [dataRecord setObject:self.senderID forKey:@"senderID"];
        [dataRecord setObject:self.sendedTime forKey:@"sendedTime"];
        [tmpArr addObject:dataRecord];
    }
    else {
        for (NSString* item in self.receiversID) {
            dataRecord = [PFObject objectWithClassName:@"PrivateGeneralCarrot"];
            [dataRecord setObject:item forKey:@"receiverID"];
            [dataRecord setObject:self.receiversID forKey:@"receiversID"];
            [dataRecord setObject:[NSNumber numberWithFloat:self.longitude] forKey:@"longitude"];
            [dataRecord setObject:[NSNumber numberWithFloat:self.latitude] forKey:@"latitude"];
            [dataRecord setObject:self.senderID forKey:@"senderID"];
            [dataRecord setObject:self.sendedTime forKey:@"sendedTime"];
            [tmpArr addObject:dataRecord];
        }
    }
    return tmpArr;
}

- (PFObject*) getDetialPFObjects
{
    PFObject *dataRecord;
    if ( self.isPublic )
        dataRecord = [PFObject objectWithClassName:@"PublicDetailCarrot"];
    else {
        dataRecord = [PFObject objectWithClassName:@"PrivateDetailCarrot"];
        [dataRecord setObject:[NSNumber numberWithInt:[self.receiversID count]] forKey:@"retainCount"];
    }
    [dataRecord setObject:self.carrotID forKey:@"carrotID"];
    if ( self.message != nil )
        [dataRecord setObject:self.message forKey:@"message"];
    if ( self.image != nil )
        [dataRecord setObject:self.image forKey:@"image"];
    if ( self.voice != nil )
        [dataRecord setObject:self.voice forKey:@"voice"];
    if ( self.video != nil )
        [dataRecord setObject:self.video forKey:@"video"];
    return dataRecord;
}

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"Carrot\n[[\tcarrotID : %@\n\tlongitude : %f\n\tlatitude : %f\n\tmessage : %@\n\tisPublic : %d\n\tsenderID : %@\n\treceiverID : %@\n\treceiversID : %@\n\tsendedTime : %@\n]]", self.carrotID, self.longitude, self.latitude, self.message, self.isPublic, self.senderID, self.receiverID, self.receiversID, self.sendedTime];
    return str;
}

@end

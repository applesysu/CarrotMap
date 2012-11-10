//
//  JPCarrot.h
//  DataManager
//
//  Created by Jacob Pan on 12-11-2.
//  Copyright (c) 2012年 Jacob Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;
@class JPGeneralCarrot;
@class JPDetailCarrot;

@interface JPCarrot : NSObject

@property (nonatomic, strong) NSString *carrotID;
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (nonatomic) BOOL isPublic;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSArray *receiversID;
@property (nonatomic, strong) NSString *receiverID;
@property (nonatomic, strong) NSString *sendedTime;

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSData *image;
@property (nonatomic, strong) NSData *voice;
@property (nonatomic, strong) NSData *video;

@property (nonatomic, strong) PFObject *pfObject;

- (id) initForTest;
- (id) initPrivateCarrotWithLogitude:(NSString*)argLongitude
                        withLatitude:(NSString*)argLatitude
                         withMessage:(NSString*)argMessage
                        withSenderID:(NSString*)argSenderID
                     withReceiversID:(NSArray*)argReceiversID
                      withSendedTime:(NSString*)argSendedTime;

- (id) initPublicCarrotWithLogitude:(NSString*)argLongitude
                       withLatitude:(NSString*)argLatitude
                        withMessage:(NSString*)argMessage
                       withSenderID:(NSString*)argSenderID
                     withSendedTime:(NSString*)argSendedTime;

- (id) initWithPFObject:(PFObject*)PFObject;
- (void) setByDetailPFObject:(PFObject*)PFObject;
- (NSArray*) getGeneralPFObjects;
- (PFObject*) getDetialPFObjects;

@end

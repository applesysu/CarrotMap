//
//  ReceivedCarrots.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-9.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReceivedCarrots : NSManagedObject

@property (nonatomic, retain) NSString * carrotID;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * isPublic;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * receiverID;
@property (nonatomic, retain) NSString * receiversID;
@property (nonatomic, retain) NSString * sendedTime;
@property (nonatomic, retain) NSString * senderID;
@property (nonatomic, retain) NSData * video;
@property (nonatomic, retain) NSData * vioce;

@end

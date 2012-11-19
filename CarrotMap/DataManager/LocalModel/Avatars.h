//
//  Avatars.h
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-19.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Avatars : NSManagedObject

@property (nonatomic, retain) NSData * avatar;
@property (nonatomic, retain) NSString * uid;

@end

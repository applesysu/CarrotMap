//
//  MyUIButton.m
//  CarrotMap
//
//  Created by JackieLam on 12/18/12.
//  Copyright (c) 2012 sysuAppleClub. All rights reserved.
//

#import "MyUIButton.h"
#import "JPCarrot.h"

@implementation MyUIButton

@synthesize carrot;



- (void)setCarrot:(JPCarrot *)_carrot
{
    self.carrot = [[JPCarrot alloc] init];
    self.carrot = _carrot;
}

@end

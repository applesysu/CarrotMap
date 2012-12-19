//
//  MyUIButton.h
//  CarrotMap
//
//  Created by JackieLam on 12/18/12.
//  Copyright (c) 2012 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPCarrot;

@interface MyUIButton : UIButton

@property (nonatomic, strong) JPCarrot* carrot;

- (void)setCarrot:(JPCarrot *)_carrot;

@end

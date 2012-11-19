//
//  SDRecentFriendList.m
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-12.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SDRecentFriendList.h"

@implementation SDRecentFriendList
@synthesize keyImage;


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withUIImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=5.0;
        
        keyImage=[[UIImageView alloc ] initWithFrame:CGRectMake(2.5, 2, 46,46)];
        
        
        keyImage.image=image;
        [self addSubview:keyImage];
    }
    return self;
}




@end

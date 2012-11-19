//
//  SDFriendItems.m
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SDFriendItems.h"
#import "JPDataManager.h"
@implementation SDFriendItems
@synthesize friendHeader;
@synthesize friendName;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        
        
        
        
        
        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withLabel:(NSString *)name{
    self=[super initWithFrame:frame];
    
    if (self) {
        self.friendHeader.image=image;
        self.friendName.text=name;
        
        self.friendHeader.frame=CGRectMake(10, 0, 50, 50);
        self.friendName.frame=CGRectMake(10, 55, 50, 10);
        self.friendName.textAlignment=UITextAlignmentCenter;
        self.friendName.font=[UIFont fontWithName:@"KaiTi_GB2312" size:20];
        [self addSubview:friendHeader];
        [self addSubview:friendName];

    }
    
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
    
    
//}


@end

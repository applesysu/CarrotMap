//
//  SDFriendItems.m
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SDFriendItems.h"

@implementation SDFriendItems
@synthesize friendName;
@synthesize friendHeader;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image withLabel:(NSString *)name{
    self=[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5.0;
            self.friendHeader=[[UIImageView alloc] initWithFrame:CGRectMake(3.5, 3.5, 73, 73)];
            self.friendHeader.image=image;
        self.friendHeader.layer.cornerRadius=5.0;
        self.friendHeader.layer.masksToBounds=YES;
//        self.friendHeader.backgroundColor=[UIColor blackColor];
//        self.friendName.text=name;
//        
//       
//    
//        self.friendName.frame=CGRectMake(10, 55, 50, 10);
//        self.friendName.textAlignment=UITextAlignmentCenter;
//        self.friendName.font=[UIFont fontWithName:@"KaiTi_GB2312" size:20];
        [self addSubview:friendHeader];
//        [self addSubview:friendName];
        
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

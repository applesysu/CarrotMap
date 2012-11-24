//
//  SDFriendItems.m
//  CarrotMap
//
//  Created by 王 瑞 on 12-11-11.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SDFriendItems.h"

@implementation SDFriendItems
@synthesize friendHeader;

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
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5.0;
        self.friendHeader=[[UIImageView alloc] initWithFrame:CGRectMake(3.5, 3.5, 73, 73)];
        self.friendHeader.image=image;
        self.friendHeader.layer.cornerRadius=5.0;
        self.friendHeader.layer.masksToBounds=YES;

        [self addSubview:friendHeader];

        
    }
    
    return self;
}

-(void)setImage:(UIImage *)image{
    self.friendHeader.image=image;
}
@end

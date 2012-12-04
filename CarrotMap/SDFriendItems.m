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
@synthesize nameBackground;
@synthesize nameLabel;

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
       // self.nameBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 58, 73, 10)];
      //  self.nameBackground.backgroundColor=[UIColor blackColor];
        self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 58, 73, 10)];
        self.nameLabel.text=name;
        self.nameLabel.textAlignment=UITextAlignmentCenter;
        self.nameLabel.font=[UIFont systemFontOfSize:10.0];
      //  self.nameLabel.textColor=[UIColor whiteColor];
        [self addSubview:friendHeader];
        [self.friendHeader addSubview:self.nameBackground];
        [self.friendHeader addSubview:self.nameLabel];
    }
    
    return self;
}

-(void)setImage:(UIImage *)image{
    self.friendHeader.image=image;
}
@end

//
//  SYSUCarrotCell.m
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-10.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "SYSUCarrotCell.h"

@implementation SYSUCarrotCell

@synthesize imageView, title, subtitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //定制各种property
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        self.imageView.image = [UIImage imageNamed:@"Icon.png"];
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 100, 20)];
        self.subtitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 100, 20)];
        [self addSubview:imageView];
        [self addSubview:self.title];
        [self addSubview:self.subtitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    // 选择该tableView以后进行定位
}

@end

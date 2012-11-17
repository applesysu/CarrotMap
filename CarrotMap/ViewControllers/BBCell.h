//
//  BBCell.h
//  CarrotMap
//
//  Created by 林 初阳 on 12-11-15.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BBCell : UITableViewCell
{
    UILabel *mCellTtleLabel;
    CALayer *mImageLayer;
}

-(void)setCellTitle:(NSString*)title;
-(void)setIcon:(UIImage*)image;

@end
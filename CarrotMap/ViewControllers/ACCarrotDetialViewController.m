//
//  ACCarrotDetialViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-6.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACCarrotDetialViewController.h"
#import "JPDataManager.h"
@interface ACCarrotDetialViewController ()

@end

@implementation ACCarrotDetialViewController

@synthesize senderNameLabel;
@synthesize detailMessageLabel;

- (id)initWithCarrot:(JPCarrot*)carrot
{
    self = [super init];
    if (self) {
        self.senderNameLabel = [[UILabel alloc] init];
        [self.senderNameLabel setFrame:CGRectMake(5, 5, 140, 20)];
        self.senderNameLabel.backgroundColor = [UIColor clearColor];
        self.senderNameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.senderNameLabel.text = @"来自:";
        NSLog(@"%d", [carrot.senderID intValue]);
        NSLog(@"%@", carrot.senderID);
        NSLog(@"%@", [[JPDataManager sharedInstance].userInfo objectForKey:@"uid"]);
        
        if ([carrot.senderID isEqualToString:[[JPDataManager sharedInstance].userInfo objectForKey:@"uid"]]){
            self.senderNameLabel.text = [self.senderNameLabel.text stringByAppendingString:[[JPDataManager sharedInstance].userInfo objectForKey:@"name"]];
        }
        else{
            self.senderNameLabel.text = [self.senderNameLabel.text stringByAppendingString:[[JPDataManager sharedInstance].idMapping objectForKey:[NSNumber numberWithInt:[carrot.senderID intValue]]]];
            
        }
        self.senderNameLabel.text = [self.senderNameLabel.text stringByAppendingString:@"的一条信息"];
        [self.view addSubview:self.senderNameLabel];
        
        self.detailMessageLabel = [[UILabel alloc] init];
        [self.detailMessageLabel setFrame:CGRectMake(5, 30, 140, 120)];
        self.detailMessageLabel.backgroundColor = [UIColor clearColor];
        self.detailMessageLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.detailMessageLabel.text = carrot.message;
        [self.view addSubview:self.detailMessageLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  ACFriendsListViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//

#import "ACFriendsListViewController.h"
#import "SDFriendItems.h"
#import "JPDataManager.h"
@interface ACFriendsListViewController ()

@end

@implementation ACFriendsListViewController
@synthesize theRecentScollView;
@synthesize friendNames;
@synthesize friendLineListView;
@synthesize tableView;
@synthesize friendList;

- (id)initWithStyle:(UITableViewStyle)style withFriends:(NSArray *)argFriends
{
    self = [super init];
    if (self) {
        friends = argFriends;
        
        
    }
    return self;
}


- (id)initWithFriendsList:(NSArray*)friendsList{
    self=[super init];
    if (self) {
        self.friendList=friendsList;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

  
    self.view.backgroundColor=[UIColor clearColor];
  
    toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(GetBack:)];
    NSArray *itemArray=[[NSArray alloc] initWithObjects:leftButton,nil];
    [toolBar setItems:itemArray animated:YES];
    [self.view addSubview:toolBar];
    
//    self.friendLineListView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 320, 360)];
//    self.friendLineListView.scrollEnabled=YES;
//    self.friendLineListView.pagingEnabled=YES;
//    self.friendLineListView.delegate=self;
//    self.friendLineListView.alwaysBounceVertical=YES;
//    [self.view addSubview:friendLineListView];
//    
//    self.theRecentScollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 52, 320, 68)];
//    self.theRecentScollView.scrollEnabled=YES;
//    self.theRecentScollView.pagingEnabled=YES;
//    self.theRecentScollView.delegate=self;
//    self.theRecentScollView.alwaysBounceHorizontal=YES;
//    [self.view addSubview:self.theRecentScollView];
//    NSString *name=@"wangrui";
//    UIImage *friendImage=[UIImage imageNamed:@"Icon.png"];
//    
//    SDFriendItems *firendItem=[[SDFriendItems alloc]  initWithFrame:CGRectMake(10,130 ,70, 70) withImage:friendImage withLabel:name];
//    [self.friendLineListView addSubview:firendItem];
//    firendItem.backgroundColor=[UIColor orangeColor];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 52, 320, 428) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark- Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [friendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
//    Friend *thisFriend=[friends objectAtIndex:indexPath.row];
    
    //    // 显示名字
    //    NSString *str = [NSString stringWithFormat:@"%@", [[friends objectAtIndex:indexPath.row] objectForKey:@"name"]];
//    [cell.textLabel setText:thisFriend.name];
    //
    //    // 显示头像
    //    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[friends objectAtIndex:indexPath.row] objectForKey:@"tinyurl"]]];
//    UIImage *image = [UIImage imageWithData:thisFriend.imagdata];
//    [cell.imageView setImage:image];
    
    return cell;
}


#pragma mark- Button methods

-(void)GetBack:(UIBarButtonItem *)paramSender{
    
    [self dismissModalViewControllerAnimated:YES];
}
@end

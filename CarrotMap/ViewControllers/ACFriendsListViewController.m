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
#import "ACAddCarrotViewController.h"
#import "SDRecentFriendList.h"
#import "SDFriendItems.h"
@interface ACFriendsListViewController ()

@end

@implementation ACFriendsListViewController
@synthesize theRecentScollView;
@synthesize friendNames;
@synthesize friendLineListView;
@synthesize tableView;
@synthesize friendList;
@synthesize receiverIDList;
@synthesize imageData;

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
    
    
    self.receiverIDList=[[NSMutableArray alloc] initWithCapacity:[friendList count]];
//    


    
    UIImageView *recentScollViewBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0,50, 320, 100)];
    recentScollViewBackground.userInteractionEnabled=YES;
    recentScollViewBackground.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:recentScollViewBackground];
    
//    
//    
    self.theRecentScollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20,30,280,50)];
    self.theRecentScollView.scrollEnabled=YES;
//    self.theRecentScollView.pagingEnabled=YES;
    self.theRecentScollView.delegate=self;
    self.theRecentScollView.alwaysBounceHorizontal=YES;
//    self.theRecentScollView.backgroundColor=[UIColor blueColor];
    
    NSMutableArray *imageDataArray=[[NSMutableArray alloc] initWithCapacity:15];
    for (int i=0;i<15;i++) {
        NSDictionary *single=[friendList objectAtIndex:i];
        NSString *imageString=[single objectForKey:@"tinyurl"];
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
        [imageDataArray addObject:imageData];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        
//        UIImageView *recentFriend=[[UIImageView alloc] initWithFrame:CGRectMake(i*48, 0, 40, 40)];
//        recentFriend.image=[UIImage imageNamed:@"Icon.png"];
//        [self.theRecentScollView addSubview:recentFriend];
//
        
        SDRecentFriendList *recentFriendItem=[[SDRecentFriendList alloc] initWithFrame:CGRectMake(i*56, 0, 50, 50) withUIImage:image];
//        SDRecentFriendList *recentFriendItem=[[[SDRecentFriendList alloc] initWithFrame:CGRectMake(i*56, 0, 50, 50)] withUIImage:[UIImage imageNamed:@"Icon.png"]];
        recentFriendItem.backgroundColor=[UIColor whiteColor];
        [self.theRecentScollView addSubview:recentFriendItem];
    }
    self.theRecentScollView.contentSize=CGSizeMake(48*friendList.count-8, 40);
    [recentScollViewBackground addSubview:self.theRecentScollView];

    //    NSString *name=@"wangrui";
//    UIImage *friendImage=[UIImage imageNamed:@"Icon.png"];
//
//    SDFriendItems *firendItem=[[SDFriendItems alloc]  initWithFrame:CGRectMake(10,130 ,70, 70) withImage:friendImage withLabel:name];
//    [self.friendLineListView addSubview:firendItem];
//    firendItem.backgroundColor=[UIColor orangeColor];
    
    
    //tradiction table view
//    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 52, 320, 428) style:UITableViewStyleGrouped];
//    self.tableView.delegate=self;
//    self.tableView.dataSource=self;
//    [self.view addSubview:self.tableView];
    
    NSLog(@"%@",[friendList objectAtIndex:0]);
    
    
    UIImageView *theWholeFriendListBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 140, 320, 340)];
    theWholeFriendListBackground.backgroundColor=[UIColor blueColor];
    theWholeFriendListBackground.layer.cornerRadius=12.0;
    theWholeFriendListBackground.userInteractionEnabled=YES;
    [self.view addSubview:theWholeFriendListBackground];
    
    
        self.friendLineListView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 300)];
    self.friendLineListView.backgroundColor=[UIColor whiteColor];
        self.friendLineListView.scrollEnabled=YES;
    //  self.friendLineListView.pagingEnabled=YES;
        self.friendLineListView.delegate=self;
        self.friendLineListView.alwaysBounceVertical=YES;
    self.friendLineListView.backgroundColor=[UIColor orangeColor];
        [theWholeFriendListBackground addSubview:friendLineListView];
    
//    for (int i=0; i<15; i++) {
//        int count=i+1;
//        UIImage *image=[[UIImage alloc] initWithData: [imageDataArray objectAtIndex:i]];
//        NSLog(@"%d",i%3);
    int counter=-1;
        for (int i=0;i<15;i++) {
            if (i%3==0) {
                counter++;
            }
            NSDictionary *single=[friendList objectAtIndex:i];
            NSString *imageString=[single objectForKey:@"tinyurl"];
           NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
            [imageDataArray addObject:imageData];
            UIImage *image=[[UIImage alloc] initWithData:imageData];
        SDFriendItems *item=[[SDFriendItems alloc] initWithFrame:CGRectMake(20+ 100*(i%3), 16+96*counter, 80,80) withImage:image withLabel:@""];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
            [item addGestureRecognizer:tap];
        [self.friendLineListView addSubview:item];
    }
    
    self.friendLineListView.contentSize=CGSizeMake(320, 16+96*15);
    
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
    
    NSDictionary *aDict=[friendList objectAtIndex:indexPath.row];
    cell.textLabel.text=[aDict objectForKey:@"name"];
    
//    Friend *thisFriend=[friends objectAtIndex:indexPath.row];
    
    //    // 显示名字
    //    NSString *str = [NSString stringWithFormat:@"%@", [[friends objectAtIndex:indexPath.row] objectForKey:@"name"]];
//    [cell.textLabel setText:thisFriend.name];
    //
    //    // 显示头像
    //    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[friends objectAtIndex:indexPath.row] objectForKey:@"tinyurl"]]];
//    UIImage *image = [UIImage imageWithData:thisFriend.imagdata];
//    [cell.imageView setImage:image];
    NSString *imageString=[aDict objectForKey:@"tinyurl"];
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    cell.imageView.image=image;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.textColor  isEqual:[UIColor orangeColor]]) {
        cell.textLabel.textColor=[UIColor blackColor];
        [self.receiverIDList removeObject:[friendList objectAtIndex:indexPath.row]];
    }else{
    cell.textLabel.textColor=[UIColor orangeColor];
    [self.receiverIDList addObject:[friendList objectAtIndex:indexPath.row]];
    }
    
}

#pragma mark- Button methods

-(void)GetBack:(UIBarButtonItem *)paramSender{
   
    ACAddCarrotViewController *add=(ACAddCarrotViewController *)self.presentingViewController;
    add.receviers=self.receiverIDList;
    [self dismissModalViewControllerAnimated:YES];
}

-(void)changeColor:(UITapGestureRecognizer *)paramSender{
    if (paramSender.state==UIGestureRecognizerStateEnded) {
        if ([paramSender.view.backgroundColor isEqual:[UIColor blueColor]]) {
            paramSender.view.backgroundColor=[UIColor whiteColor];
        }else {
            paramSender.view.backgroundColor=[UIColor blueColor];}
    }
}
@end

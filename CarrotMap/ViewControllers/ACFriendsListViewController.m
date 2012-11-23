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
@synthesize atableView;
@synthesize friendList;
@synthesize receiverIDList;
@synthesize connectMeLabelView;
@synthesize littleCarrotView;
@synthesize theWholeFriendListBackground;
@synthesize searchForSingleFriend;

- (id)initWithStyle:(UITableViewStyle)style withFriends:(NSArray *)argFriends
{
    self = [super init];
    if (self) {
    }
    return self;
}


-(id)initWithFriendsList:(NSArray*)friendsList{
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
    
    
    
    
    self.receiverIDList=[[NSMutableArray alloc] initWithCapacity:[friendList count]];
   
    UIImageView *recentScollViewBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0,50, 320, 80)];
    recentScollViewBackground.userInteractionEnabled=YES;
 //  recentScollViewBackground.image=[UIImage imageNamed:@"lefttop.png"];
   //recentScollViewBackground.backgroundColor=[UIColor orangeColor];
    
   
    
    UIImageView *leftTopView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 110, 60)];
    leftTopView.image=[UIImage imageNamed:@"lefttop.png"];


   
    self.theRecentScollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20,17,280,50)];
    self.theRecentScollView.scrollEnabled=YES;
    self.theRecentScollView.delegate=self;
    self.theRecentScollView.alwaysBounceHorizontal=YES;

    
//    NSMutableArray *imageDataArray=[[NSMutableArray alloc] initWithCapacity:15];
    for (int i=0;i<friendList.count;i++) {
      //  NSDictionary *single=[friendList objectAtIndex:i];
       // NSString *imageString=[single objectForKey:@"tinyurl"];
        //NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
        //[imageDataArray addObject:imageData];
        //UIImage *image=[[UIImage alloc] initWithData:imageData];
          
        SDRecentFriendList *recentFriendItem=[[SDRecentFriendList alloc] initWithFrame:CGRectMake(i*56, 0, 50, 50) withUIImage:[UIImage imageNamed:@"Icon.png"]];
        recentFriendItem.backgroundColor=[UIColor whiteColor];
        [self.theRecentScollView addSubview:recentFriendItem];
    }
    self.theRecentScollView.contentSize=CGSizeMake(48*friendList.count-8, 40);
   

    
    NSLog(@"%@",[friendList objectAtIndex:0]);
    
    
    theWholeFriendListBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 430)];
//    theWholeFriendListBackground.backgroundColor=[UIColor blueColor];
    theWholeFriendListBackground.layer.cornerRadius=12.0;
    theWholeFriendListBackground.userInteractionEnabled=YES;
    theWholeFriendListBackground.image=[UIImage imageNamed:@"littlecarrot.png"];
    [self.view addSubview:theWholeFriendListBackground];
    
    
    
    self.searchForSingleFriend=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 130, 320, 50)];
    self.searchForSingleFriend.delegate=self;
    
  //  self.searchForSingleFriend.backgroundImage=[UIImage imageNamed:@"search.png"];
    
    
    
    self.friendLineListView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, 320, 250)];
    self.friendLineListView.backgroundColor=[UIColor whiteColor];
    self.friendLineListView.scrollEnabled=YES;
    self.friendLineListView.delegate=self;
    self.friendLineListView.alwaysBounceVertical=YES;
//    self.friendLineListView.backgroundColor=[UIColor orangeColor];
    
    
//    NSLog(@"%@",[JPDataManager sharedInstance].avatarMapping);

    int counter=-1;
    for (int i=0;i<friendList.count;i++) {
            if (i%3==0)
            {
                counter++;
            }
        NSDictionary *single=[friendList objectAtIndex:i];
       // NSString *imageString=[single objectForKey:@"tinyurl"];
         NSNumber *nameForImage=[single objectForKey:@"id"];
     //   NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
      //  [imageDataArray addObject:imageData];
       // UIImage *image=[[UIImage alloc] initWithData:imageData];
       // NSLog(@"%@",[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]);
        UIImage *image=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]];
        if (image==nil) {
            image=[UIImage imageNamed:@"Icon.png"];
        }
        SDFriendItems *item=[[SDFriendItems alloc] initWithFrame:CGRectMake(20+ 100*(i%3), 16+96*counter, 80,80) withImage:image withLabel:@""];
        item.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
        [item addGestureRecognizer:tap];
        [self.friendLineListView addSubview:item];
    }
    
    self.friendLineListView.contentSize=CGSizeMake(320, 16+96*(friendList.count/3+1));
    
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSingleFriendImage:) name:@"didDownAnAvatar" object:nil];

    [[JPDataManager sharedInstance] getFriendsList];
 
    
    [self.theWholeFriendListBackground addSubview:leftTopView];
    [self.theWholeFriendListBackground addSubview:recentScollViewBackground];
    [self.theWholeFriendListBackground addSubview:self.searchForSingleFriend];
    [theWholeFriendListBackground addSubview:friendLineListView];
    [recentScollViewBackground addSubview:self.theRecentScollView];    
    [self.view addSubview:toolBar];
}

- (void)viewDidUnload
{
    
    self.friendLineListView=nil;
    self.friendList=nil;
    self.friendNames=nil;
    self.theRecentScollView=nil;
    self.connectMeLabelView=nil;
    self.receiverIDList=nil;
    self.atableView=nil;
    self.littleCarrotView=nil;
    self.connectMeLabelView=nil;
    self.theWholeFriendListBackground=nil;
    self.searchForSingleFriend=nil;
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark- Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [friendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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
    NSLog(@"%@",self.receiverIDList);
    NSLog(@"%@",add.receviers);
    [self dismissModalViewControllerAnimated:YES];
}

-(void)changeColor:(UITapGestureRecognizer *)paramSender{
    if (paramSender.state==UIGestureRecognizerStateEnded) {
        if ([paramSender.view.backgroundColor isEqual:[UIColor blueColor]]) {
            paramSender.view.backgroundColor=[UIColor whiteColor];
            [receiverIDList removeObject:[friendList objectAtIndex:paramSender.view.tag]];
        }else {
            paramSender.view.backgroundColor=[UIColor blueColor];
            [receiverIDList addObject: [friendList objectAtIndex:paramSender.view.tag]];
            NSLog(@"%@",[friendList objectAtIndex:paramSender.view.tag]);
         
        }
        
    }
}


#pragma mark- Notification Methods
-(void)getSingleFriendImage:(id)paramSender{
    NSLog(@"Get A Avatar!");
    NSDictionary *getNameOfImage=(NSDictionary *)paramSender;
    NSString *name=[getNameOfImage objectForKey:@"id"];
    for (int i=0; i<friendList.count; i++) {
        NSDictionary *single=[friendList objectAtIndex:i];
        NSString *nameForImage=[single objectForKey:@"name"];
        if ([nameForImage isEqualToString:name]) {
            SDFriendItems *item=(SDFriendItems *)[self.view viewWithTag:i];
            item.image=[[JPDataManager sharedInstance].avatarMapping objectForKey:name];
            break;
        }
    }
    
}
@end

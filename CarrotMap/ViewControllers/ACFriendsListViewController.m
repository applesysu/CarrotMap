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
#import "UIImageView+WebCache.h"
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
@synthesize friendItemsUserForSearch;
@synthesize recentScollViewBackground;


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
        friendItemsUserForSearch =[[NSMutableArray alloc] initWithCapacity:friendList.count];
      //  NSLog(@"%d",friendItemsUserForSearch.count);
        numOfScoll=0;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

  
    self.view.backgroundColor=[UIColor clearColor];
    

   //工具栏
    toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(GetBack:)];
    UIBarButtonItem *sender=[[UIBarButtonItem alloc] initWithTitle:@"SenNoti" style:UIBarButtonItemStyleBordered target:self action:@selector(SenderNo)];
    NSArray *itemArray=[[NSArray alloc] initWithObjects:leftButton,sender,nil];
    [toolBar setItems:itemArray animated:YES];
    
    
    
    
    self.receiverIDList=[[NSMutableArray alloc] initWithCapacity:[friendList count]];
   
    //最近常联系的好友列表的背景
    recentScollViewBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0,50, 320, 80)];
    recentScollViewBackground.userInteractionEnabled=YES;
 //  recentScollViewBackground.image=[UIImage imageNamed:@"lefttop.png"];
   //recentScollViewBackground.backgroundColor=[UIColor orangeColor];
    
   
    
    UIImageView *leftTopView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 110, 60)];
    leftTopView.image=[UIImage imageNamed:@"lefttop.png"];


   //最近常联系的好友
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
        NSDictionary *single=[friendList objectAtIndex:i];
        NSString *nameForImage=[NSString stringWithFormat:@"%@", [single objectForKey:@"id"]];
        UIImage *image=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]];
        SDRecentFriendList *recentFriendItem=[[SDRecentFriendList alloc] initWithFrame:CGRectMake(i*56, 0, 50, 50) withUIImage:image];
        recentFriendItem.backgroundColor=[UIColor whiteColor];
        [self.theRecentScollView addSubview:recentFriendItem];
    }
    self.theRecentScollView.contentSize=CGSizeMake(48*friendList.count-8, 40);
   

    
 //   NSLog(@"%@",[friendList objectAtIndex:0]);
    
    //好友列表的背景
    theWholeFriendListBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 430)];
    theWholeFriendListBackground.layer.cornerRadius=12.0;
    theWholeFriendListBackground.userInteractionEnabled=YES;
    theWholeFriendListBackground.image=[UIImage imageNamed:@"littlecarrot.png"];
   
    
    
   //SearchBar
    self.searchForSingleFriend=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 130, 320, 50)];
    self.searchForSingleFriend.delegate=self;
    

    
    
    //好友全部列表
    self.friendLineListView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, 320, 250)];
    self.friendLineListView.backgroundColor=[UIColor whiteColor];
    self.friendLineListView.scrollEnabled=YES;
    self.friendLineListView.delegate=self;
    self.friendLineListView.alwaysBounceVertical=YES;
//    self.friendLineListView.backgroundColor=[UIColor orangeColor];
    
    
//    NSLog(@"%@",[JPDataManager sharedInstance].avatarMapping);

    
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSingleFriendImage:) name:@"didDownloadAnAvatar" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getALLFriendImages:) name:@"didDownloadAllAvatars" object:nil];
    //[[JPDataManager sharedInstance] getFriendsList];

    
    int counter=-1;
    for (int i=0;i<friendList.count;i++) {
        if (i%3==0)
        {
            counter++;
        }
        NSDictionary *single=[friendList objectAtIndex:i];
         NSString *imageString=[single objectForKey:@"tinyurl"];
       // NSString *nameForImage=[NSString stringWithFormat:@"%@", [single objectForKey:@"id"]];
         //     UIImage *image=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]];
      //  image=nil;
        
        //        NSLog(@"%@", nameForImage);
        //        NSLog(@"%@", [[JPDataManager sharedInstance].avatarMapping allKeys]);
            //    NSLog(@"%d", [[JPDataManager sharedInstance].avatarMapping count]);
        //        NSLog(@"%@",[[JPDataManager sharedInstance].avatarMapping objectForKey:@"339557652"] );
        
//        if (image==nil) {
//            image=[UIImage imageNamed:@"Icon.png"];
//        }
//        
        SDFriendItems *item=[[SDFriendItems alloc] initWithFrame:CGRectMake(20+ 100*(i%3), 16+96*counter, 80,80) withImage:nil withLabel:[single objectForKey:@"name"]];
        [item.friendHeader setImageWithURL:imageString placeholderImage:[UIImage imageNamed:@"Icon,png"]];
     //   [self.friendItems addObject:item];
        item.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
        [item addGestureRecognizer:tap];
        [self.friendLineListView addSubview:item];
    }
    
    self.friendLineListView.contentSize=CGSizeMake(320, 16+96*(friendList.count/3+1));
    


 
  //  NSLog(@"----- %d ---------",friendItems.count);
     [self.view addSubview:theWholeFriendListBackground];
    
    [self.theWholeFriendListBackground addSubview:leftTopView];
    [self.theWholeFriendListBackground addSubview:recentScollViewBackground];
    [self.theWholeFriendListBackground addSubview:self.searchForSingleFriend];
    [self.theWholeFriendListBackground addSubview:friendLineListView];
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
    self.friendItemsUserForSearch=nil;
    self.recentScollViewBackground=nil;
    
    [super viewDidUnload];

}

-(void)viewWillDisappear:(BOOL)animated{    
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didDownloadAnAvatar" object:nil];
    //[[NSNotificationCenter defaultCenter]  removeObserver:self name:@"didDownloadAllAvatars" object:nil];
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


-(void)SenderNo{
//    int i=0;
    [[JPDataManager sharedInstance] refreshFriendsList];
   
//
//
//    for (i; i<friendItems.count; i++) {
//        NSDictionary *single=[friendList objectAtIndex:i];
//        NSString *nameForImage=[NSString stringWithFormat:@"%@", [single objectForKey:@"id"]];
//    
//   SDFriendItems *item=[self.friendItems objectAtIndex:i];
//        item.friendHeader.image=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]];
// 
//        NSLog(@"%@",item);
//    }
   
}

#pragma mark- Notification Methods
-(void)getSingleFriendImage:(NSNotification*)notifation{
    NSLog(@"Get A Avatar!");
//    NSDictionary *getNameOfImage=notifation.userInfo;
//    NSString *name=[NSString stringWithFormat:@"%@", [getNameOfImage objectForKey:@"id"]];
   // NSLog(@"%@", name);
//    for (int i=0; i<friendList.count; i++) {
//        NSDictionary *single=[friendList objectAtIndex:i];
    //    NSLog(@"%d",i);h
//        NSString *nameForImage= [NSString stringWithFormat:@"%@",[single objectForKey:@"id"]];
  //      NSLog(@"%@",nameForImage);
//        if ([nameForImage isEqualToString:name]) {
//            SDFriendItems *item=[self.friendItems objectAtIndex:i];
//            NSLog(@"%@",item);
            //=(SDFriendItems *)[self.friendLineListView viewWithTag:i];
//           NSLog(@"%@",[[JPDataManager sharedInstance].avatarMapping objectForKey:name]);
//            NSLog(@"%d",i);
//          UIImage *image=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:nameForImage]];
//            if (image==nil) {
//                NSLog(@"SO GA!!");
//            }
         //   item.friendHeader.image=image;
//            [[JPDataManager sharedInstance].avatarMapping objectForKey:name];
     //       NSLog(@"%@",item);
//            [self changeTheImage:nameForImage];
//            break;
    
       
//        }
//    }
    
}

- (void)getALLFriendImages:(NSNotification*)notifation{
    NSLog(@"Get All Avatars!");

}


#pragma mark - Make the Change
-(void)changeTheImage:(NSString *)aName{
    NSLog(@"%@",aName);
//    SDFriendItems *Item=[self.friendItemsUserForSearch objectAtIndex:0];
//   UIImage *aImage=[[UIImage alloc] initWithData:[[JPDataManager sharedInstance].avatarMapping objectForKey:aName]];
//    UIImageView *aView=[[UIImageView alloc] initWithImage:aImage];
//    [self.view addSubview:aView];
}


#pragma mark - UIScollView Delegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([scrollView isEqual:self.friendLineListView]) {
       // NSLog(@"** %f ** %f **",velocity.x,velocity.y);
       // NSLog(@"## %f ## %f ##",targetContentOffset->x,targetContentOffset->y );
        if (numOfScoll==0) {
            if ((targetContentOffset->y)>10) {
            [UIView beginAnimations:@"scoll" context:nil];
            self.theWholeFriendListBackground.frame=CGRectMake(0, -90, 320, 570);
            self.friendLineListView.frame=CGRectMake(0, 180, 320, 340);
          //  NSLog(@"God Demn you!");
            [UIView commitAnimations];
            }
            numOfScoll=1;
        }
       
        if (targetContentOffset->y==0) {
            [UIView beginAnimations:@"scollBack" context:nil];
            self.theWholeFriendListBackground.frame=CGRectMake(0, 0, 320, 480);
            self.friendLineListView.frame=CGRectMake(0, 180, 320, 250);
            [UIView commitAnimations];
            numOfScoll=0;
        }
    }
}

#pragma mark - UISearchBar Delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //NSLog(@"I'm CancelButton");
     [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
  //  NSLog(@"I'm ResultsListButton");
}

-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    //NSLog(@"Mark Button Clicked!");
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   // NSLog(@"Search Button Clicked!");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([self.searchForSingleFriend isEqual:searchBar]) {
        for (int i=0;i<friendList.count;i++) {
            NSDictionary *sing=[self.friendList objectAtIndex:i];
            NSString *tempName=[sing objectForKey:@"name"];
            NSRange a=[tempName rangeOfString:tempName];
            if (a.length!=0) {
                NSLog(@"%@",tempName);
                [self.friendItemsUserForSearch addObject:sing];
            }
            
        }
        
    }
    if(self.friendItemsUserForSearch.count>0){
    [self.friendLineListView removeFromSuperview];
    [self.theWholeFriendListBackground addSubview:self.friendLineListView];

}
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"I'm End");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}


@end

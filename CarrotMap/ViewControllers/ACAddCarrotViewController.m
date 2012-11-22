//
//  ACAddCarrotViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//
#import "ACAddCarrotViewController.h"
#import "JPCarrot.h"
#import "JPDataManager.h"
@interface ACAddCarrotViewController ()

@end

@implementation ACAddCarrotViewController

@synthesize friendsListViewController;
@synthesize buttonToFriend;
@synthesize buttonToPushCarrot;
@synthesize selectField;
@synthesize temparray;
@synthesize testRestrict;
@synthesize tipsTableView;
@synthesize firstTwoWords;
@synthesize firstWord;
@synthesize friendNames;
@synthesize theSelectedFriends;
@synthesize friendList;
@synthesize receviers;
@synthesize ausrInfo;
@synthesize theWholeBackground;
@synthesize topNavigation;
@synthesize leftBackBar;
@synthesize rightSenderBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLatitude:(float)alatitude withLongtitude:(float)alongtitude withUserInfo:(NSDictionary *)userInformation
{
    self = [super init];
    if (self) {
        laitutude=alatitude;
        longtitude=alongtitude;
        ausrInfo = userInformation;
        
        //        id delegate = [[UIApplication sharedApplication] delegate];
        //        self.manageedObjectContext=[delegate managedObjectContext];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.topNavigation=[[UIToolbar alloc] init];
    self.topNavigation.frame=CGRectMake(0, 0, 320, 44);
    leftBackBar=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backToMapView)];
    rightSenderBar=[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendCarrotMap)];
    UIBarButtonItem *publicBar=[[UIBarButtonItem alloc] initWithTitle:@"Public" style:UIBarButtonItemStyleBordered target:self action:@selector(SendPublicCarrot)];
    NSArray *itemArray=[[NSArray alloc] initWithObjects:leftBackBar,rightSenderBar,publicBar, nil];
    [self.topNavigation  setItems:itemArray animated:YES];
    
    
    temparray=[[NSMutableArray alloc] initWithCapacity:600];
    [temparray removeAllObjects];
    self.view.backgroundColor=[UIColor clearColor];
    
    theWholeBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wholeBackground.png"]];
    theWholeBackground.frame=CGRectMake(0, 0, 320, 500);
    theWholeBackground.userInteractionEnabled=YES;


    
    
    
    self.selectField=[[UITextField alloc] initWithFrame:CGRectMake(55, 62, 190, 25)];
    self.selectField.borderStyle=UITextBorderStyleNone;
    self.selectField.delegate=self;
    self.selectField.backgroundColor=[UIColor clearColor];
    self.selectField.font=[UIFont fontWithName:@"KaiTi_GB2312" size:9];
    self.buttonToFriend=[[UIButton alloc] initWithFrame:CGRectMake(248,62, 30, 30)];
    [self.buttonToFriend addTarget:self action:@selector(ToFriendList:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonToFriend setBackgroundImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
    
    

    self.testRestrict=[[UITextView alloc] initWithFrame:CGRectMake(18, 119, 280, 150)];
    self.testRestrict.delegate=self;
    self.testRestrict.font=[UIFont fontWithName:@"KaiTi_GB2312" size:18];
    self.testRestrict.backgroundColor=[UIColor clearColor];
    self.testRestrict.scrollEnabled=YES;
    self.testRestrict.autocapitalizationType=UIViewAutoresizingFlexibleHeight;
    
    
    
    [self.theWholeBackground addSubview:self.testRestrict];
    
    self.buttonToPushCarrot=[UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonToPushCarrot.frame=CGRectMake(280, 15, 30, 30);
    self.buttonToPushCarrot.backgroundColor=[UIColor greenColor];
    self.buttonToPushCarrot.layer.cornerRadius=10.0f;
    [self.buttonToPushCarrot addTarget:self action:@selector(senderCarrot:) forControlEvents:UIControlEventTouchUpInside];

//    [self.view addSubview:self.buttonToPushCarrot];
    
    
    
    
//    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Friend" inManagedObjectContext:self.manageedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSError *requestError=nil;
//    NSArray *localFriends=[self.manageedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    //    if ([localFriends count]>0) {
    //        NSLog(@"table view core data successfully!");
    ////       NSArray *friends=[NSArray arrayWithArray:localFriends];
    //    }
    
    
//    friendNames=[[NSMutableArray alloc] initWithCapacity:localFriends.count];
    //    int count=0;
    //    for (Friend *singleDict in localFriends) {
    //        [friendNames addObject:singleDict.name];
    //        //        NSLog(@"%@",singleDict.name);
    //        count++;
    //    }
    
    //    NSLog(@"%d",count);
//    
//    firstWord=[[NSMutableArray alloc] initWithCapacity:friendNames.count];
//    for (int i=0;i<friendNames.count;i++ ) {
//        NSString *singString=[friendNames objectAtIndex:i];
//        
//        //        NSLog(@"%@",[singString substringToIndex:1]);
//        [firstWord addObject:[singString substringToIndex:1]];
//    }
//    
//    firstTwoWords=[[NSMutableArray alloc] initWithCapacity:friendNames.count];
//    for (int i=0;i<friendNames.count;i++ ) {
//        NSString *singString=[friendNames objectAtIndex:i];
//        //        NSLog(@"%hu",[singString characterAtIndex:1]);
//        //        NSLog(@"%@",[singString substringToIndex:2]);
//        [firstTwoWords addObject:[singString substringToIndex:2]];
//        //      NSLog(@"%@" , [firstTwoWords objectAtIndex:i]);
//    }

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidGetUserInfo) name:@"didGetUserInfo" object:nil];
//   [[JPDataManager sharedInstance] getUserInfo];
    
    
    [self.view addSubview:theWholeBackground];
    [self.view addSubview:self.topNavigation];
    [self.theWholeBackground addSubview:self.selectField];
    [self.theWholeBackground addSubview:self.buttonToFriend];
    
    
}

- (void)viewDidUnload
{
    self.temparray=nil;
    self.testRestrict=nil;
    self.selectField=nil;
    self.firstTwoWords=nil;
    self.firstWord=nil;
    self.friendNames=nil;
    self.friendsListViewController=nil;
    self.receviers=nil;
    self.ausrInfo=nil;
    self.topNavigation=nil;
    self.theWholeBackground=nil;
    self.rightSenderBar=nil;
    self.leftBackBar=nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    NSMutableString *names=[NSMutableString stringWithCapacity:receviers.count*5];
    NSLog(@"%@",receviers);
    for (NSDictionary *single in receviers) {
      [ names appendFormat:@"%@,",[single objectForKey:@"name"] ] ;
   
//        NSLog(@"%@",[single objectForKey:@"name"]);
//        NSLog(@"%@",names);
    }
    
    self.selectField.text=names;
    NSLog(@"%d",receviers.count);
    
}

//
//#pragma mark- UITextField Delegate
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    textField.text=@"";
//    tipsTableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 43, 200, 100) style:UITableViewStylePlain];
//    tipsTableView.delegate=self;
//    tipsTableView.dataSource=self;
//    //    tipsTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    tipsTableView.rowHeight=20;
//    //    tipsTableView.
//    [self.view addSubview:tipsTableView];
//    
//    return YES;
//}
//
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    //    NSString *oneWord=[[NSString alloc] init];
//    //    NSString *another=[[NSString alloc] init];
//    //    NSLog(@"%d",textField.text.length);
//    if (textField.text.length==1) {
//        NSString *first=[textField.text substringToIndex:1];
//        //        NSLog(@"%hu",[textField.text characterAtIndex:0]);
//        if ([textField.text characterAtIndex:0]>10000) {
//            [temparray removeAllObjects];
//            //            NSLog(@"%d",temparray.count);
//            for (int i=0; i<firstWord.count; i++) {
//                if ([first isEqualToString:[firstWord objectAtIndex:i]]) {
//                    [temparray addObject:[friendNames objectAtIndex:i]];
//                }
//            }
//            [self.tipsTableView reloadData];
//        }
//        
//    }else if(textField.text.length==2){
//        NSString *first=[textField.text substringToIndex:2];
//        if (([textField.text characterAtIndex:0]>10000)&&([textField.text characterAtIndex:1]>10000)) {
//            [temparray removeAllObjects];
//            NSLog(@"%d",temparray.count);
//            for (int i=0; i<firstTwoWords.count; i++) {
//                if ([first isEqualToString:[firstTwoWords objectAtIndex:i]]) {
//                    [temparray addObject:[friendNames objectAtIndex:i]];
//                }
//            }
//            [self.tipsTableView reloadData];
//            
//        }
//        
//    }
//    
//    
//    
//    //    NSLog(@"%@",another);
//    //    oneWord=[oneWord substringFromIndex:1];
//    //
//    //    NSLog(@"%@",oneWord);
//    
//    //    NSLog(@"%@",textField.text);
//    //   int count=0;
//    //   for(int i=0;i<count-1;i++){
//    //      oneWord=[friendNames[i] substringToIndex:1];
//    //        if ([oneWord isEqualToString:another]) {
//    //            [temparray addObject:friendNames[i]];
//    //            NSLog(@"%@",friendNames[i]);
//    //        }
//    //    }
//    
//    
//    return YES;
//}
//

//#pragma mark- UITableView Delegate and DataSource
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//    
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //    if (temparray.count!=0) {
//    //        NSLog(@"%d",temparray.count);
//    return temparray.count+1;
//    //    }
//    //    return 1;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //    NSLog(@"%d" ,indexPath.length);
//    NSString *cellIdentifier=[[NSString alloc] initWithFormat:@"Cell"];
//    
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    if (indexPath.row==0) {
//        //    if (temparray.count==0){
//        
//        cell.textLabel.text=@"所有人";
//        
//    }else{
//        
//        
//        cell.textLabel.text=[temparray objectAtIndex:indexPath.row-1];
//    }
//    
//    cell.textLabel.font=[UIFont fontWithName:@"Arial" size:15];
//    //    [cell.textLabel drawTextInRect:CGRectMake(2, 2, 50, 16)];
//    return cell;
//}
//
//#pragma mark- @select

-(void)ToFriendList:(UIButton *)paramSender{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFriendList) name:@"didGetFriendsList" object:nil];
    [[JPDataManager sharedInstance] getFriendsList];

}

-(void)senderCarrot:(UIButton *)paramSender{
    NSLog(@"%@",receviers);
    
    NSMutableArray *ids=[[NSMutableArray alloc] initWithCapacity:[receviers count]];
    for (NSDictionary *single in receviers) {
        
        [ids addObject: [NSString stringWithFormat:@"%d", (int)[single objectForKey:@"id"]]];
//        NSLog(@"%@",[single objectForKey:@"name"]);
        NSLog(@"%@",ids);
        NSLog(@"%@",single);
    }
    
//    self.receviers=[[NSArray alloc] initWithObjects:@"311260621",nil ];
    NSString *longtitudeSting=[[NSString alloc] initWithFormat:@"%f",longtitude];
    NSString *latitudeSting=[[NSString alloc] initWithFormat:@"%f",laitutude];
    JPCarrot *carrot=[[JPCarrot alloc] initPrivateCarrotWithLogitude: longtitudeSting withLatitude:latitudeSting withMessage:testRestrict.text withSenderID:[ausrInfo objectForKey:@"uid"] withReceiversID:ids withSendedTime:@"2002年5月20日"];
    [[JPDataManager sharedInstance] sendACarrotToServer:carrot];
    
}

-(void)getFriendList{
    
    friendList=[[NSArray alloc] initWithArray:[JPDataManager sharedInstance].friendsList];
    friendsListViewController=[[ACFriendsListViewController alloc] initWithFriendsList:friendList];
    [self presentModalViewController:friendsListViewController animated:YES];
}

//-(void)DidGetUserInfo{
//    ausrInfo=[JPDataManager sharedInstance].userInfo;
//    NSLog(@"%d", (int)[ausrInfo objectForKey:@"uid"]);
//}

#pragma mark- BarItem Actions

-(void)backToMapView{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)sendCarrotMap{
    NSLog(@"%@",receviers);
    
    NSMutableArray *ids=[[NSMutableArray alloc] initWithCapacity:[receviers count]];
    for (NSDictionary *single in receviers) {
        
        [ids addObject: [NSString stringWithFormat:@"%d", (int)[single objectForKey:@"id"]]];
        //        NSLog(@"%@",[single objectForKey:@"name"]);
        NSLog(@"%@",ids);
        NSLog(@"%@",single);
    }
    
       self.receviers=[[NSArray alloc] initWithObjects:@"311260621",nil ];
    NSString *longtitudeSting=[[NSString alloc] initWithFormat:@"%f",longtitude];
    NSString *latitudeSting=[[NSString alloc] initWithFormat:@"%f",laitutude];
    JPCarrot *carrot=[[JPCarrot alloc] initPrivateCarrotWithLogitude: longtitudeSting withLatitude:latitudeSting withMessage:testRestrict.text withSenderID:[ausrInfo objectForKey:@"uid"] withReceiversID:ids withSendedTime:@"2002年5月20日"];
    [[JPDataManager sharedInstance] sendACarrotToServer:carrot];
     [self dismissModalViewControllerAnimated:YES];

}

-(void)SendPublicCarrot{
    NSString *longtitudeSting=[[NSString alloc] initWithFormat:@"%f",longtitude];
    NSString *latitudeSting=[[NSString alloc] initWithFormat:@"%f",laitutude];
    JPCarrot *carrot=[[JPCarrot alloc] initPublicCarrotWithLogitude:longtitudeSting withLatitude:latitudeSting withMessage:testRestrict.text withSenderID:[ausrInfo objectForKey:@"uid"] withSendedTime:@"2002年5月20日"];
    [[JPDataManager sharedInstance] sendACarrotToServer:carrot];

}
@end
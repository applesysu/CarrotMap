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
@synthesize viewAddForKeyBaord;
@synthesize smileImage;
@synthesize sadImage;

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
     UIBarButtonItem* spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *itemArray=[[NSArray alloc] initWithObjects:leftBackBar,spaceButtonItem,publicBar, nil];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonForKeyBoard) name:UIKeyboardDidShowNotification object:nil];
    
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
    self.viewAddForKeyBaord=nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonForKeyBoard) name:UIKeyboardDidShowNotification object:nil];
    NSMutableString *names=[NSMutableString stringWithCapacity:receviers.count*5];
    NSLog(@"%@",receviers);
    for (NSDictionary *single in receviers) {
      [ names appendFormat:@"%@ ",[single objectForKey:@"name"] ] ;
   
//        NSLog(@"%@",[single objectForKey:@"name"]);
//        NSLog(@"%@",names);
    }
    
    self.selectField.text=names;
    NSLog(@"%d",receviers.count);
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardDidShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didGetFriendsList" object:nil];
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

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFriendList) name:@"didGetFriendsList" object:nil];
//    [[JPDataManager sharedInstance] getFriendsList];

//    self.buttonToFriend=[[UIButton alloc] initWithFrame:CGRectMake(248,62, 30, 30)];
//    [self.buttonToFriend addTarget:self action:@selector(ToFriendList:) forControlEvents:UIControlEventTouchUpInside];
//    [self.buttonToFriend setBackgroundImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
    
    smileImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smile.png"]];
    smileImage.frame=CGRectMake(248, 100, 30, 30);
    smileImage.userInteractionEnabled=YES;
    smileImage.tag=10;
  
    
    sadImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sad.png"]];
    sadImage.frame=CGRectMake(248, 140, 30, 30);
    sadImage.userInteractionEnabled=YES;
    sadImage.tag=11;
                                   
    [self.theWholeBackground addSubview:smileImage];
    [self.theWholeBackground addSubview:sadImage];
    
    UITapGestureRecognizer *tapExpression_1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectExpression:)];
    UITapGestureRecognizer *tapExpression_2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectExpression:)];
    tapExpression_1.numberOfTapsRequired=1;
    tapExpression_1.numberOfTouchesRequired=1;
    tapExpression_2.numberOfTapsRequired=1;
    tapExpression_2.numberOfTouchesRequired=1;
    
    
    [self.smileImage addGestureRecognizer:tapExpression_1];
    [self.sadImage addGestureRecognizer:tapExpression_2];
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
    [self dismissModalViewControllerAnimated:YES];

}




#pragma mark- UIKeyBoard Notificaiton
-(void)addButtonForKeyBoard{
    
    UIWindow *temWindow;
  //  UIView *keyboard_father;
    UIView *keyboard;
    
   //  NSLog(@"共有这么多的window: %d",[[[UIApplication sharedApplication] windows] count]);
    for (int c=0; c<[[[UIApplication sharedApplication] windows] count]; c++) {
       
        temWindow=[[[UIApplication sharedApplication] windows] objectAtIndex:c];
        for (int i=0; i<[temWindow.subviews count]; i++) {
            keyboard=[temWindow.subviews objectAtIndex:i];
        
           // for (int j=0; j<[keyboard_father.subviews count]; j++) {
                
             //   keyboard=[keyboard_father.subviews objectAtIndex:j];
               //   NSLog(@"%@",[keyboard description]);
            if ([[keyboard description] hasPrefix:@"<UIPeri"]==YES) {
               // NSLog(@"这个keyboard的子view---%d",[keyboard.subviews count]);
             //   NSLog(@"+++++++++++++++Sure get it!");
                viewAddForKeyBaord=[[UIToolbar alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
                //viewAddForKeyBaord.backgroundColor=[UIColor blueColor];
                viewAddForKeyBaord.barStyle=UIBarStyleBlackTranslucent;
                
                
                UIBarButtonItem* prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"声音" style:UIBarButtonItemStyleBordered target:self action:nil];
                
                UIBarButtonItem* nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"照片" style:UIBarButtonItemStyleBordered target:self action:nil];
                
                UIBarButtonItem* hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(hiddenKeyBoard)];
                
                UIBarButtonItem* spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                viewAddForKeyBaord.items=[NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem ,nil];
                [keyboard addSubview:viewAddForKeyBaord];
    
               return;
            }
           // }
        }
        
    }
}

-(void)hiddenKeyBoard{
    [self.selectField resignFirstResponder];
    [self.testRestrict resignFirstResponder];
}

#pragma mark- Guesture

-(void)SelectExpression:(UITapGestureRecognizer *)paramSender{
    if (paramSender.state==UIGestureRecognizerStateEnded) {
        if([paramSender.view isEqual:self.smileImage]){
            [self.buttonToFriend setBackgroundImage:[UIImage imageNamed:@"smile.png"] forState:UIControlStateNormal];
        }else{
            [self.buttonToFriend setBackgroundImage:[UIImage imageNamed:@"sad.png"] forState:UIControlStateNormal];
        }
    }
    [self.smileImage removeFromSuperview];
    [self.sadImage removeFromSuperview];
    
    
}
@end
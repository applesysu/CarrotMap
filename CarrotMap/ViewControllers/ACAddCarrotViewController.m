//
//  ACAddCarrotViewController.m
//  CarrotMap
//
//  Created by Jacob Pan on 12-11-5.
//  Copyright (c) 2012年 sysuAppleClub. All rights reserved.
//
#import "ACAddCarrotViewController.h"

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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLatitude:(float)alatitude withLongtitude:(float)alongtitude{
    self = [super init];
    if (self) {
        laitutude=alatitude;
        longtitude=alongtitude;
        
//        id delegate = [[UIApplication sharedApplication] delegate];
//        self.manageedObjectContext=[delegate managedObjectContext];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    [super viewDidLoad];
    temparray=[[NSMutableArray alloc] initWithCapacity:600];
    [temparray removeAllObjects];
    self.view.backgroundColor=[UIColor clearColor];
    
    
    self.selectField=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    self.selectField.placeholder=@"@:你的好友";
    
    self.selectField.borderStyle=UITextBorderStyleRoundedRect;
    self.selectField.delegate=self;
    self.selectField.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.selectField];
    
    self.buttonToFriend=[UIButton buttonWithType:UIButtonTypeContactAdd];
    //    self.buttonToFriend.backgroundColor=[UIColor orangeColor];
    self.buttonToFriend.frame=CGRectMake(230,10, 30, 30);
    [self.buttonToFriend addTarget:self action:@selector(ToFriendList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonToFriend];
    
    self.testRestrict=[[UITextView alloc] initWithFrame:CGRectMake(10, 60, 300, 300)];
    self.testRestrict.delegate=self;
    self.testRestrict.font=[UIFont fontWithName:@"KaiTi_GB2312" size:18];
    self.testRestrict.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.testRestrict];
    
    self.buttonToPushCarrot=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonToPushCarrot.frame=CGRectMake(270, 10, 30, 30);
    
    [self.buttonToPushCarrot addTarget:self action:@selector(senderCarrot:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonToPushCarrot];
    
    
    
    
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    //    JPFriendsListViewController *aFriendsListViewController=[[JPFriendsListViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self presentModalViewController:aFriendsListViewController animated:YES];
    
    friendsListViewController=[[ACFriendsListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self presentModalViewController:friendsListViewController animated:YES];
}

-(void)senderCarrot:(UIButton *)paramSender{
    
}
@end
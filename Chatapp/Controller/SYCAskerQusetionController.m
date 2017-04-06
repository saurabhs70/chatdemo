//
//  SYCAskerQusetionController.m
//  Chatapp
//
//  Created by umenit on 3/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCAskerQusetionController.h"

@interface SYCAskerQusetionController ()

@end

@implementation SYCAskerQusetionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [[ChatConfig sharedInstance]updatestatus:@"isTyping" andvalue:@"true" anduuid:@"my" andchannel:@"my@gmail.com"];
    qustion=[[Constantobject sharedInstance]arr];
    [self setmenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
////    if(section == 0)
////        return @"New Qustion";
////    else
////        return @"";
//    return  qustion.count;
//}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return  qustion.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SYCAskerQustionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCAskerQustionCellId"];
    
    if (cell == nil) {
        cell = [[SYCAskerQustionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCStatusCellId"];
    }
    NSDictionary *dd=[qustion objectAtIndex:indexPath.row];
    cell.lblquestion.text=[dd valueForKey:@"Asker_question"];
    //cell.lbltagforqa.text=@"Answered";
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SYCQusetionAnswerController *vv=(SYCQusetionAnswerController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCQusetionAnswerControllerId"];
    NSDictionary *dd=[qustion objectAtIndex:indexPath.row];
    SYCChatConversation *chatcon;
    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEMENTOR])
   chatcon =[[SYCChatConversation alloc]initWithSycConverstion:[dd valueForKey:@"Asker_id"] andMentorId: [[Constantobject sharedInstance]getloggedchannel] andQuestionId:nil andAnswerlist:nil];
    vv.conversationchannel=chatcon;//[dd valueForKey:@"Asker_id"];
    [self.navigationController pushViewController:vv animated:YES];
   // [[ChatConfig sharedInstance]unsubscribechannle:[[Constantobject sharedInstance] getloggedchannel]];
}

-(void)setmenu
{
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sidebaricon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    revealController.delegate = self;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

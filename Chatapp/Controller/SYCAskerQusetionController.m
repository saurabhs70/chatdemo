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
    NSString *str=[[Constantobject sharedInstance]getloggedchannel];
    [[SYCRequestManager sharedInstance]getChatList:@"getQuestionAnswerChat" andAskerChannel:nil andMentorChannel:str   anduser_id:@""  callback:^(NSArray *send) {
        if (send) {
            arrayofquestion=[[NSMutableArray alloc]init];
            [arrayofquestion addObjectsFromArray:send];
            // conversationarray=send;
            [self.tblqusetion reloadData];
            NSLog(@"raju  %lu",(unsigned long)arrayofquestion.count);
        }
        
    }];
  //  [self mentorrefresh];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshmentormessasge" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mentorrefresh:) name:@"refreshmentormessasge" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshmentormessasge" object:nil];
}
-(void)mentorrefresh:(NSNotification*)notification
{
    NSArray* userInfo = [notification.object valueForKey:@"total"];
    //NSArray* total = [userInfo valueForKey:@"total"];
    
    arrayofquestion=[[NSMutableArray alloc]init];
            [arrayofquestion addObjectsFromArray:userInfo];
    //            // conversationarray=send;
            [self.tblqusetion reloadData];

    
//    NSString *str=[[Constantobject sharedInstance]getloggedchannel];
//    [[SYCRequestManager sharedInstance]getChatList:@"getQuestionAnswerChat" andAskerChannel:nil andMentorChannel:str callback:^(NSArray *send) {
//        if (send) {
//            arrayofquestion=[[NSMutableArray alloc]init];
//            [arrayofquestion addObjectsFromArray:send];
//            // conversationarray=send;
//            [self.tblqusetion reloadData];
//             NSLog(@"raju  %lu",(unsigned long)arrayofquestion.count);
//        }
//        
//    }];
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
    return  arrayofquestion.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SYCAskerQustionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCAskerQustionCellId"];
    
    if (cell == nil) {
        cell = [[SYCAskerQustionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCStatusCellId"];
    }
    SYCChatConversation *vv=[arrayofquestion objectAtIndex:indexPath.row];
    SYCChatConversationAnswer *dd=vv.answer.lastObject;
    if (dd)
        cell.lbltagforqa.text=@"Answered";
    else
        cell.lbltagforqa.text=@"new question";
    cell.lblquestion.text=vv.question;//[dd valueForKey:@"Asker_question"];
    cell.lblanswer.text=dd.answer;
    //cell.lbltagforqa.text=@"Answered";
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SYCQusetionAnswerController *vv=(SYCQusetionAnswerController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCQusetionAnswerControllerId"];
    SYCChatConversation *question=[arrayofquestion objectAtIndex:indexPath.row];
    SYCChatConversation *chatcon;
    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEMENTOR])
   chatcon =[[SYCChatConversation alloc]initWithSycConverstion:@"ASK_bill@gmail.com" andMentorId: [[Constantobject sharedInstance]getloggedchannel] andQuestionId:nil andquestion:nil andquestimestamp:nil andAnswerlist:nil];
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

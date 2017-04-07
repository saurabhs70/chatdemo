//
//  SYCChatConversationAsker.m
//  Chatapp
//
//  Created by umenit on 4/7/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCChatConversationAsker.h"

@interface SYCChatConversationAsker ()

@end

@implementation SYCChatConversationAsker

- (void)viewDidLoad {
    [super viewDidLoad];
    
   listmentor= [[SYCChatModule sharedInstance]readToSycChat:@"MENTOR-LIST"];
    // Do any additional setup after loading the view.
    [self setmenu];
    [self askerrefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Presencestatusmentor:) name:@"Presencestatuschange" object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(askerrefresh) name:@"refreshaskermessasge" object:nil];
     
}
-(void)askerrefresh
{
    [[SYCRequestManager sharedInstance]getChatList:@"getQuestionAnswerChat" andAskerChannel:[[Constantobject sharedInstance]getloggedchannel] andMentorChannel:nil callback:^(NSArray *send) {
        if (send) {
            conversationarray=[[NSMutableArray alloc]init];
            [conversationarray addObjectsFromArray:send];
            // conversationarray=send;
            [self.tblasker reloadData];
           
        }
        
    }];
}
-(void)Presencestatusmentor:(NSNotification*)notification
{
    //  mentorPresencelist=[Constantobject sharedInstance].allMentorList;
    [_tblasker reloadData];
    //onlineuser= [Constantobject sharedInstance].onlinecontact;
    // [self.tblonline reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
   
    return conversationarray.count;//conversationarray.count;//chatmessage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SYCAskerQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCAskerQuestionCellId"];
    
    if (cell == nil) {
        cell = [[SYCAskerQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCAskerQuestionCellId"];
    }
    //    NSDictionary *dd=[chatmessage objectAtIndex:indexPath.row];
    //    if ([[dd valueForKey:@"sender"] isEqualToString:_reciver])
    //    {
    //        cell.lblreciever.hidden=YES;
    //        cell.lblsender.hidden=NO;
    //    }
    //
    //    else
    //    {
    //        cell.lblsender.hidden=YES;
    //        cell.lblreciever.hidden=NO;
    //
    //    }
    //
    //    cell.lblsender.text=[dd valueForKey:@"message"];//[onlineuser objectAtIndex:indexPath.row];//[NSString stringWithFormat:@""];//
//    SYCChatConversation *vv=[conversationarray objectAtIndex:indexPath.section];
//    if (indexPath.row==0) {
//        cell.lblsender.textColor=[UIColor redColor];
//        cell.lblsender.text=vv.qusetion;
//    }
//    else
//    {
//        cell.lblsender.textColor=[UIColor greenColor];
//        int valtoans=(int)indexPath.row-1;
//        NSDictionary *artr=[vv.answer objectAtIndex:valtoans];
//        cell.lblsender.text=[artr valueForKey:@"answer"];//@"ll";//[vv.answer objectAtIndex:valtoans];//[dd valueForKey:@"message"];;
//    }
     SYCChatConversation *vv=[conversationarray objectAtIndex:indexPath.row];
    NSArray *str=[vv.mentor_id componentsSeparatedByString:SYCCHANNELMENTORPREFIX];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email endswith %@",[str objectAtIndex:1]];
    NSArray *filteredArray = [listmentor filteredArrayUsingPredicate:predicate];
    
    NSDictionary *dd=vv.answer.lastObject;
    if (dd)
        cell.lblqastatus.text=@"Answered";
    else
        cell.lblquestion.text=@"new question";
    cell.lblquestion.text=vv.qusetion;//[dd valueForKey:@"Asker_question"];
    cell.lblanswer.text=[dd valueForKey:@"answer"];
    if ([[[Constantobject sharedInstance]onlineMentorList] containsObject:vv.mentor_id] )
        cell.imgpresence.image=[UIImage imageNamed:@"online.png"];
        else
           cell.imgpresence.image=[UIImage imageNamed:@"offline.png"];
    //profile_pic_url
    cell.imgprofile.layer.cornerRadius = cell.imgprofile.frame.size.width / 2;
    cell.imgprofile.clipsToBounds = YES;
    [ cell.imgprofile sd_setImageWithURL:[NSURL URLWithString:[[filteredArray objectAtIndex:0] valueForKey:@"profile_pic_url"] ]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
    
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

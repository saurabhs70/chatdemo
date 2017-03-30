//
//  IndividualchatViewController.m
//  Chatapp
//
//  Created by umenit on 1/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "IndividualchatViewController.h"

@interface IndividualchatViewController ()

@end

@implementation IndividualchatViewController
@synthesize chatmessage;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_reciver);
    [self.tblindi reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return chatmessage.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    chatcellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indidualmessage"];
    
    if (cell == nil) {
        cell = [[chatcellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"indidualmessage"];
    }
    NSDictionary *dd=[chatmessage objectAtIndex:indexPath.row];
    if ([[dd valueForKey:@"sender"] isEqualToString:_reciver])
    {
        cell.lblreciever.hidden=YES;
        cell.lblsender.hidden=NO;
    }
    
    else
    {
        cell.lblsender.hidden=YES;
        cell.lblreciever.hidden=NO;
    
    }
    
    cell.lblsender.text=[dd valueForKey:@"message"];//[onlineuser objectAtIndex:indexPath.row];//[NSString stringWithFormat:@""];//
    cell.lblreciever.text=[dd valueForKey:@"message"];
    
    
    
    return cell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chatclicked:(id)sender {
 PubNub *cc=   [Constantobject sharedInstance].client;
//   // NSString *targetChannel = [cc channels].lastObject;//targetChannel
//                                    [cc publish: @"Hello from the PubNub Objective-C SDK"
//                                               toChannel: @"1to1chat" withCompletion:^(PNPublishStatus *publishStatus) {
//    
//                                                   // Check whether request successfully completed or not.
//                                                   if (!publishStatus.isError) {
//    
//                                                       // Message successfully published to specified channel.
//                                                   }
//                                                   else {
//    
//                                                       /**
//                                                        Handle message publish error. Check 'category' property to find out
//                                                        possible reason because of which request did fail.
//                                                        Review 'errorData' property (which has PNErrorData data type) of status
//                                                        object to get additional information about issue.
//    
//                                                        Request can be resent using: [publishStatus retry];
//                                                        */
//                                                   }
//                                               }];
    
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:@"mymessagefromdevice" forKey:@"message"];
    [msg setValue:cc.uuid forKey:@"sender"];
    [cc publish: msg
               toChannel: @"1to1channel" withCompletion:^(PNPublishStatus *publishStatus) {
                   
                   // Check whether request successfully completed or not.
                   if (!publishStatus.isError) {
                       NSDictionary *dictmessage=msg;
                       //"5siphone" @"54321"
                       NSString *chatbetween=[NSString stringWithFormat:@"%@-%@",_reciver,cc.uuid];//1234-5555
                       //5555-1234
                       //  if (![[dictmessage valueForKey:@"sender"] isEqualToString:_client.uuid]) {
                       NSMutableArray *arr=[[NSMutableArray alloc]init];
                       NSMutableDictionary* retrievedFruits = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"allmessage"]];
                       [arr addObjectsFromArray:[retrievedFruits objectForKey:chatbetween]];
                       NSDictionary *dd=[[NSDictionary alloc]initWithObjectsAndKeys:[dictmessage valueForKey:@"message"],@"message",[dictmessage valueForKey:@"sender"],@"sender",nil];
                       [arr addObject:dd];
                       [retrievedFruits setObject:arr forKey:chatbetween];
                       [[NSUserDefaults standardUserDefaults] setObject:retrievedFruits forKey:@"allmessage"];
                       [[NSUserDefaults standardUserDefaults] synchronize];
                      
                       NSMutableDictionary* retrievedFruits1 = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"allmessage"]];
                      chatmessage= [retrievedFruits1 valueForKey:chatbetween];
                       [self.tblindi reloadData];
                       NSLog(@"%@",retrievedFruits);
                       // Message successfully published to specified channel.
                   }
                   else {
                       
                       /**
                        Handle message publish error. Check 'category' property to find out
                        possible reason because of which request did fail.
                        Review 'errorData' property (which has PNErrorData data type) of status
                        object to get additional information about issue.
                        
                        Request can be resent using: [publishStatus retry];
                        */
                   }
               }];
}
@end

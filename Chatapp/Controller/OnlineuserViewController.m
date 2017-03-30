//
//  OnlineuserViewController.m
//  Chatapp
//
//  Created by umenit on 1/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "OnlineuserViewController.h"

@interface OnlineuserViewController ()

@end

@implementation OnlineuserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    onlineuser=[[NSMutableArray alloc]init];
    onlineuser=_allmentor.mutableCopy;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(somethingHappens:) name:@"notificationName" object:nil];
  
}
-(void)somethingHappens:(NSNotification*)notification
{
    //onlineuser= [Constantobject sharedInstance].onlinecontact;
   // [self.tblonline reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return  onlineuser.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SYCStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCStatusCellId"];
    
    if (cell == nil) {
        cell = [[SYCStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCStatusCellId"];
    }

    cell.statusicon.image=[UIImage imageNamed:@"online.png"];
    cell.statuslbl.text=[onlineuser objectAtIndex:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    IndividualchatViewController *viewController = (IndividualchatViewController *)[storyboard instantiateViewControllerWithIdentifier:@"IndividualchatViewControllerId"];
//    viewController.reciver=[onlineuser objectAtIndex:indexPath.row];
//    NSMutableDictionary* retrievedFruits = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"allmessage"]];
//    NSLog(@"%@",retrievedFruits);
//    PubNub *cc=   [Constantobject sharedInstance].client;
//    NSString *view=[NSString stringWithFormat:@"%@-%@",[onlineuser objectAtIndex:indexPath.row],cc.uuid];//5siphone-54321
//    viewController.chatmessage=[retrievedFruits valueForKey:view];
//    [self presentViewController:viewController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chat:(id)sender {
    
//    PubNub *cc=   [Constantobject sharedInstance].client;
//    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
//    [msg setValue:@"mymessage" forKey:@"message"];
//    [msg setValue:@"sender" forKey:@"i'm"];
//    // NSString *targetChannel = [cc channels].lastObject;//targetChannel
//    [cc publish: msg
//      toChannel: @"1to1chat" withCompletion:^(PNPublishStatus *publishStatus) {
//          
//          // Check whether request successfully completed or not.
//          if (!publishStatus.isError) {
//              
//              // Message successfully published to specified channel.
//          }
//          else {
//              
//              /**
//               Handle message publish error. Check 'category' property to find out
//               possible reason because of which request did fail.
//               Review 'errorData' property (which has PNErrorData data type) of status
//               object to get additional information about issue.
//               
//               Request can be resent using: [publishStatus retry];
//               */
//          }
//      }];

}
@end

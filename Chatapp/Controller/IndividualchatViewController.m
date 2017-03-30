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

    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:@"mymessagefromdevice" forKey:@"message"];
    [msg setValue:cc.uuid forKey:@"sender"];
    [[ChatConfig sharedInstance]sendmessage:msg andtochannel:@"" callback:^(bool sent) {
        
        if (sent)
            NSLog(@"send!");
        else
            NSLog(@"send error!");
    
    }];
    }
@end

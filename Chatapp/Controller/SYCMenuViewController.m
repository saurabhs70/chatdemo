//
//  SYCMenuViewController.m
//  Chatapp
//
//  Created by umenit on 4/3/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCMenuViewController.h"

@interface SYCMenuViewController ()

@end

@implementation SYCMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   NSArray *askerarray=[[NSArray alloc]initWithObjects:@"Chat",@"Mentor",nil];
   NSArray *mentorarray=[[NSArray alloc]initWithObjects:@"Activity",nil];
    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER])
    menuarray=askerarray;
    else
        menuarray=mentorarray;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellId"];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MenuCellId"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
cell.textLabel.text=[menuarray objectAtIndex:indexPath.row];
    return cell;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *Roottocontroller;
    
    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER]) {
        if (indexPath.row==0) {
            
            SYCChatConversationAsker *frontViewControllerlogged=(SYCChatConversationAsker*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCChatConversationAskerId"];
            Roottocontroller=frontViewControllerlogged;
        }
        else
        {
        OnlineuserViewController *frontViewControllerlogged=(OnlineuserViewController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"OnlineuserViewControllerid"];
        Roottocontroller=frontViewControllerlogged;
        }
    }
    else
    {
       SYCAskerQusetionController *frontViewControllerlogged=(SYCAskerQusetionController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCAskerQusetionControllerId"];
    Roottocontroller=frontViewControllerlogged;
    
    }
    
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:Roottocontroller];
    [navController setViewControllers: @[Roottocontroller] animated: YES];
    
    [self.revealViewController setFrontViewController:navController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];

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

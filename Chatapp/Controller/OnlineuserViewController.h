//
//  OnlineuserViewController.h
//  Chatapp
//
//  Created by umenit on 1/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCStatusCell.h"
//#import "IndividualchatViewController.h"
#import "SYCQusetionAnswerController.h"
#import "SWRevealViewController.h"
@interface OnlineuserViewController : UIViewController<SWRevealViewControllerDelegate>
{
    NSArray *mentorPresencelist;
}
//@property (strong,nonatomic) NSArray *mentorPresencelist;
- (IBAction)chat:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblonline;
@end

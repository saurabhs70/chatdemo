//
//  SYCAskerQusetionController.h
//  Chatapp
//
//  Created by umenit on 3/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "SYCAskerQustionCell.h"
@interface SYCAskerQusetionController : ViewController<SWRevealViewControllerDelegate>
{
    NSArray *qustion;
    NSMutableArray *arrayofquestion;
}
@property (weak, nonatomic) IBOutlet UITableView *tblqusetion;
@end

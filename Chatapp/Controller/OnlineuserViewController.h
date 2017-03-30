//
//  OnlineuserViewController.h
//  Chatapp
//
//  Created by umenit on 1/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCStatusCell.h"
@interface OnlineuserViewController : UIViewController<PNObjectEventListener>
{
   NSMutableArray *onlineuser;
}
@property (strong,nonatomic) NSArray *allmentor;
- (IBAction)chat:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblonline;
@end

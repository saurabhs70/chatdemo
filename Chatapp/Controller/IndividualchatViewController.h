//
//  IndividualchatViewController.h
//  Chatapp
//
//  Created by umenit on 1/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constantobject.h"
#import "chatcellTableViewCell.h"
@interface IndividualchatViewController : UIViewController
{
    //NSArray *chatmessage;
 
}
@property(strong,nonatomic) NSString *reciver;
@property(strong,nonatomic) NSArray *chatmessage;
@property (weak, nonatomic) IBOutlet UITableView *tblindividual;
- (IBAction)chatclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblindi;

@end

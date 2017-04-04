//
//  ViewController.h
//  Chatapp
//
//  Created by umenit on 1/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<delegateforconnection>

- (IBAction)btnchatclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnmode;
- (IBAction)btnmodeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loggedtext;
- (IBAction)btnunsc:(id)sender;
- (IBAction)hearall:(id)sender;

@end


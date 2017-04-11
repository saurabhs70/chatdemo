//
//  SYCQusetionAnswerController.h
//  Chatapp
//
//  Created by umenit on 4/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "SYCQACellTableViewCell.h"
#import "SYCChatConversation.h"
@interface SYCQusetionAnswerController : UIViewController<HPGrowingTextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *chatview;
    HPGrowingTextView *textView;
    NSString *val;
    NSArray *conversationarray;
    CGRect keyboardBoundsview;
   // NSString *askerchannel;
    //NSString *mentorchannel;
    //NSString * timestamp;
}
@property (strong,nonatomic) SYCChatConversation *conversationchannel;
@property (strong,nonatomic) NSString *reciver;
@property (weak, nonatomic) IBOutlet UITableView *tblconversation;
@property (weak, nonatomic) IBOutlet UILabel *lblIsTyping;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblchatcontsant;

@end

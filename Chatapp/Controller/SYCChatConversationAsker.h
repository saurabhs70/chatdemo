//
//  SYCChatConversationAsker.h
//  Chatapp
//
//  Created by umenit on 4/7/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCAskerQuestionCell.h"

#import "UIImageView+WebCache.h"
@interface SYCChatConversationAsker : UIViewController<SWRevealViewControllerDelegate>
{
    NSMutableArray *conversationarray;
     NSArray *listmentor;
}
@property (weak, nonatomic) IBOutlet UITableView *tblasker;

@end

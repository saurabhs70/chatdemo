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
@interface SYCQusetionAnswerController : UIViewController<HPGrowingTextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *chatview;
    HPGrowingTextView *textView;
}
@property (strong,nonatomic) NSString *reciver;
@property (weak, nonatomic) IBOutlet UITableView *tblconversation;


@end

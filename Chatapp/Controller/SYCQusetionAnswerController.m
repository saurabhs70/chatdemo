//
//  SYCQusetionAnswerController.m
//  Chatapp
//
//  Created by umenit on 4/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCQusetionAnswerController.h"

@interface SYCQusetionAnswerController ()

@end

@implementation SYCQusetionAnswerController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [[ChatConfig sharedInstance]addmorechannel:[[Constantobject sharedInstance]TypingToChannel:_reciver]];
 [self keyboaradstyatus];
[self viewloadf];
    // Do any additional setup after loading the view.
}
-(void)keyboaradstyatus
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return 10;//chatmessage.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SYCQACellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCQACellTableViewCellid"];
    
    if (cell == nil) {
        cell = [[SYCQACellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCQACellTableViewCellid"];
    }
    //    NSDictionary *dd=[chatmessage objectAtIndex:indexPath.row];
    //    if ([[dd valueForKey:@"sender"] isEqualToString:_reciver])
    //    {
    //        cell.lblreciever.hidden=YES;
    //        cell.lblsender.hidden=NO;
    //    }
    //
    //    else
    //    {
    //        cell.lblsender.hidden=YES;
    //        cell.lblreciever.hidden=NO;
    //
    //    }
    //
    //    cell.lblsender.text=[dd valueForKey:@"message"];//[onlineuser objectAtIndex:indexPath.row];//[NSString stringWithFormat:@""];//
    cell.lblsender.text=@"dfdfdfdf";//[dd valueForKey:@"message"];
    
    
    
    return cell;
    
}

- (void)viewloadf {
  //self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  //self.view.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
    
   chatview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, SCREENWIDTH, 40)];
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, SCREENWIDTH-100, 40)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    textView.returnKeyType = UIReturnKeyGo; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"Type to see the textView grow!";
    
    // textView.text = @"test\n\ntest";
    // textView.animateHeightChange = NO; //turns off animation
    
     [self.view addSubview:chatview];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, SCREENWIDTH-100, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, chatview.frame.size.width,chatview.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    [chatview addSubview:imageView];
    [chatview addSubview:textView];
    
    [chatview addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(chatview.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(AskQuestionAnser) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [chatview addSubview:doneBtn];
    chatview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

//-(void)resignTextView
//{
//    [textView resignFirstResponder];
//}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = chatview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    chatview.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = chatview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    chatview.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = chatview.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    chatview.frame = r;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)AskQuestionAnser
{
    NSString *conversationchahhel=[[Constantobject sharedInstance]TypingToChannel:_reciver];//[NSString stringWithFormat:@"%@--%@",_reciver,[[Constantobject sharedInstance]getloggedchannel]];
   // [[ChatConfig sharedInstance]unsubscribechannle:conversationchahhel];
    [[ChatConfig sharedInstance]updatestatus:@"isTyping" andvalue:@"true" anduuid:[[Constantobject sharedInstance]getloggedchannel] andchannel:conversationchahhel];
    
    
    
    if (textView.text.length) {
        
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:textView.text forKey:@"message"];
    [msg setValue:[[Constantobject sharedInstance]getlogged] forKey:@"sendormode"];
    [msg setValue:[[Constantobject sharedInstance]getloggedchannel] forKey:@"sendorchannel"];
    [msg setValue:@"mycategory" forKey:@"sendorcategory"];
    
    [[ChatConfig sharedInstance]sendmessage:msg andtochannel:_reciver callback:^(bool sent) {
        
        if (sent)
            NSLog(@"send!");
        else
            NSLog(@"send error!");
        
    }];
    }
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

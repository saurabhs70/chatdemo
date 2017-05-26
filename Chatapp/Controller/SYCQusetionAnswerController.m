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
@synthesize conversationchannel;
- (void)viewDidLoad {
    [super viewDidLoad];
  _lblIsTyping.hidden=YES;
//    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER])
//    {
//        _reciver=conversationchannel.mentor_id;
//    [[ChatConfig sharedInstance]addmorechannel:[[Constantobject sharedInstance]TypingToChannel:conversationchannel.mentor_id]];
//        NSString *typinch=[[Constantobject sharedInstance]TypingToChannel:conversationchannel.mentor_id];
//        NSLog(@"rr");
//       
//    }
//    else
//    {
//         _reciver=conversationchannel.asker_id;
//       [[ChatConfig sharedInstance]addmorechannel:[[Constantobject sharedInstance]TypingToChannel:conversationchannel.asker_id]];
//        NSString *typinch=[[Constantobject sharedInstance]TypingToChannel:conversationchannel.asker_id];
//        NSLog(@"rr");
//    }
    _reciver=conversationchannel.sycReciver;
    [[ChatConfig sharedInstance]addmorechannel:@"TYPINGCHANNEL"];
      [self settyping:@"false"];
 [self keyboaradstyatus];
[self viewloadf];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isTypingUpdate:) name:@"isTypingUpdate" object:nil];
    [_lblIsTyping bringSubviewToFront:_tblconversation];
  [self loadchat];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadchat) name:@"refreshmessageforaskermentor" object:nil];
    
   checktypingstatus= [NSTimer scheduledTimerWithTimeInterval: 2.0 target: self
                                   selector: @selector(checkingTypingstatus) userInfo: nil repeats: YES];

    // Do any additional setup after loading the view.
}
-(void)checkingTypingstatus
{
     NSString *conversationchahhel=@"TYPINGCHANNEL";//[[Constantobject sharedInstance]TypingToChannel:_reciver];
    [[ChatConfig sharedInstance]hearPerticularChannelforTyping:conversationchahhel anduuid:_reciver callback:^(bool sent) {
        
    }];
}
-(void)keyboaradstyatus
{
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyPressed:) name: UITextFieldTextDidChangeNotification object: nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void) keyPressed: (NSNotification*) notification
{
    NSLog(@"%@", [[notification object]text]);
}
//conversationarray
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return conversationarray.count;
  //  return 1;
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    SYCChatConversation *vv=[conversationarray objectAtIndex:section];
    if(vv.answer.length)
        return 2;
    else
        return 1;
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
    SYCChatConversation *vv=[conversationarray objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
    
        cell.lblsender.textColor=[UIColor redColor];
        cell.lblsender.text=vv.question;
    }
    else
    {
         cell.lblsender.textColor=[UIColor greenColor];
       // int valtoans=(int)indexPath.row-1;
       // SYCChatConversationAnswer *artr=[vv.answer objectAtIndex:valtoans];
        cell.lblsender.text=vv.answer;//[artr valueForKey:@"answer"];//@"ll";//[vv.answer objectAtIndex:valtoans];//[dd valueForKey:@"message"];;
    }
    
    
    
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
    keyboardBoundsview=keyboardBounds;
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
//    if (_tblconversation.contentSize.height > _tblconversation.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, _tblconversation.contentSize.height -     _tblconversation.frame.size.height);
//        [_tblconversation setContentOffset:offset animated:YES];
//    }
//    _tblchatcontsant.constant=(SCREENHEIGHT-keyboardBounds.size.height)+containerFrame.size.height;
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
  //  _tblchatcontsant.constant=87;//(SCREENHEIGHT-keyboardBounds.size.height)+containerFrame.size.height;
  
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
//    float diff = (growingTextView.frame.size.height - height);
//    
//    CGRect r = chatview.frame;
//    r.size.height -= diff;
//    r.origin.y += diff;
//    chatview.frame = r;
}

-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    //   [self settyping:@"true"];
}
-(BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
//    if (text.length)
//        [self settyping:@"true"];
//    else
//    [self settyping:@"false"];
    NSLog(@"f");
    return YES;
}

-(void)checkingTypingstatusnow
{
//   NSTimeInterval comparetime= [self compareTimeSlot:timestamp];
//if(comparetime==7)
//{
//    [self settyping:@"false"];
//}
//    
}
-(NSDate*)backtonsdate:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}
-(NSString*)getTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    //NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    return [dateFormatter stringFromDate:[NSDate date]];
}
-(NSTimeInterval)compareTimeSlot:(NSString*)prevtime
{
    NSString *crttime=[self getTime];
    NSDate *prevdatetime=[self backtonsdate:prevtime];
    NSDate *currentdatetime=[self backtonsdate:crttime];
    NSTimeInterval secondsBetween = [currentdatetime timeIntervalSinceDate:prevdatetime];
    return secondsBetween;
}
-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
   
    timestamp = [self getTime];//[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    checktypingstatusval= [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                         selector: @selector(checkingTypingstatusnow) userInfo: nil repeats: YES];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updatestatus) object:nil];
//    // start a new one in 0.3 seconds
//    [self performSelector:@selector(updatestatus) withObject:nil afterDelay:0.5];
//    
//     NSLog(@"%@",@"change");
    if (growingTextView.text.length==1) {
        [self settyping:@"true"];
    }
    else if (growingTextView.text.length==0)
    {
        [self settyping:@"false"];
    }
    else if ([val  isEqualToString:@"false"])
    {
        val=@"true";
        [self settyping:@"true"];
    }
//    else if (growingTextView.text.length>1)
//    {
//        if (_lblIsTyping.hidden==YES) {
//            [self settyping:@"true"];
//        }
//    }
    
     //   _tblchatcontsant.constant=(SCREENHEIGHT-keyboardBoundsview.size.height)+growingTextView.frame.size.height;
}

-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
     //  [self settyping:@"false"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)AskQuestionAnser
{
    //[NSString stringWithFormat:@"%@--%@",_reciver,[[Constantobject sharedInstance]getloggedchannel]];
//   // [[ChatConfig sharedInstance]unsubscribechannle:conversationchahhel];
//    [[ChatConfig sharedInstance]updatestatus:@"isTyping" andvalue:@"true" anduuid:[[Constantobject sharedInstance]getloggedchannel] andchannel:conversationchahhel];
    
    
    //if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER]) {
        
        if (conversationarray.count) {
          SYCChatConversation *conversationchannel2=conversationarray.lastObject;
            if (conversationchannel2.answer.length) {
                [self postMessage];//ask question
            }
            else
                
            {
                if ([conversationchannel2.asker_id isEqual:conversationchannel.sycSender]) {
                    [[Constantobject sharedInstance]showAlertWithText:self andmessagetitle:nil andmessagetext:SYCNOTFINDANSWER];
                }
                else
                     [self postMessage];//give answer
                
            }
            
        }
        else
            [self postMessage];
//    }
//    else
//        [self postMessage];
   
}
-(void)postMessage
{
    if (textView.text.length) {
        [self sendMessage];
        //
//        [[ChatConfig sharedInstance]hearPerticularChannel:_reciver callback:^(bool sent) {
//            
//            if (sent) {
//                
//                [self sendMessage];
//            }
//            else
//            {
//                [[Constantobject sharedInstance]showAlertWithText:self andmessagetitle:nil andmessagetext:SYCOFFLINEERROR];
//            }
//        }];
        
        
        
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
- (void)viewWillDisappear:(BOOL)animated
{
    [self settyping:@"false"];
    NSString *conversationchahhel=@"TYPINGCHANNEL";//[[Constantobject sharedInstance]TypingToChannel:_reciver];
    [[ChatConfig sharedInstance]unsubscribechannle:conversationchahhel];
    [checktypingstatus invalidate];
    [checktypingstatusval invalidate];
}
-(void)isTypingUpdate:(NSNotification *)anote
{
    NSDictionary *dict = [anote userInfo];
    if ([[dict objectForKey:@"isTyping"] isEqualToString:@"true"]) {
        _lblIsTyping.hidden=NO;
        _lblIsTyping.text=[NSString stringWithFormat:@"%@ is Typing.....",[dict objectForKey:@"isTypingUuid"]];
    }
    else
        _lblIsTyping.hidden=YES;
  //  AnyClass *objectIWantToTransfer = [dict objectForKey:@"objectName"];
}
-(void)settyping:(NSString*)status
{
    val=status;
    NSString *conversationchahhel=@"TYPINGCHANNEL";//[[Constantobject sharedInstance]TypingToChannel:_reciver];
   // [[ChatConfig sharedInstance]unsubscribechannle:conversationchahhel];
    [[ChatConfig sharedInstance]updatestatus:@"isTyping" andvalue:status andtotyping:_reciver anduuid:[[Constantobject sharedInstance]getloggedchannel] andchannel:conversationchahhel];
}
-(void)sendMessage
{
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:textView.text forKey:@"message"];
    [msg setValue:[[Constantobject sharedInstance]getlogged] forKey:@"sendormode"];
    [msg setValue:[[Constantobject sharedInstance]getloggedchannel] forKey:@"sendorchannel"];
    [msg setValue:@"mycategory" forKey:@"sendorcategory"];
    
    [[ChatConfig sharedInstance]sendmessage:msg andtochannel:_reciver callback:^(bool sent) {
        
        if (sent)
        {
            NSLog(@"send!");
            
            [self settyping:@"false"];
           // if ([[[Constantobject sharedInstance]getlogged]isEqualToString:SYCCHATMODEASKER]) {
               SYCChatConversation *chatcove=  [conversationarray lastObject]; 
            if (chatcove.answer.length) {
                
            
            [[SYCRequestManager sharedInstance]askQuestion:textView.text andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver andTask:@"askQuestion" callback:^(bool send) {
                
                if (send) {
//                    [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.asker_id andMentorChannel:conversationchannel.mentor_id anduser_id:@"1"  callback:^(NSArray *send) {
//                        if (send) {
//                            conversationarray=send;
//                            [self.tblconversation reloadData];
//                        }
//                        
//                    }];
                    
                    
                    
//                    [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver andquestion:textView.text andlistanswer:nil anduser_id:@"" callback:^(NSArray *Responsearray) {
//                        conversationarray=Responsearray;
//                        [self.tblconversation reloadData];
//                         textView.text=@"";
//                    }];
                    [self loadchat];
                    
                }
            }];
           
           }
            else
            {
            //-----for mentor-------------
              SYCChatConversation *chatcove=  [conversationarray lastObject];
                if (chatcove) {
          
                [[SYCRequestManager sharedInstance] giveAnswerbyid:chatcove.qusetion_id andAnswer:textView.text andTask:@"submitAnswerByEducatorMentor" callback:^(bool send) {
                    
                    if (send) {
//                        [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.asker_id andMentorChannel:conversationchannel.mentor_id anduser_id:@"2" callback:^(NSArray *send) {
//                            if (send) {
//                                conversationarray=send;
//                                [self.tblconversation reloadData];
//                            }
//                            
//                        }];
                        
//                        [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver andquestion:nil andlistanswer:textView.text anduser_id:@"" callback:^(NSArray *Responsearray) {
//                            conversationarray=Responsearray;
//                            [self.tblconversation reloadData];
//                             textView.text=@"";
//                        }];
                        [self loadchat];
                    }
                    
                }];
            }
            else
            {
                [[SYCRequestManager sharedInstance]askQuestion:textView.text andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver andTask:@"askQuestion" callback:^(bool send) {
                    
                    if (send) {
                        //                    [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.asker_id andMentorChannel:conversationchannel.mentor_id anduser_id:@"1"  callback:^(NSArray *send) {
                        //                        if (send) {
                        //                            conversationarray=send;
                        //                            [self.tblconversation reloadData];
                        //                        }
                        //
                        //                    }];
                        
                        
                        
//                        [[SYCRequestManager sharedInstance]getChatListforquestionanswer:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver andquestion:textView.text andlistanswer:nil anduser_id:@"" callback:^(NSArray *Responsearray) {
//                            conversationarray=Responsearray;
//                            [self.tblconversation reloadData];
//                            textView.text=@"";
//                        }];
                        
                        [self loadchat];
                        
                    }
                }];

            }
        
            }
            
            
           
           // [[Constantobject sharedInstance]showAlertWithMessage:@"SEND!" withTitle:nil withCancelTitle:SYCOK];
        }
        else
          //  NSLog(@"send error!");
        {
            [[Constantobject sharedInstance]showAlertWithText:self andmessagetitle:SYCMESSAGESENDERROR andmessagetext:SYCOK];
        }
        
    }];
}

-(void)loadchat
{
   
   
    /*---------online case---------*/
    [[SYCRequestManager sharedInstance]getChatList:@"getQuestionAnswerChat" andAskerChannel:conversationchannel.sycSender andMentorChannel:conversationchannel.sycReciver anduser_id:@"1"  callback:^(NSArray *send) {
        if (send) {
            conversationarray=send;
            [self.tblconversation reloadData];
        }
        
    }];
    //*---------offline case---------*//
//    NSString *getfilename;
//   if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER])
//       getfilename= [NSString stringWithFormat:@"%@-%@",[[Constantobject sharedInstance]getloggedchannel],_reciver];
//    else
//       getfilename= [NSString stringWithFormat:@"%@-%@",_reciver,[[Constantobject sharedInstance]getloggedchannel]];
//    
//    NSArray *offlinearray=[[SYCChatModule sharedInstance]readToSycChat:getfilename];
//   SYCChatConversation *conv=[[SYCChatConversation alloc]init];
//    conversationarray=[conv getListConversation:offlinearray];
//    [self.tblconversation reloadData];
}
@end

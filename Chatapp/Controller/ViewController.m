//
//  ViewController.m
//  Chatapp
//
//  Created by umenit on 1/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
_loggedtext.text=[NSString stringWithFormat:@"%@%@",SYCCHANNELMENTORPREFIX,@"dautor@gmail.com"];//
//_loggedtext.text=[NSString stringWithFormat:@"%@%@",SYCCHANNELMENTORPREFIX,@"asas@gmail.com"];
//_loggedtext.text=[NSString stringWithFormat:@"%@%@",SYCCHANNELMENTORPREFIX,@"paulkemp@gmail.com"];//
//_loggedtext.text=[NSString stringWithFormat:@"%@%@",SYCCHANNELASKERPREFIX,@"bill@gmail.com"]; //@"dautor@gmail.com";//@"my@gmail.com";//@"my.gmail.com";//mentor@gmail.com//  "dautor@gmail.com" "email@email.com"
    // Do any additional setup after loading the view, typically from a nib.//@"dautor@gmail.com";//
//    [[SYCRequestManager sharedInstance]checkdata:@"" callback:^(NSAttributedString *send) {
//        [_lbltxt setAttributedText:send];
//    }];
      self.revealViewController.panGestureRecognizer.enabled=NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnchatclicked:(id)sender {
   
    if ([_btnmode.titleLabel.text isEqualToString:SYCCHATMODEASKER])
        [[Constantobject sharedInstance]setmodeoflooged:SYCCHATMODEASKER andstringforlogged:_loggedtext.text];
    else
        [[Constantobject sharedInstance]setmodeoflooged:SYCCHATMODEMENTOR andstringforlogged:_loggedtext.text];
    if (_loggedtext.text.length) {
      //  ChatConfig *chaat=[[ChatConfig alloc]init];
     //   chaat.delegateconfig=self;
        
        [[ChatConfig sharedInstance]initConfig:_loggedtext.text andprotocol:self];
    }
    
}
-(void)hearchannle
{
    [[ChatConfig sharedInstance] hereAllChannels];
}
-(void)updatestatus:(BOOL)status
{
   //if (status==true && [[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER]) {
    if (status==true) {
        AppDelegate *vv2=[[AppDelegate alloc]init];
        [vv2 refreshpresence];
//        [NSTimer scheduledTimerWithTimeInterval: 2.0 target: self
//                                       selector: @selector(hearchannle) userInfo: nil repeats: YES];
        
//    [[ChatConfig sharedInstance] hereall:(nil) callback:^(NSArray *allchanels) {
//        
//        if (allchanels) {
        //[[ChatConfig sharedInstance]updatestatus:@"isTyping" andvalue:@"true" anduuid:[[Constantobject sharedInstance]getloggedchannel] andchannel:@""];
           OnlineuserViewController *vv=(OnlineuserViewController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"OnlineuserViewControllerid"];
//            vv.allmentor=allchanels;
           [self.navigationController pushViewController:vv animated:YES];
//        }
//    }];
        }
//    else if(status==true)
//    {
//        
//        SYCAskerQusetionController *vv=(SYCAskerQusetionController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCAskerQusetionControllerId"];
//        
//        [self.navigationController pushViewController:vv animated:YES];
//    }
}
- (IBAction)btnmodeClicked:(id)sender
{
    //if ([_btnmode.titleLabel.text containsString:SYCCHANNELMENTORPREFIX])
    if ([_btnmode.titleLabel.text isEqualToString:SYCCHATMODEASKER])
        [_btnmode setTitle:SYCCHATMODEMENTOR forState:UIControlStateNormal];
        else
      [_btnmode setTitle:SYCCHATMODEASKER forState:UIControlStateNormal];
}

@end




//
//  Constantobject.m
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "Constantobject.h"

@implementation Constantobject
+ (Constantobject *)sharedInstance {
    static Constantobject *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[Constantobject alloc] init];
    });
    return __instance;
}
-(void)allocInit
{
    _allmessage=[[NSMutableDictionary alloc]init];
    _client=[[PubNub alloc]init];
    _allcontact=[[NSMutableArray alloc]init];
    _onlineMentorList=[[NSArray alloc]init];
    _allMentorList=[[NSArray alloc]init];
}
-(void)setmodeoflooged:(NSString*)mode andstringforlogged:(NSString*)logged
{
    if (mode.length) {
    [[NSUserDefaults standardUserDefaults] setObject:mode forKey:@"Modelogged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Modelogged"];
    
    [[NSUserDefaults standardUserDefaults] setObject:logged forKey:@"Modeloggedchannel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString*)getlogged
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Modelogged"];
    return savedValue;
}
-(NSString*)getloggedchannel
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Modeloggedchannel"];
    return savedValue;
}

-(UIViewController *)getviewcontrollerbyid:(NSString*)identifier
{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:identifier];
  
    return viewController;
}

-(NSString*)TypingToChannel:(NSString*)reciver
{
    NSString *conversationchahhel;
    if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER])
     conversationchahhel=[NSString stringWithFormat:@"%@--%@",[[Constantobject sharedInstance]getloggedchannel],reciver];
        else
           conversationchahhel=[NSString stringWithFormat:@"%@--%@",reciver,[[Constantobject sharedInstance]getloggedchannel]];
        return conversationchahhel;
}
-(NSArray*)arr
{
    NSMutableDictionary *dd=[[NSMutableDictionary alloc]init];
    [dd setObject:@"ASK_my@gmail.com" forKey:@"Asker_id"];
     [dd setObject:@"Question is what is caching in tech?" forKey:@"Asker_question"];
    [dd setObject:@"1" forKey:@"Asker_question_id"];
     [dd setObject:@"0" forKey:@"Asker_question_status"];
    NSArray *arr=[[NSArray alloc]initWithObjects:dd, nil];
    return  arr;
    
}
-(void)showAlertWithMessage:(NSString *)message withTitle:(NSString *)title withCancelTitle:(NSString *)cancelTitle {
    
    self.alertview = nil;
    
    if (!self.alertview) {
        
        self.alertview = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
        
        [self.alertview show];
    }
}
-(void)showAlertWithText:(UIViewController*)viewcontroller andmessagetitle:(NSString*)title andmessagetext:(NSString*)text
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [viewcontroller presentViewController:alertController animated:YES completion:nil];
}
@end

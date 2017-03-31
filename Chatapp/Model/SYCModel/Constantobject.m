


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
@end

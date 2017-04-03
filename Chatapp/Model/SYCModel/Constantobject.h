//
//  Constantobject.h
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>
@import UIKit;
@interface Constantobject : NSObject
+(Constantobject*) sharedInstance;
@property (strong,nonatomic) NSMutableArray *allcontact;
@property (strong,nonatomic) NSMutableDictionary *allmessage;
@property (strong,nonatomic) NSArray *onlinecontact;
@property (strong,nonatomic) NSArray *onlineMentorList;
@property (strong,nonatomic) NSArray *allMentorList;
@property (nonatomic, strong) PubNub *client;
-(void)allocInit;
-(void)setmodeoflooged:(NSString*)mode andstringforlogged:(NSString*)logged;
-(NSString*)getlogged;
-(NSString*)getloggedchannel;
-(UIViewController *)getviewcontrollerbyid:(NSString*)identifier;
-(NSString*)TypingToChannel:(NSString*)reciver;
@end

//
//  SYCRequestManager.h
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//
#define BASEURL @"http://54.153.81.118/floovrWeb/fapi/v2/index.php"
#import <Foundation/Foundation.h>
//#import "AFURLSessionManager.h"
#import <RestKit/RestKit.h>
@interface SYCRequestManager : NSObject
@property(strong,nonatomic) RKObjectManager *MANAGERBASEURL;

+ (SYCRequestManager *)sharedInstance;
-(void)Requestforlist:(NSString*)name callback:(void (^)(NSArray *allchanels))callback;
-(void)askQuestion:(NSString*)Qustion andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel andTask:(NSString*)taskName callback:(void (^)(bool send))callback;
-(void)getChatList:(NSString*)taskName andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel callback:(void (^)(NSArray* Responsearray))callback;
-(void)giveAnswerbyid:(NSString*)Qustionid andAnswer:(NSString*)answer andTask:(NSString*)taskName callback:(void (^)(bool send))callback;
-(void)checkdata:(NSString*)Qustionid  callback:(void (^)(NSAttributedString *send))callback;
- (void)ResponseObjectMappingConfiguration;
@end

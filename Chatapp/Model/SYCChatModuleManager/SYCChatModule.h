//
//  SYCChatModule.h
//  Chatapp
//
//  Created by umenit on 4/5/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCChatModule : NSObject
+(SYCChatModule*) sharedInstance;
//-(void)saveget:(NSData*)urldata andfilename:(NSString*)filename;
//-(void)getData:(NSString*)filename;
-(void)writeToSycChat:(NSData*)fiedata atFilePath:(NSString*)filepath;
-(NSArray*)readToSycChat:(NSString*)filename;
-(void)removechatlist;
@end

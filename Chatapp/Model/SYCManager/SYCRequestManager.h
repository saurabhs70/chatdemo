//
//  SYCRequestManager.h
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLSessionManager.h"
@interface SYCRequestManager : NSObject
-(void)Requestforlist;
+ (SYCRequestManager *)sharedInstance;
-(void)Requestforlist:(NSString*)name callback:(void (^)(NSArray *allchanels))callback;
@end
//
//  SYCDataManager.h
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface SYCDataManager : NSObject
{
     NSString *databasePath;
}
+ (SYCDataManager *)sharedInstance;
-(BOOL)createDB;
- (BOOL) saveData:(NSString*)message_sender andmessagereciver:(NSString*)message_reciver
       andmessage:(NSString*)message_message andmessagecategory:(NSString*)message_category;
- (NSArray*) searchmessagehistory:(NSString*)MessageSender andmessagerecievedby:(NSString*)messagereciver;
- (int) GetArticlesCount:(NSString*)MessageSender andmessagerecievedby:(NSString*)messagereciver;
@end

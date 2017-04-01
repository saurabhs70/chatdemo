//
//  SYCDataManager.m
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCDataManager.h"
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
@implementation SYCDataManager
+ (SYCDataManager *)sharedInstance {
    static SYCDataManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[SYCDataManager alloc] init];
    });
    return __instance;
}
-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"chat.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
             //message_id sender reciver mesasage category timestamp
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists chatinfo (message_id integer primary key, message_sender text, message_reciver text,message_message text,message_category text,message_timestamp text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL) saveData:(NSString*)message_sender andmessagereciver:(NSString*)message_reciver
       andmessage:(NSString*)message_message andmessagecategory:(NSString*)message_category
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into chatinfo (message_sender,message_reciver, message_category,message_message,message_timestamp) values (\"%@\",\"%@\", \"%@\", \"%@\",\"%d\")",
                                message_sender, message_reciver, message_message,message_category,1];
                                const char *insert_stmt = [insertSQL UTF8String];
                                sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                if (sqlite3_step(statement) == SQLITE_DONE)
                                {
                                     sqlite3_reset(statement);
                                    return YES;
                                }
                                else {
                                    NSLog(@"Insert failure: %s", sqlite3_errmsg(database));
                                     sqlite3_reset(statement);
                                    return NO;
                                }
        
}
 return NO;
}
                                
- (NSArray*) searchmessagehistory:(NSString*)MessageSender andmessagerecievedby:(NSString*)messagereciver
        {
            const char *dbpath = [databasePath UTF8String];
            if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            {
                //SELECT * FROM chatinfo where (message_reciver="shyam@gmail.com" and message_message="secon") or (message_reciver="secon" and message_message="shyam@gmail.com")
                
          // NSString *querySQL = [NSString stringWithFormat: @"select message_sender, message_reciver, message_message,message_category from chatinfo where message_reciver=\"%@\"",messagereciver];
                
            NSString *querySQL = [NSString stringWithFormat: @"SELECT message_sender,message_reciver,message_message  FROM chatinfo where (message_sender=\"%@\" and message_reciver=\"%@\") or (message_reciver=\"%@\" and message_sender=\"%@\")",MessageSender,messagereciver,messagereciver,MessageSender];
                const char *query_stmt = [querySQL UTF8String];
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                if (sqlite3_prepare_v2(database,
                                       query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                   // if (sqlite3_step(statement) == SQLITE_ROW)
                    while(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSMutableDictionary *_dataDictionary=[[NSMutableDictionary alloc] init];
                        NSString *message_sender = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)];
                      //  [resultArray addObject:name];
                        
                        NSString *message_reciver = [[NSString alloc] initWithUTF8String:
                                                (const char *) sqlite3_column_text(statement, 1)];
                       
                        NSString *message_message = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 2)];
                        [_dataDictionary setObject:message_sender forKey:@"message_sender"];
                        [_dataDictionary setObject:message_reciver forKey:@"message_reciver"];
                        [_dataDictionary setObject:message_message forKey:@"message_message"];
                        [resultArray addObject:_dataDictionary];
                        // sqlite3_reset(statement);
                       
                        
                    }
                     sqlite3_finalize(statement);
                    return resultArray;
//                    else{
//                        sqlite3_finalize(statement);
//                      //   sqlite3_reset(statement);
//                        NSLog(@"Not found");
//                        return nil;
//                    }
                   
                }
            }
            return nil;
        }

- (int) GetArticlesCount:(NSString*)MessageSender andmessagerecievedby:(NSString*)messagereciver
{
    int count = 0;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM chatinfo where (message_reciver=\"%@\" and message_message=\"%@\") or (message_reciver=\"%@\" and message_message=\"%@\")",messagereciver,MessageSender,MessageSender,messagereciver];
        const char* sqlStatement = [querySQL UTF8String];
        sqlite3_stmt *statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
        {
            //Loop through all the returned rows (should be just one)
            while( sqlite3_step(statement) == SQLITE_ROW )
            {
                count = sqlite3_column_int(statement, 0);
            }
        }
       
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        //sqlite3_close(articlesDB);
    }
    
    return count;
}
@end

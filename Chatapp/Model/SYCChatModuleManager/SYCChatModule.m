//
//  SYCChatModule.m
//  Chatapp
//
//  Created by umenit on 4/5/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCChatModule.h"

@implementation SYCChatModule
+ (SYCChatModule *)sharedInstance {
    static SYCChatModule *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[SYCChatModule alloc] init];
    });
    return __instance;
}

-(NSArray*)getData:(NSString*)filename
{

    NSArray *array;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (fileExists)
    {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filename];
        if (data)
        array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
 }
    return array;
}
-(NSString*)getpath:(NSString*)folderName andfilename:(NSString*)Filename
{
    NSString *dataPath;
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    if ([Filename isEqualToString:SYCONLINEDOCLIST])
        dataPath  = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",SYCONLINEDOC]];
    else
        dataPath  = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",SYCCHATDOC]];
 //  dataPath  = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",SYCCHATDOC]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
  NSString *filePath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",Filename]];
    
    return  filePath;
   
}
-(void)writeToSycChat:(NSData*)fiedata atFilePath:(NSString*)filepath
{
    NSString *filepathtowrite=[self getpath:nil andfilename:filepath];
    [fiedata writeToFile:filepathtowrite atomically:YES];
    
}
-(NSArray*)readToSycChat:(NSString*)filename
{
     NSString *filepathtowrite=[self getpath:nil andfilename:filename];
  NSArray *arr=  [self getData:filepathtowrite];
    return arr;
}
-(void)removechatlist
{
    NSString *dataPath;
    
   // NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
  
        dataPath  = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",SYCCHATDOC]];
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:nil];
}
@end

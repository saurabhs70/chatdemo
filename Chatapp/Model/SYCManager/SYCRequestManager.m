
//
//  SYCRequestManager.m
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCRequestManager.h"

@implementation SYCRequestManager
+ (SYCRequestManager *)sharedInstance {
    static SYCRequestManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[SYCRequestManager alloc] init];
    });
    return __instance;
}
-(void)Requestforlist:(NSString*)name callback:(void (^)(NSArray *allchanels))callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURL *URL = [NSURL URLWithString:@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    // request.HTTPBody = [xml dataUsingEncoding:NSUTF8StringEncoding];
    //request.HTTPMethod = @"POST";
    //[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            callback (nil);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            // NSString *newStr = [json_string substringWithRange:NSMakeRange(2, [json_string length]-2)];
            NSData* data = [json_string dataUsingEncoding:NSUTF8StringEncoding];
            
            
            if (data)
            {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr=[[jsonDict objectForKey:@"response"] objectForKey:@"mentor_educator_list"];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arr];
         //  [self savejson:data];
                [[SYCChatModule sharedInstance]writeToSycChat:data2 atFilePath:@"MENTOR-LIST"];
            }
//
//            }
//            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSArray *arr=[[jsonDict valueForKey:@"response"] valueForKey:@"mentor_educator_list"];
//            if (jsonDict) {
//                NSMutableArray *mainarray=[[NSMutableArray alloc]init];
//                for (NSDictionary *dd in arr) {
//                    [mainarray addObject:[dd valueForKey:@"email"]];
//                }
            
                callback (nil);//[self getjson]
                //NSLog(@"%@",mainarray);
                // NSLog(@"%@",jsonDict);
        
            
        }
        
    }];
    [dataTask resume];

}
-(void)savejson:(NSData*)urldata
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
    [urldata writeToFile:filePath atomically:YES];
    
    
    [self getjson];
    
    
    
}
-(NSArray*)getjson
{
//    NSString *searchFilename = @"data.json"; // name of the PDF you are searching for
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:documentsDirectory];
//    
//    NSString *documentsSubpath;
//    while (documentsSubpath = [direnum nextObject])
//    {
//        if (![documentsSubpath.lastPathComponent isEqual:searchFilename]) {
//            continue;
//        }
//        
//        NSLog(@"found %@", documentsSubpath);
//    }
    NSMutableArray *mainarray=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
    NSLog(@"%@",plistLocation);
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:plistLocation];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (jsonDict) {
    NSArray *arr=[[jsonDict valueForKey:@"response"] valueForKey:@"mentor_educator_list"];
        for (NSDictionary *dd in arr)
            [mainarray addObject:[dd valueForKey:@"email"]];
    }
    return mainarray;
}
@end

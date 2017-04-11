
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
            callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
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
                [[SYCChatModule sharedInstance]writeToSycChat:data2 atFilePath:SYCONLINEDOCLIST];
                
            }
            callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
//
//            }
//            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSArray *arr=[[jsonDict valueForKey:@"response"] valueForKey:@"mentor_educator_list"];
//            if (jsonDict) {
//                NSMutableArray *mainarray=[[NSMutableArray alloc]init];
//                for (NSDictionary *dd in arr) {
//                    [mainarray addObject:[dd valueForKey:@"email"]];
//                }
            
              //  callback (nil);//[self getjson]
                //NSLog(@"%@",mainarray);
                // NSLog(@"%@",jsonDict);
        
            
        }
        
    }];
    [dataTask resume];

}
-(void)askQuestion:(NSString*)Qustion andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel andTask:(NSString*)taskName callback:(void (^)(bool send))callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *result = [Qustion stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&mentor_educator_channel_id=%@&question=%@",SYCBASEURL,taskName,askerChannel,mentorChannel,result];
    NSURL *URL = [NSURL URLWithString:callurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
  
    
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
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                
                if ([[[json valueForKey:@"response"]valueForKey:@"success"] isEqualToString:@"true"])
                callback (YES);
                else
                    callback (false);
            }
            else
                callback (nil);
         
            
            
        }
        
    }];
    [dataTask resume];
    
}

-(void)giveAnswerbyid:(NSString*)Qustionid andAnswer:(NSString*)answer andTask:(NSString*)taskName callback:(void (^)(bool send))callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *result = [answer stringByAddingPercentEncodingWithAllowedCharacters:set];
    
//http://138.68.175.0/api/index.php?task=submitAnswerByEducatorMentor&question_id=4&answer=test%20data%20answer

    NSString *callurl=[NSString stringWithFormat:@"%@?task=%@&question_id=%@&answer=%@",SYCBASEURL,taskName,Qustionid,result];
    NSURL *URL = [NSURL URLWithString:callurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
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
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                
                if ([[[json valueForKey:@"response"]valueForKey:@"success"] isEqualToString:@"true"])
                    callback (YES);
                else
                    callback (false);
            }
            else
                callback (nil);
            
            
            
        }
        
    }];
    [dataTask resume];
    
}
-(void)getChatList:(NSString*)taskName andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel callback:(void (^)(NSArray *Responsearray))callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // http://floovr.in/syc/index.php?task=getQuestionAnswerChat&asker_channel_id=ASK_email1@email.com
    
    //NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    //NSString *result = [Qustion stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *callurl;
    NSString *filepath;
    if (askerChannel.length && mentorChannel.length )
    {
    callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&mentor_educator_channel_id=%@",SYCBASEURL,taskName,askerChannel,mentorChannel];
        filepath=[NSString stringWithFormat:@"%@-%@",askerChannel,mentorChannel];
    }
    else if (askerChannel.length)
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@",SYCBASEURL,taskName,askerChannel];
        filepath=askerChannel;
    }
    else if (mentorChannel.length)
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&mentor_educator_channel_id=%@",SYCBASEURL,taskName,mentorChannel];
        filepath=mentorChannel;
    }
    NSURL *URL = [NSURL URLWithString:callurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
          //  callback (nil);
            NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
            NSMutableArray *listarray=[[NSMutableArray alloc]init];
            for (NSDictionary *dict in gg) {
                SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[dict objectForKey:@"asker_id"] andMentorId:[dict objectForKey:@"mentor_id"] andQuestionId:[dict objectForKey:@"qusetion_id"] andquestion:[dict objectForKey:@"question"] andquestimestamp:[dict objectForKey:@"qusetion_time"] andAnswerlist:[dict objectForKey:@"answer"]];
                [listarray addObject:chat];
                
            }
            if (askerChannel.length && mentorChannel.length )
            {
                NSArray *arrfinal=      [[listarray reverseObjectEnumerator] allObjects];
                callback (arrfinal);
            }
            else
                callback (listarray);
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            // NSString *newStr = [json_string substringWithRange:NSMakeRange(2, [json_string length]-2)];
            NSData* data = [json_string dataUsingEncoding:NSUTF8StringEncoding];
            
            
            if (data)
            {
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                NSArray *arr=[[json valueForKey:@"response"]valueForKey:@"response"];
                
                NSMutableArray *listarray=[[NSMutableArray alloc]init];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
                [[SYCChatModule sharedInstance]writeToSycChat:data atFilePath:filepath];
                NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
                NSLog(@"%lu shyam  %lu---%@",(unsigned long)gg.count,(unsigned long)arr.count,json_string);
                for (NSDictionary *dict in gg) {
                    SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[dict objectForKey:@"asker_id"] andMentorId:[dict objectForKey:@"mentor_id"] andQuestionId:[dict objectForKey:@"qusetion_id"] andquestion:[dict objectForKey:@"question"] andquestimestamp:[dict objectForKey:@"qusetion_time"] andAnswerlist:[dict objectForKey:@"answer"]];
                    [listarray addObject:chat];
                    
                }
                if (askerChannel.length && mentorChannel.length )
                {
          NSArray *arrfinal=      [[listarray reverseObjectEnumerator] allObjects];
                callback (arrfinal);
                }
                else
                callback (listarray);
            }
            else
                callback (nil);
            
            
            
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

-(void)checkdata:(NSString*)Qustionid  callback:(void (^)(NSAttributedString *send))callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
 //   NSString *result = [answer stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    //http://138.68.175.0/api/index.php?task=submitAnswerByEducatorMentor&question_id=4&answer=test%20data%20answer
    
    NSString *callurl=@"http://floovr.in/fapi/v2/get_product_details.php?p_id=4532";//[NSString stringWithFormat:@"%@?task=%@&question_id=%@&answer=%@",SYCBASEURL,taskName,Qustionid,result];
    NSURL *URL = [NSURL URLWithString:callurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
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
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                
                
                
                if ([json valueForKey:@"content_data"])
                {
                    NSString *ss=[self convertHTML:[json valueForKey:@"content_data"]];
                    NSAttributedString *vv=[[NSAttributedString alloc]initWithData:[[json valueForKey:@"content_data"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                    callback (vv);
                }
                else
                    callback (nil);
            }
            else
                callback (nil);
            
            
            
        }
        
    }];
    [dataTask resume];
    
}
-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}
@end

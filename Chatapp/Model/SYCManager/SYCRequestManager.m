
//
//  SYCRequestManager.m
//  Chatapp
//
//  Created by umenit on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCRequestManager.h"
#import "SYCMentor.h"
#import "SYCChatConversation.h"
#import "SYCChatConversationAnswer.h"
#import "SYCMessageStatus.h"
@interface SYCRequestManager () {
    RKObjectMapping* _firstobjOM;
   RKObjectMapping* _chatConvOM;
    RKObjectMapping* _chatConAnswervOM;
    RKObjectMapping* _MessageStatusOM;
}
@end
@implementation SYCRequestManager

@synthesize MANAGERBASEURL;

+ (SYCRequestManager *)sharedInstance {
    static SYCRequestManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[SYCRequestManager alloc] init];
    });
    return __instance;
}
-(void)BaseManager{
    NSURL *baseURL = [NSURL URLWithString:BASEURL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    //[client setDefaultHeader:@"sessiontoken" value:[PLSetupDataManager sharedInstance].token];
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    [RKObjectManager setSharedManager:objectManager];
    //  [[PPRequestManager sharedInstance]myFullName:objectManager];
    MANAGERBASEURL=objectManager;
}
- (void)ResponseObjectMappingConfiguration {
    _firstobjOM = [RKObjectMapping mappingForClass:[SYCMentor class]];
    [_firstobjOM addAttributeMappingsFromArray:@[@"work_experience_id",@"name",@"last_name",@"user_id",@"organization",@"role_name_organization",@"profile_pic_url",@"subject_id",@"subject_name",@"role_name",@"email"]];
    
     /*--------Question Answer Response---------*/
    _chatConvOM=[RKObjectMapping mappingForClass:[SYCChatConversation class]];
    [_chatConvOM  addAttributeMappingsFromArray:@[@"asker_id",@"mentor_id",@"qusetion_id",@"question",@"qusetion_timestamp",@"answer"]];
   
    /*----------question's answer------------*/
  //  SYCChatConversationAnswer
  
  _chatConAnswervOM=[RKObjectMapping mappingForClass:[SYCChatConversationAnswer class]];
    [_chatConAnswervOM  addAttributeMappingsFromArray:@[@"chat_time",]];
    /*--------Merge for Answer to chat question-------*/
    //[_chatConvOM addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"answer" toKeyPath:@"answer" withMapping:_chatConAnswervOM]];
    
    
    /*---------_MessageStatus--------*/
    
    _MessageStatusOM=[RKObjectMapping mappingForClass:[SYCMessageStatus class]];
     [_MessageStatusOM  addAttributeMappingsFromArray:@[@"success",@"message",]];
    
}
-(void)Requestforlist:(NSString*)name callback:(void (^)(NSArray *allchanels))callback
{
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:_firstobjOM method:RKRequestMethodGET pathPattern:nil keyPath:@"response.mentor_educator_list" statusCodes:successStatusCodes];
    
    //@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];mentor_educator_list
    
    // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/wp_mpfeedback"]];
   // NSString *strbase=@"http://138.68.175.0/api/index.php?task=getEducatorOrMentorListBySubjectId&subject_id=6&page_id=1";  response.mentor_or_educator_list
    NSString *strbase=@"http://floovr.in/syc/index.php?task=getEducatorMentorList";
    NSURL *url = [NSURL URLWithString:strbase];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    //[parameters setObject:ObjectOrNull(methodname) forKey:@"task"];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // parse the response---
        //NSArray *myDic = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:NSJSONReadingMutableLeaves error:nil];
        
       NSArray *list = mappingResult.array;
        if (list.count) {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (SYCMentor *mentorobj in list) {
                if ([mentorobj.role_name isEqualToString:SYCCHATMODEEDUCTOR])
                    
                mentorobj.loggedchannel=[NSString stringWithFormat:@"%@%@",SYCCHANNELEDUCATORPREFIX,mentorobj.email];
                else
                   mentorobj.loggedchannel=[NSString stringWithFormat:@"%@%@",SYCCHANNELMENTORPREFIX,mentorobj.email];
                [arr addObject:mentorobj];
            }
            NSArray *arr1=[self listarry:arr];
            arr=[[NSMutableArray alloc]init];
            [arr addObjectsFromArray:arr1];
            NSData *dataArray = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [[SYCChatModule sharedInstance]writeToSycChat:dataArray atFilePath:SYCONLINEDOCLIST];
        }
        callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
        //   Allsellerlist *gg=[arrlocation objectAtIndex:0];
       //callback(list);
        // NSLog(@"=======:%@",myDic);
        //NSLog(@"MY email============ %@ ",[myDic objectForKey:@"Email"]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        callback(nil);
        
    }];
    [operation start];
    


}
-(NSArray*)listarry:(NSMutableArray*)arr
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loggedchannel CONTAINS[cd] %@", [[Constantobject sharedInstance]getloggedchannel]];
    NSArray *results = [arr filteredArrayUsingPredicate:predicate];
    if (results.count) {
        SYCMentor *mentorobj =[results objectAtIndex:0];
        [arr removeObject:mentorobj];
        
    }
    return arr;
}
-(void)askQuestion:(NSString*)Qustion andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel andTask:(NSString*)taskName callback:(void (^)(bool send))callback
{
    
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *result = [Qustion stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&mentor_educator_channel_id=%@&question=%@",SYCBASEURL,taskName,askerChannel,mentorChannel,result];
    NSURL *URL = [NSURL URLWithString:callurl];
 //   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
  
   
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:_MessageStatusOM method:RKRequestMethodGET pathPattern:nil keyPath:@"response" statusCodes:successStatusCodes];
    
    //@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];mentor_educator_list
    
    // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/wp_mpfeedback"]];
    // NSString *strbase=@"http://138.68.175.0/api/index.php?task=getEducatorOrMentorListBySubjectId&subject_id=6&page_id=1";  response.mentor_or_educator_list
    
   // NSURL *url = [NSURL URLWithString:callurl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    //[parameters setObject:ObjectOrNull(methodname) forKey:@"task"];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // parse the response---
        //NSArray *myDic = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        SYCMessageStatus *list = mappingResult.array.lastObject;
        if ([list.success isEqualToString:@"true"])
            callback(YES);
        else
            callback(NO);
        //   callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
        //   Allsellerlist *gg=[arrlocation objectAtIndex:0];
        //callback(list);
        // NSLog(@"=======:%@",myDic);
        //NSLog(@"MY email============ %@ ",[myDic objectForKey:@"Email"]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        callback(nil);
        
    }];
    [operation start];

    
    
    
}

-(void)giveAnswerbyid:(NSString*)Qustionid andAnswer:(NSString*)answer andTask:(NSString*)taskName callback:(void (^)(bool send))callback
{
   
    
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *result = [answer stringByAddingPercentEncodingWithAllowedCharacters:set];
    
//http://138.68.175.0/api/index.php?task=submitAnswerByEducatorMentor&question_id=4&answer=test%20data%20answer

    NSString *callurl=[NSString stringWithFormat:@"%@?task=%@&question_id=%@&answer=%@",SYCBASEURL,taskName,Qustionid,result];
    NSURL *URL = [NSURL URLWithString:callurl];
    
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:_MessageStatusOM method:RKRequestMethodGET pathPattern:nil keyPath:@"response" statusCodes:successStatusCodes];
    
    //@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];mentor_educator_list
    
    // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/wp_mpfeedback"]];
    // NSString *strbase=@"http://138.68.175.0/api/index.php?task=getEducatorOrMentorListBySubjectId&subject_id=6&page_id=1";  response.mentor_or_educator_list
    
    // NSURL *url = [NSURL URLWithString:callurl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    //[parameters setObject:ObjectOrNull(methodname) forKey:@"task"];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // parse the response---
        //NSArray *myDic = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        SYCMessageStatus *list = mappingResult.array.lastObject;
        if ([list.success isEqualToString:@"true"])
            callback(YES);
        else
            callback(NO);
        //   callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
        //   Allsellerlist *gg=[arrlocation objectAtIndex:0];
        //callback(list);
        // NSLog(@"=======:%@",myDic);
        //NSLog(@"MY email============ %@ ",[myDic objectForKey:@"Email"]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        callback(nil);
        
    }];
    [operation start];
    
   
    
}
-(void)getChatList:(NSString*)taskName andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel anduser_id:(NSString*)user_id callback:(void (^)(NSArray *Responsearray))callback
{
    user_id=@"2";
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // http://floovr.in/syc/index.php?task=getQuestionAnswerChat&asker_channel_id=ASK_email1@email.com
    
    //NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    //NSString *result = [Qustion stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *callurl;
    NSString *filepath;
    if (askerChannel.length && mentorChannel.length )
    {
    callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&mentor_educator_channel_id=%@&user_id=%@",SYCBASEURL,taskName,askerChannel,mentorChannel,user_id];
        filepath=[NSString stringWithFormat:@"%@-%@",askerChannel,mentorChannel];
    }
    else // if (askerChannel.length)
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&user_id=%@",SYCBASEURL,taskName,user_id];
        filepath=askerChannel;
    }
//    else if (mentorChannel.length)
//    {
//        callurl=[NSString stringWithFormat:@"%@?task=%@&mentor_educator_channel_id=%@&user_id=%@",SYCBASEURL,taskName,mentorChannel,user_id];
//        filepath=mentorChannel;
//    }
  
    
    
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:_chatConvOM method:RKRequestMethodGET pathPattern:nil keyPath:@"response.response" statusCodes:successStatusCodes];
    
    //@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];mentor_educator_list
    
    // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/wp_mpfeedback"]];
    // NSString *strbase=@"http://138.68.175.0/api/index.php?task=getEducatorOrMentorListBySubjectId&subject_id=6&page_id=1";  response.mentor_or_educator_list
    
    NSURL *url = [NSURL URLWithString:callurl];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    //[parameters setObject:ObjectOrNull(methodname) forKey:@"task"];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // parse the response---
        //NSArray *myDic = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *list = mappingResult.array;
        if (list.count) {
          NSData *dataArray = [NSKeyedArchiver archivedDataWithRootObject:list];
            [[SYCChatModule sharedInstance]writeToSycChat:dataArray atFilePath:filepath];
        }
        NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
        NSLog(@"%@",@"ff");
//        if (askerChannel.length && mentorChannel.length )
//                            {
//                     NSArray *arrfinal=      [[gg reverseObjectEnumerator] allObjects];
//                            callback (arrfinal);
//                            }
//                            else
                            callback (gg);
        
     //   callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
        //   Allsellerlist *gg=[arrlocation objectAtIndex:0];
        //callback(list);
        // NSLog(@"=======:%@",myDic);
        //NSLog(@"MY email============ %@ ",[myDic objectForKey:@"Email"]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        callback(nil);
        
    }];
    [operation start];
    
    
    
    
    
//    
//    
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (error) {
//            NSLog(@"Error: %@", error);
//          //  callback (nil);
//            NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
//            NSMutableArray *listarray=[[NSMutableArray alloc]init];
//            for (NSDictionary *dict in gg) {
//                SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[dict objectForKey:@"asker_id"] andMentorId:[dict objectForKey:@"mentor_id"] andQuestionId:[dict objectForKey:@"qusetion_id"] andquestion:[dict objectForKey:@"question"] andquestimestamp:[dict objectForKey:@"qusetion_time"] andAnswerlist:[dict objectForKey:@"answer"]];
//                [listarray addObject:chat];
//                
//            }
//            if (askerChannel.length && mentorChannel.length )
//            {
//                NSArray *arrfinal=      [[listarray reverseObjectEnumerator] allObjects];
//                callback (arrfinal);
//            }
//            else
//                callback (listarray);
//            
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//            NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            // NSString *newStr = [json_string substringWithRange:NSMakeRange(2, [json_string length]-2)];
//            NSData* data = [json_string dataUsingEncoding:NSUTF8StringEncoding];
//            
//            
//            if (data)
//            {
//                NSError* error;
//                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                                     options:kNilOptions
//                                                                       error:&error];
//                NSArray *arr=[[json valueForKey:@"response"]valueForKey:@"response"];
//                
//                NSMutableArray *listarray=[[NSMutableArray alloc]init];
//                
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
//                [[SYCChatModule sharedInstance]writeToSycChat:data atFilePath:filepath];
//                NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
//                NSLog(@"%lu shyam  %lu---%@",(unsigned long)gg.count,(unsigned long)arr.count,json_string);
//                for (NSDictionary *dict in gg) {
//                    SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[dict objectForKey:@"asker_id"] andMentorId:[dict objectForKey:@"mentor_id"] andQuestionId:[dict objectForKey:@"qusetion_id"] andquestion:[dict objectForKey:@"question"] andquestimestamp:[dict objectForKey:@"qusetion_time"] andAnswerlist:[dict objectForKey:@"answer"]];
//                    [listarray addObject:chat];
//                    
//                }
//                if (askerChannel.length && mentorChannel.length )
//                {
//          NSArray *arrfinal=      [[listarray reverseObjectEnumerator] allObjects];
//                callback (arrfinal);
//                }
//                else
//                callback (listarray);
//            }
//            else
//                callback (nil);
//            
//            
//            
//        }
//        
//    }];
//    [dataTask resume];
    
}

-(void)getChatListforquestionanswer:(NSString*)taskName andAskerChannel:(NSString*)askerChannel andMentorChannel:(NSString*)mentorChannel andquestion:(NSString*)question andlistanswer:(NSString*)answerlist anduser_id:(NSString*)user_id callback:(void (^)(NSArray *Responsearray))callback
{
    //    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // http://floovr.in/syc/index.php?task=getQuestionAnswerChat&asker_channel_id=ASK_email1@email.com
    
    //NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    //NSString *result = [Qustion stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *callurl;
    NSString *filepath;
    if (askerChannel.length && mentorChannel.length )
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&mentor_educator_channel_id=%@&user_id=%@",SYCBASEURL,taskName,askerChannel,mentorChannel,user_id];
        filepath=[NSString stringWithFormat:@"%@-%@",askerChannel,mentorChannel];
    }
    else if (askerChannel.length)
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&asker_channel_id=%@&user_id=%@",SYCBASEURL,taskName,askerChannel,user_id];
        filepath=askerChannel;
    }
    else if (mentorChannel.length)
    {
        callurl=[NSString stringWithFormat:@"%@?task=%@&mentor_educator_channel_id=%@&user_id=%@",SYCBASEURL,taskName,mentorChannel,user_id];
        filepath=mentorChannel;
    }
    
    
    
//    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
//    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:_chatConvOM method:RKRequestMethodGET pathPattern:nil keyPath:@"response.response" statusCodes:successStatusCodes];
//    
    //@"http://floovr.in/syc/index.php?task=getEducatorMentorList"];mentor_educator_list
    
    // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/wp_mpfeedback"]];
    // NSString *strbase=@"http://138.68.175.0/api/index.php?task=getEducatorOrMentorListBySubjectId&subject_id=6&page_id=1";  response.mentor_or_educator_list
    
    NSURL *url = [NSURL URLWithString:callurl];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *dattime=[dateFormatter stringFromDate:[NSDate date]];
    
    
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];
   // [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
//    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    //[parameters setObject:ObjectOrNull(methodname) forKey:@"task"];
    
    //[operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // parse the response---
        //NSArray *myDic = [NSJSONSerialization JSONObjectWithData:operation.HTTPRequestOperation.responseData options:NSJSONReadingMutableLeaves error:nil];
        SYCChatConversation *chatconv;
    NSMutableArray *arr;
    arr =[[NSMutableArray alloc]init];
        NSArray *gg=[[SYCChatModule sharedInstance]readToSycChat:filepath];
        if (question.length) {
            
        
       chatconv =[[SYCChatConversation alloc]initWithSycConverstion:askerChannel andMentorId:mentorChannel andQuestionId:@"23" andquestion:question andquestimestamp:dattime andAnswerlist:nil Andsender:nil andReciver:nil];
            [arr addObjectsFromArray:gg];
            [arr addObject:chatconv];
        }
        else
        {
          chatconv=  gg.lastObject;
          //  NSArray *answer=[[NSArray alloc]initWithObjects:@"fffddf", nil];
            chatconv.answer=answerlist;
          // arr =[[NSMutableArray alloc]init];
            [arr addObjectsFromArray:gg];
            [arr replaceObjectAtIndex:arr.count-1 withObject:chatconv];
        }
       // NSArray *list = mappingResult.array;
        
    
        if (arr.count) {
            NSData *dataArray = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [[SYCChatModule sharedInstance]writeToSycChat:dataArray atFilePath:filepath];
      
        }
        NSArray *gg2=[[SYCChatModule sharedInstance]readToSycChat:filepath];
        NSLog(@"%@",@"ff");
//        if (askerChannel.length && mentorChannel.length )
//        {
//            NSArray *arrfinal=      [[gg reverseObjectEnumerator] allObjects];
//            callback (arrfinal);
//        }
//        else
            callback (gg2);
        
        //   callback ([[SYCChatModule sharedInstance]readToSycChat:SYCONLINEDOCLIST]);
        //   Allsellerlist *gg=[arrlocation objectAtIndex:0];
        //callback(list);
        // NSLog(@"=======:%@",myDic);
        //NSLog(@"MY email============ %@ ",[myDic objectForKey:@"Email"]);
    /*} failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        callback(nil);
        
    }];
    [operation start];
    
   */
    
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
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//   // NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
// //   NSString *result = [answer stringByAddingPercentEncodingWithAllowedCharacters:set];
//    
//    //http://138.68.175.0/api/index.php?task=submitAnswerByEducatorMentor&question_id=4&answer=test%20data%20answer
//    
//    NSString *callurl=@"http://floovr.in/fapi/v2/get_product_details.php?p_id=4532";//[NSString stringWithFormat:@"%@?task=%@&question_id=%@&answer=%@",SYCBASEURL,taskName,Qustionid,result];
//    NSURL *URL = [NSURL URLWithString:callurl];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (error) {
//            NSLog(@"Error: %@", error);
//            callback (nil);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//            NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            // NSString *newStr = [json_string substringWithRange:NSMakeRange(2, [json_string length]-2)];
//            NSData* data = [json_string dataUsingEncoding:NSUTF8StringEncoding];
//
//            
//            if (data)
//            {
//                NSError* error;
//                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                                     options:kNilOptions
//                                                                       error:&error];
//                
//                
//                
//                if ([json valueForKey:@"content_data"])
//                {
//                    NSString *ss=[self convertHTML:[json valueForKey:@"content_data"]];
//                    NSAttributedString *vv=[[NSAttributedString alloc]initWithData:[[json valueForKey:@"content_data"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
//                    callback (vv);
//                }
//                else
//                    callback (nil);
//            }
//            else
//                callback (nil);
//            
//            
//            
//        }
//        
//    }];
//    [dataTask resume];
    
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

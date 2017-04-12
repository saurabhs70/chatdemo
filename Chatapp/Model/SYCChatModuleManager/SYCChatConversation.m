//
//  SYCChatConversation.m
//  Chatapp
//
//  Created by umenit on 4/6/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCChatConversation.h"

@implementation SYCChatConversation
@synthesize asker_id,mentor_id,qusetion_id,answer,qusetion_time,question;
-(id)initWithSycConverstion:(NSString*)askerId andMentorId:(NSString*)mentorId andQuestionId:(NSString*)questionId andquestion:(NSString*)questiontitle andquestimestamp:(NSString*)timesamp andAnswerlist:(NSArray*)Answerlist
{
    self=[super init];
    if (self) {
        asker_id=askerId;
        mentor_id=mentorId;
        qusetion_id=questionId;
        answer=Answerlist;
        qusetion_time=timesamp;
        question=questiontitle;
        
       
        
    }
    return self;
}
-(NSArray*)getListConversation:(NSArray*)listarray
{
    NSMutableArray *listarrayfinal=[[NSMutableArray alloc]init];
    for (NSDictionary *conversation in listarray) {
         SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[conversation objectForKey:@"asker_id"] andMentorId:[conversation objectForKey:@"mentor_id"] andQuestionId:[conversation objectForKey:@"qusetion_id"]andquestion:[conversation objectForKey:@"question"] andquestimestamp:[conversation objectForKey:@"qusetion_time"] andAnswerlist:[conversation objectForKey:@"answer"]];
        [listarrayfinal addObject:chat];
    }
    return listarrayfinal;
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:asker_id forKey:@"asker_id"];
    [encoder encodeObject:mentor_id forKey:@"mentor_id"];
    [encoder encodeObject:qusetion_id forKey:@"qusetion_id"];
     [encoder encodeObject:question forKey:@"question"];
    [encoder encodeObject:qusetion_time forKey:@"qusetion_timestamp"];
    [encoder encodeObject:answer forKey:@"answer"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    asker_id = [decoder decodeObjectForKey:@"asker_id"];
    mentor_id = [decoder decodeObjectForKey:@"mentor_id"];
    qusetion_id=[decoder decodeObjectForKey:@"qusetion_id"];
      question=[decoder decodeObjectForKey:@"question"];
    qusetion_time= [decoder decodeObjectForKey:@"qusetion_timestamp"];
   answer= [decoder decodeObjectForKey:@"answer"];
    return self;
}


@end

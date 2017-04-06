//
//  SYCChatConversation.m
//  Chatapp
//
//  Created by umenit on 4/6/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCChatConversation.h"

@implementation SYCChatConversation
@synthesize asker_id,mentor_id,qusetion_id,answer;
-(id)initWithSycConverstion:(NSString*)askerId andMentorId:(NSString*)mentorId andQuestionId:(NSString*)questionId andAnswerlist:(NSArray*)Answerlist
{
    self=[super init];
    if (self) {
        asker_id=askerId;
        mentor_id=mentorId;
        qusetion_id=questionId;
        answer=Answerlist;
       
        
    }
    return self;
}
-(NSArray*)getListConversation:(NSArray*)listarray
{
    NSMutableArray *listarrayfinal=[[NSMutableArray alloc]init];
    for (NSDictionary *conversation in listarray) {
         SYCChatConversation *chat=[[SYCChatConversation alloc]initWithSycConverstion:[conversation objectForKey:@"asker_id"] andMentorId:[conversation objectForKey:@"mentor_id"] andQuestionId:[conversation objectForKey:@"qusetion_id"] andAnswerlist:[conversation objectForKey:@"answer"]];
        [listarrayfinal addObject:chat];
    }
    return listarrayfinal;
}
@end

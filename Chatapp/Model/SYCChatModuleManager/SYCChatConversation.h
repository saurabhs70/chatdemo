//
//  SYCChatConversation.h
//  Chatapp
//
//  Created by umenit on 4/6/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCChatConversation : NSObject
@property (strong,nonatomic) NSString *asker_id;
@property (strong,nonatomic) NSString *mentor_id;
@property (strong,nonatomic) NSString *qusetion_id;
@property (strong,nonatomic) NSArray *answer;
-(id)initWithSycConverstion:(NSString*)askerId andMentorId:(NSString*)mentorId andQuestionId:(NSString*)questionId andAnswerlist:(NSArray*)Answerlist;
-(NSArray*)getListConversation:(NSArray*)listarray;
@end

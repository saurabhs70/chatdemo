//
//  SYCChatConversationAnswer.m
//  Chatapp
//
//  Created by umenit on 4/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCChatConversationAnswer.h"

@implementation SYCChatConversationAnswer
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_answer forKey:@"answer"];
    [encoder encodeObject:_chat_time forKey:@"chat_time"];
  
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    _answer = [decoder decodeObjectForKey:@"answer"];
    _chat_time = [decoder decodeObjectForKey:@"chat_time"];
   
    return self;
}

@end

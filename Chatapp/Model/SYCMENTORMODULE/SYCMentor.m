//
//  SYCMentor.m
//  Chatapp
//
//  Created by umenit on 4/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SYCMentor.h"

@implementation SYCMentor
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
     [encoder encodeObject:_name forKey:@"last_name"];
    [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:_work_experience_id forKey:@"work_experience_id"];
    [encoder encodeObject:_user_id forKey:@"user_id"];
    [encoder encodeObject:_organization forKey:@"organization"];
    [encoder encodeObject:_role_name_organization forKey:@"role_name_organization"];
    [encoder encodeObject:_profile_pic_url forKey:@"profile_pic_url"];
    [encoder encodeObject:_subject_id forKey:@"subject_id"];
    [encoder encodeObject:_subject_name forKey:@"subject_name"];
    [encoder encodeObject:_role_name forKey:@"role_name"];
    [encoder encodeObject:_loggedchannel forKey:@"loggedchannel"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    _name = [decoder decodeObjectForKey:@"name"];
     _last_name = [decoder decodeObjectForKey:@"last_name"];
    _email=[decoder decodeObjectForKey:@"email"];
    _work_experience_id= [decoder decodeObjectForKey:@"work_experience_id"];
    _user_id= [decoder decodeObjectForKey:@"user_id"];
    _organization=[decoder decodeObjectForKey:@"organization"];
    _role_name_organization=[decoder  decodeObjectForKey:@"role_name_organization"];
    _profile_pic_url=[decoder  decodeObjectForKey:@"profile_pic_url"];
    _subject_id=[decoder  decodeObjectForKey:@"subject_id"];
    _subject_name=[decoder  decodeObjectForKey:@"subject_name"];
    _role_name=[decoder  decodeObjectForKey:@"role_name"];
    _loggedchannel=[decoder  decodeObjectForKey:@"loggedchannel"];
    return self;
}

@end

//
//  Contact.m
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "Contact.h"

@implementation Contact
@synthesize firstName,lastName,image,phonenumbers;
-(id)initWithContact:(NSString*)firstname andsecondname:(NSString*)secondname andimage:(UIImage*)imageof andphones:(NSArray*)phonesnumber
{
  self=[super init];
   if (self) {
        firstName=firstname;
       lastName=secondname;
       image=imageof;
       phonenumbers=phonesnumber;

   }
    return self;
}

@end

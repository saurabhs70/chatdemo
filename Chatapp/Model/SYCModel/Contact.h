//
//  Contact.h
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Contact : NSObject
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSArray *phonenumbers;
-(id)initWithContact:(NSString*)firstname andsecondname:(NSString*)secondname andimage:(UIImage*)imageof andphones:(NSArray*)phonesnumber;
@end

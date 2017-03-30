//
//  ChatConfig.h
//  Chatapp
//
//  Created by umenit on 3/30/17.
//  Copyright © 2017 test. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>
@protocol delegateforconnection <NSObject>
-(void)updatestatus:(BOOL)status;
@end
@interface ChatConfig : NSObject<PNObjectEventListener>
@property (nonatomic, strong) PubNub *client;
+(ChatConfig*) sharedInstance;
-(void)initConfig:(NSString*)channelname andprotocol:(id<delegateforconnection>)delegate;
-(void)intiSubscribeChannel:(NSString*)channelname;
-(void)sendmessage:(NSString*)channelname;
@property(weak,nonatomic) id <delegateforconnection>delegateconfig;
-(void)hereall:(NSString*)modeviolator callback:(void (^)(NSArray *allchanels))callback;
@end

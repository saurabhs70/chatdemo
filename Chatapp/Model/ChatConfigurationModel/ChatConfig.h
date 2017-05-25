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

@property(weak,nonatomic) id <delegateforconnection>delegateconfig;
-(void)hereAllChannels;
-(void)sendmessage:(NSDictionary*)message andtochannel:(NSString*)channelname callback:(void (^)(bool sent))callback;
-(void)unsubscribechannle:(NSString*)channelname;
-(void)addmorechannel:(NSString*)channelname;
-(void)updatestatus:(NSString*)key andvalue:(NSString*)value andtotyping:(NSString*)to anduuid:(NSString*)uuid andchannel:(NSString*)chhhanel;
-(void)hearPerticularChannel:(NSString*)channel callback:(void (^)(bool sent))callback;
-(void)hearPerticularChannelforTyping:(NSString*)channel anduuid:(NSString*)uuidfortyping callback:(void (^)(bool sent))callback;
-(void)inticonfigsetsate:(NSString*)changestatue forchannel:(NSString*)channel;
@end

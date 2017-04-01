//
//  ChatConfig.m
//  Chatapp
//
//  Created by umenit on 3/30/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ChatConfig.h"

@implementation ChatConfig
@synthesize delegateconfig=_delegateconfig;
+ (ChatConfig *)sharedInstance {
    static ChatConfig *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[ChatConfig alloc] init];
    });
    return __instance;
}
-(void)initConfig:(NSString*)channelname andprotocol:(id<delegateforconnection>)delegate
{
    
        PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:SYCCHATPUBLICKEY subscribeKey:SYCCHATSECKEY];
        configuration.uuid=channelname;// 4s_id simulator_id 5555648583
        //configuration.presenceHeartbeatInterval=20;//remove after
        //configuration.presenceHeartbeatValue=10;//againjoin
        configuration.presenceHeartbeatValue = SYCCHATHEARTBEAT;
        configuration.presenceHeartbeatInterval = SYCCHATHEARTBEATINTERVAL;
        self.client = [PubNub clientWithConfiguration:configuration];
        [self.client addListener:self];
  _delegateconfig=delegate;
    
        // Subscribe to demo channel with presence observation
        [self.client subscribeToChannels: @[channelname] withPresence:YES];// simulator
   
    
}
-(void)intiSubscribeChannel:(NSString*)channelname
{
    [self.client subscribeToChannels: @[channelname] withPresence:YES];
}
- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
     //message_id sender reciver mesasage category timestamp
    // Handle new message stored in message.data.message
    if (![message.data.channel isEqualToString:message.data.subscription]) {
        
        // Message has been received on channel group stored in message.data.subscription.
    }
    else {
//        NSDictionary *DD=[message.data valueForKey:@"message"];
//        NSString *RECIVER=[message.data valueForKey:@"channel"];
//        NSLog(@"");
//      [[SYCDataManager sharedInstance]saveData:[DD valueForKey:@"sendorchannel"] andmessagereciver:RECIVER andmessage:[DD valueForKey:@"message"] andmessagecategory:[DD valueForKey:@"sendorcategory"]];
//        NSArray *arr=   [[SYCDataManager sharedInstance]searchmessagehistory:[DD valueForKey:@"sendorchannel"] andmessagerecievedby:RECIVER];
//        
//        NSLog(@"");
        /*--------
         channel = "dautor@gmail.com";
         envelope = "<PNEnvelopeInformation: 0x600000283bb0>";
         message =     {
         message = Got;
         sendorcategory = mycategory;
         sendorchannel = "my@gmail.com";
         sendormode = Asker;
         };
         region = 4;
         subscription = "dautor@gmail.com";
         timetoken = 14910381502888578;

         */
        
        // Message has been received on channel stored in message.data.channel.
    }
}

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    
    if (status.operation == PNSubscribeOperation) {
       
        // Check whether received information about successful subscription or restore.
        if (status.category == PNConnectedCategory || status.category == PNReconnectedCategory) {
            
            // Status object for those categories can be casted to `PNSubscribeStatus` for use below.
            PNSubscribeStatus *subscribeStatus = (PNSubscribeStatus *)status;
            if (subscribeStatus.category == PNConnectedCategory) {
                [self.delegateconfig updatestatus:YES];
                NSLog(@"connected");
            
            }
            else {
                
                /**
                 This usually occurs if subscribe temporarily fails but reconnects. This means there was
                 an error but there is no longer any issue.
                 */
            }
        }
        else if (status.category == PNUnexpectedDisconnectCategory) {
            
            /**
             This is usually an issue with the internet connection, this is an error, handle
             appropriately retry will be called automatically.
             */
        }
        // Looks like some kind of issues happened while client tried to subscribe or disconnected from
        // network.
        else {
            
            PNErrorStatus *errorStatus = (PNErrorStatus *)status;
            if (errorStatus.category == PNAccessDeniedCategory) {
                
                /**
                 This means that PAM does allow this client to subscribe to this channel and channel group
                 configuration. This is another explicit error.
                 */
            }
            else {
                
                /**
                 More errors can be directly specified by creating explicit cases for other error categories
                 of `PNStatusCategory` such as: `PNDecryptionErrorCategory`,
                 `PNMalformedFilterExpressionCategory`, `PNMalformedResponseCategory`, `PNTimeoutCategory`
                 or `PNNetworkIssuesCategory`
                 */
            }
        }
    }
}
- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    
    if (![event.data.channel isEqualToString:event.data.subscription]) {
        
        // Presence event has been received on channel group stored in event.data.subscription.
    }
    else {
        
        // Presence event has been received on channel stored in event.data.channel.
    }
    
    if (![event.data.presenceEvent isEqualToString:@"state-change"]) {
        
        NSLog(@"%@ \"%@'ed\"\nat: %@ on %@ (Occupancy: %@)", event.data.presence.uuid,
              event.data.presenceEvent, event.data.presence.timetoken, event.data.channel,
              event.data.presence.occupancy);
        //        if ([event.data.presenceEvent isEqualToString:@"join"]) {
        //            if ([event.data.presence.uuid isEqualToString:@"54321"]) {
        //
        //
        //            }
        //                        [[Constantobject sharedInstance].onlinecontact addObject: event.data.presence.uuid];
        //            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationName" object:[Constantobject sharedInstance].onlinecontact];
        //        }
        //       else
        //        {
        //            if ([[Constantobject sharedInstance].onlinecontact containsObject:event.data.presence.uuid]) {
        //                [[Constantobject sharedInstance].onlinecontact removeObject:event.data.presence.uuid];
        //                  [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationName" object:[Constantobject sharedInstance].onlinecontact];
        //            }
        //        }
        //        
    }
    else {
        
        NSLog(@"%@ changed state at: %@ on %@ to: %@", event.data.presence.uuid,
              event.data.presence.timetoken, event.data.channel, event.data.presence.state);
    }
}
-(void)sendmessage:(NSDictionary*)message andtochannel:(NSString*)channelname callback:(void (^)(bool sent))callback
{

[self.client publish: message
           toChannel: channelname withCompletion:^(PNPublishStatus *publishStatus) {
               
               // Check whether request successfully completed or not.
               if (!publishStatus.isError) {
                  
                   callback(true);
                   
                   // Message successfully published to specified channel.
               }
               else {
                   callback(false);
                   /**
                    Handle message publish error. Check 'category' property to find out
                    possible reason because of which request did fail.
                    Review 'errorData' property (which has PNErrorData data type) of status
                    object to get additional information about issue.
                    
                    Request can be resent using: [publishStatus retry];
                    */
               }
           }];
}

//-(void)hearfromallchanel
//{
//    [self.client hereNowForChannel: @"1to1channel" withVerbosity:PNHereNowUUID
//                        completion:^(PNPresenceChannelHereNowResult *result,
//                                     PNErrorStatus *status) {
//                            
//                            // Check whether request successfully completed or not.
//                            if (!status) {
//                                NSLog(@"%@",result.data.uuids);
//                                
//                                /**
//                                 Handle downloaded presence information using:
//                                 result.data.uuids - list of uuids.
//                                 result.data.occupancy - total number of active subscribers.
//                                 */
//                            }
//                            else {
//                                
//                                /**
//                                 Handle presence audit error. Check 'category' property to find
//                                 out possible reason because of which request did fail.
//                                 Review 'errorData' property (which has PNErrorData data type) of status
//                                 object to get additional information about issue.
//                                 
//                                 Request can be resent using: [status retry];
//                                 */
//                            }
//                        }];
//}

-(void)hereAllChannels
{
    [self.client hereNowWithCompletion:^(PNPresenceGlobalHereNowResult *result, PNErrorStatus *status) {
        
        if (!status) {
            
            /**
             Handle downloaded presence information using:
             result.data.channels - dictionary with active channels and presence
             information on each. Each channel will have
             next fields: "uuids" - list of subscribers;
             "occupancy" - number of active subscribers.
             Each uuids entry has next fields:
             "uuid" - identifier and "state" if it has been
             provided.
             result.data.totalChannels - total number of active channels.
             result.data.totalOccupancy - total number of active subscribers.
             */
            NSDictionary *dd=result.data.channels;
            
            NSArray *channelarray=[dd allKeys];
            [self allmentorlist:channelarray];
           // callback(channelarray);
           // NSLog(@"%@",result.data.totalChannels);
        }
        else {
           // callback(nil);
            /**
             Handle presence audit error. Check 'category' property
             to find out possible reason because of which request did fail.
             Review 'errorData' property (which has PNErrorData data type) of status
             object to get additional information about issue.
             
             Request can be resent using: [status retry];
             */
        }
    }];
}
-(void)allmentorlist:(NSArray*)allonlinechannel
{
    if ([Constantobject sharedInstance].allMentorList.count) {
        NSMutableSet* set1 = [NSMutableSet setWithArray:[Constantobject sharedInstance].allMentorList];
        NSMutableSet* set2 = [NSMutableSet setWithArray:allonlinechannel];
        [set1 intersectSet:set2]; //this will give you only the obejcts that are in both sets
        
        NSArray* resultforonline = [set1 allObjects];
        
        [Constantobject sharedInstance].onlineMentorList=[self filteredarray:resultforonline];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Presencestatuschange" object:nil];
    }
    else
    {
    [[SYCRequestManager sharedInstance]Requestforlist:(nil) callback:^(NSArray *allchanels) {
    
        if (allchanels) {
            [Constantobject sharedInstance].allMentorList=[self filteredarray:allchanels];
            NSMutableSet* set1 = [NSMutableSet setWithArray:allchanels];
            NSMutableSet* set2 = [NSMutableSet setWithArray:allonlinechannel];
            [set1 intersectSet:set2]; //this will give you only the obejcts that are in both sets
            
            NSArray* resultforonline = [set1 allObjects];
           
            [Constantobject sharedInstance].onlineMentorList=[self filteredarray:resultforonline];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Presencestatuschange" object:nil];
           // NSLog(@"%@",result);//online user
        }
        
    }];
    }
}
-(NSArray*)filteredarray:(NSArray*)nonfilteredarray
{
    NSMutableArray *resultforonlinefiltered=[[NSMutableArray alloc]init];
    [resultforonlinefiltered addObjectsFromArray:nonfilteredarray];
    NSString *strlogged=[Constantobject sharedInstance].getloggedchannel;
    if ([resultforonlinefiltered containsObject:strlogged])
        [resultforonlinefiltered removeObject:strlogged];
    
    return resultforonlinefiltered;
}
-(void)unsubscribechannle:(NSString*)channelname
{
     [self.client unsubscribeFromChannels:@[channelname] withPresence:YES];
}
@end

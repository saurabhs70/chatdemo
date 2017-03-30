//
//  AllContactViewController.m
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AllContactViewController.h"

@interface AllContactViewController ()

@end

@implementation AllContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error) {
                NSLog(@"error fetching contacts %@", error);
            } else {
                for (CNContact *contact in cnContacts) {
                    // copy data to my custom Contacts class.
                    Contact *newContact = [[Contact alloc] init];
                    newContact.firstName = contact.givenName;
                    newContact.lastName = contact.familyName;
                    UIImage *image = [UIImage imageWithData:contact.imageData];
                    newContact.image = image;
                    NSMutableArray *arcontact=[[NSMutableArray alloc]init];
                    for (CNLabeledValue *label in contact.phoneNumbers) {
                        NSString *phone = [label.value stringValue];
                        if ([phone length] > 0) {
                            [arcontact addObject:phone];
                        }
                    }
                    newContact.phonenumbers=arcontact;
                    [[Constantobject sharedInstance].allcontact addObject:newContact];
                }
            }
            NSLog(@"%@#",[Constantobject sharedInstance].allcontact);
            arrcontact=[Constantobject sharedInstance].allcontact;
            dispatch_async(dispatch_get_main_queue(), ^{
                //update UI in main thread.
                    [_tblcontact reloadData];
            });
        
        }        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
   return  arrcontact.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellid"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    Contact *contactinfo=[arrcontact objectAtIndex:indexPath.row];
    for (NSString *ph in contactinfo.phonenumbers) {
        if ([[Constantobject sharedInstance].onlinecontact containsObject:ph]) {
            cell.textLabel.text =[NSString stringWithFormat:@"%@ %@---online",contactinfo.firstName,contactinfo.lastName];//

        }
        else
        cell.textLabel.text =[NSString stringWithFormat:@"%@ %@",contactinfo.firstName,contactinfo.lastName];//

    }
    
    
        
        return cell;
        
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [[Constantobject sharedInstance].client hereNowForChannel: @"groupchannel" withVerbosity:PNHereNowUUID
//                        completion:^(PNPresenceChannelHereNowResult *result,
//                                     PNErrorStatus *status) {
//    
//                            // Check whether request successfully completed or not.
//                            if (!status) {
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
    
    [[Constantobject sharedInstance].client hereNowForChannel: @"groupchannel" withVerbosity:PNHereNowUUID
                        completion:^(PNPresenceChannelHereNowResult *result,
                                     PNErrorStatus *status) {
                            
                            // Check whether request successfully completed or not.
                            if (!status) {
                                
                                /**
                                 Handle downloaded presence information using:
                                 result.data.uuids - list of uuids.
                                 result.data.occupancy - total number of active subscribers.
                                 */
                            }
                            else {
                                
                                /**
                                 Handle presence audit error. Check 'category' property to find
                                 out possible reason because of which request did fail.
                                 Review 'errorData' property (which has PNErrorData data type) of status
                                 object to get additional information about issue.
                                 
                                 Request can be resent using: [status retry];
                                 */
                            }
                        }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

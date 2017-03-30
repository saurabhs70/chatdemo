//
//  AllContactViewController.h
//  Chatapp
//
//  Created by umenit on 1/16/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AddressBook/AddressBook.h>
//#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import "Contact.h"
#import "Constantobject.h"
#import "ViewController.h"
@interface AllContactViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PNObjectEventListener>
{
    NSArray *arrcontact;
}
@property (weak, nonatomic) IBOutlet UITableView *tblcontact;

@end

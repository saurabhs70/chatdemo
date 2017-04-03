//
//  AppDelegate.h
//  Chatapp
//
//  Created by umenit on 1/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constantobject.h"
#import "SWRevealViewController.h"
#import "SYCMenuViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate,delegateforconnection>
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet  UINavigationController *frontNavigationController;


@end


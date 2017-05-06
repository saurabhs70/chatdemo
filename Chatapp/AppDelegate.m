//
//  AppDelegate.m
//  Chatapp
//
//  Created by umenit on 1/12/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[Constantobject sharedInstance]allocInit];
    [[SYCRequestManager sharedInstance]ResponseObjectMappingConfiguration];
  [[SYCDataManager sharedInstance]createDB];
    if ([[Constantobject sharedInstance]getlogged].length)
    [self setMenu:true];
else
    [self setMenu:false];
 //NSArray *arr=   [[SYCDataManager sharedInstance]searchmessagehistory:@"shyam@gmail.com" andmessagerecievedby:@"raju@gmail"];
    //int count=[[SYCDataManager sharedInstance]GetArticlesCount:@"shyam@gmail.com" andmessagerecievedby:@"raju@gmail"];
    NSLog(@"");
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    if ([[Constantobject sharedInstance] getloggedchannel].length)
    {
    [[ChatConfig sharedInstance]unsubscribechannle:[[Constantobject sharedInstance] getloggedchannel]];
        [[Constantobject sharedInstance].timer invalidate];
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     [self connectyoaskerchannel];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  [[ChatConfig sharedInstance]unsubscribechannle:[[Constantobject sharedInstance] getloggedchannel]];
}
-(void)setMenu:(BOOL)IsLoggedFlag
{
    
        
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window = window;
        
        // PremiumHomeViewController *frontViewController = [storyboard instantiateViewControllerWithIdentifier:@"PremiumHomeId"];
        UIViewController *frontViewController;
        if (IsLoggedFlag) {
            if ([[[Constantobject sharedInstance]getlogged] isEqualToString:SYCCHATMODEASKER]) {
                [self connectyoaskerchannel];
                OnlineuserViewController *frontViewControllerhome=(OnlineuserViewController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"OnlineuserViewControllerid"];
                frontViewController=frontViewControllerhome;
            }
            else
            {
                 [self connectyoaskerchannel];
            SYCAskerQusetionController *frontViewControllerhome=(SYCAskerQusetionController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCAskerQusetionControllerId"];
            frontViewController=frontViewControllerhome;
            }
            
        }
        else
        {
           ViewController *frontViewControllerlogged=(ViewController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"ViewControllerId"];
            frontViewController=frontViewControllerlogged;//SYCMenuViewControllerId
        }

        SYCMenuViewController *rearViewController=(SYCMenuViewController*)[[Constantobject sharedInstance]getviewcontrollerbyid:@"SYCMenuViewControllerId"];
        
 
        _frontNavigationController= [[UINavigationController alloc] initWithRootViewController:frontViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:_frontNavigationController];
        revealController.delegate = self;
        
        
    
        
        self.viewController = revealController;
        
        self.window.rootViewController = self.viewController;
    
        [self.window makeKeyAndVisible];
    
}
-(void)connectyoaskerchannel
{
    NSString *loggedaskerchannel=   [[Constantobject sharedInstance]getloggedchannel];
    if (loggedaskerchannel.length)
[[ChatConfig sharedInstance]initConfig:loggedaskerchannel andprotocol:self];
}
-(void)updatestatus:(BOOL)status
{
    [self refreshpresence];
}
-(void)hearchannle
{
     [[ChatConfig sharedInstance] hereAllChannels];
}
-(void)refreshpresence
{

   [Constantobject sharedInstance].timer= [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self
                                  selector: @selector(hearchannle) userInfo: nil repeats: YES];
}
@end

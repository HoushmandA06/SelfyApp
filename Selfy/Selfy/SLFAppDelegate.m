//
//  SLFAppDelegate.m
//  Selfy
//
//  Created by Ali Houshmand on 4/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//


#import "SLFAppDelegate.h"
#import "SLFTableViewController.h"
#import "SLFLoginVC.h"
#import "SLFNewSelfyVC.h"
#import <Parse/Parse.h>


@implementation SLFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // Jo's app key
//    [Parse setApplicationId:@"H1JHLiA7kFRmIWvtbkHDcnA1Caj4UofHxRx6UZAB"
//                  clientKey:@"dKLyXccYHUy1MXNgrdR2Sq5b1fNQoTr4clSXVd3p"];
    
    //my app key from Parse
    [Parse setApplicationId:@"Gqwcxe2TsYrgWuz4k0FYmC42Fan860UqDU7TQD6k"
                  clientKey:@"VSYAhicPhIwwWaQqaq1202RyhzMZHRObqmVOZWak"];

    
    [PFUser enableAutomaticUser];

    //Override point for customization after application launch.
    
    // self.window.rootViewController = [[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // self.window.rootViewController = [[SLFLoginVC alloc] initWithNibName:nil bundle:nil];
    
    // self.window.rootViewController = [[SLFNewSelfyVC alloc] initWithNibName:nil bundle:nil];
    
   //  UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:[[SLFLoginVC alloc]
      //                                                                                   initWithNibName:nil bundle:nil]];
    
    // use to work on new selfy
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:[[SLFNewSelfyVC alloc] initWithNibName:nil bundle:nil]];
    navController.navigationBarHidden = YES;
    
    PFUser * user = [PFUser currentUser];
   
    
    
    NSString * username = user.username;
    
     username = nil;
    
//     I am commenting the below because i dont want to go to the LOGINVC

//    if(username == nil)
//    {
//        navController = [[UINavigationController alloc] initWithRootViewController:[[SLFLoginVC alloc]
//                                                                                    initWithNibName:nil bundle:nil]];
//        navController.navigationBarHidden = YES;
//    } else {
//        navController = [[UINavigationController alloc] initWithRootViewController:[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
//    }
    
    self.window.rootViewController = navController;

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



@end

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

// "hello test"


@implementation SLFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse setApplicationId:@"H1JHLiA7kFRmIWvtbkHDcnA1Caj4UofHxRx6UZAB"
                  clientKey:@"dKLyXccYHUy1MXNgrdR2Sq5b1fNQoTr4clSXVd3p"];
    
    [PFUser enableAutomaticUser];

    //Override point for customization after application launch.
    
    // self.window.rootViewController = [[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // self.window.rootViewController = [[SLFLoginVC alloc] initWithNibName:nil bundle:nil];
    
       self.window.rootViewController = [[SLFNewSelfyVC alloc] initWithNibName:nil bundle:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



@end

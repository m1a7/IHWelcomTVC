//
//  AppDelegate.m
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "AppDelegate.h"

//ViewControllers
#import "IHWelcomeTVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    IHWelcomeTVC *welcomeTVC = [[IHWelcomeTVC alloc] initWithStyle: UITableViewStylePlain];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = welcomeTVC;
    [self.window makeKeyAndVisible];    
    return YES;
}

@end


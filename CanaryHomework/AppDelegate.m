//
//  AppDelegate.m
//  CanaryHomework
//
//  Created by Michael Schroeder on 9/19/19.
//  Copyright © 2019 Michael Schroeder. All rights reserved.
//

#import "AppDelegate.h"
#import "DevicesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DevicesViewController *vc  = [DevicesViewController new];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:vc];
    nVC.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    nVC.navigationBar.prefersLargeTitles = YES;
    nVC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor labelColor]};
    nVC.navigationBar.backgroundColor = [UIColor systemBackgroundColor];
    nVC.navigationBar.tintColor = [UIColor systemBlueColor];
    _window.rootViewController = nVC;
    [_window makeKeyAndVisible];
    return YES;
}

@end

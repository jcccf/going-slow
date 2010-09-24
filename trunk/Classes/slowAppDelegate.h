//
//  slowAppDelegate.h
//  slow
//
//  Created by Akshay Bapat on 9/24/10.
//  Copyright Cornell University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface slowAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

//
//  GoingSlowWindowBasedAppDelegate.h
//  GoingSlowWindowBased
//
//  Created by Gregory Thomas on 9/29/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
@class TabBarViewController;
@class View1Controller;
@class View2Controller;
@interface GoingSlowWindowBasedAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	FirstView *firstView;
	SecondView *secondView;
	ThirdView *thirdView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) UITabBarController *tabBarController;
@property (nonatomic, assign) FirstView *firstView;
@property (nonatomic, assign) SecondView *secondView;
@property (nonatomic, assign) ThirdView *thirdView;

@end


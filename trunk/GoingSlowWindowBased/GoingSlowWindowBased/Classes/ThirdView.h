//
//  ThirdView.h
//  GoingSlowWindowBased
//
//  Created by Gregory Thomas on 9/29/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoingSlowWindowBasedAppDelegate.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
@class GoingSlowWindowBasedAppDelegate;
@interface ThirdView : UIViewController {
	UIView *myView;
	UISlider *busySlider;
	UISegmentedControl *reflectButtons;
	UILabel *topLabel;
	UINavigationBar *navigationBar;
	UINavigationItem *navItem;
	UIBarButtonItem *saveButton;
	UITextView *textReflectionBox;
	UITextView *speakReflectionBox;
	UITextView *drawReflectionBox;
	GoingSlowWindowBasedAppDelegate *delegateRef;
}

@property (nonatomic,assign) UIView *myView;
@property (nonatomic,assign) UISlider *busySlider;
@property (nonatomic,assign) UISegmentedControl *reflectButtons;
@property (nonatomic,assign) UILabel *topLabel;
@property (nonatomic,assign) UIBarButtonItem *saveButton;
@property (nonatomic,assign) UINavigationBar *navigationBar;
@property (nonatomic, assign) UITextView *textReflectionBox;
@property (nonatomic,assign) UINavigationItem *navItem;
@property (nonatomic,assign) GoingSlowWindowBasedAppDelegate *delegateRef;
@property (nonatomic, assign) UITextView *speakReflectionBox;
@property (nonatomic, assign) UITextView *drawReflectionBox;

@end

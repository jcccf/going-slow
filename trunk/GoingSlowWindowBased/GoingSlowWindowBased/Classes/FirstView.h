//
//  FirstView.h
//  GoingSlowWindowBased
//
//  Created by Gregory Thomas on 9/29/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoingSlowWindowBasedAppDelegate.h"
#import "SecondView.h"
#import "ThirdView.h"
@class GoingSlowWindowBasedAppDelegate;
@interface FirstView : UIViewController {

	GoingSlowWindowBasedAppDelegate *delegateReference;
	UIButton *button;
	UIView *myView;
	UIImageView *landScapeView;
	UIImageView *cardView;
	NSMutableArray *cardImages;
	int displayIndex;
}

@property (nonatomic, assign) GoingSlowWindowBasedAppDelegate *delegateReference;
@property (nonatomic, assign) UIButton *button;
 @property (nonatomic, assign)    UIView                        *myView;
 @property (nonatomic, assign)    UIImageView                        *landScapeView;
@property (nonatomic, assign) UIImageView *cardView;
@end

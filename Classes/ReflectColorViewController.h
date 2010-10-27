//
//  ReflectColorViewController.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/26/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReflectColorViewController : UIViewController {

	UINavigationItem *navigationItem;
	UIBarButtonItem *saveButton;
}
@property (nonatomic,retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *saveButton;

@end

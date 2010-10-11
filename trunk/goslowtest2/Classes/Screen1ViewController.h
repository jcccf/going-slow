//
//  Screen1ViewController.h
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Screen1ViewController : UIViewController {
	UILabel *label;
	UIButton *button;
	//UIImageView *imageViewPicture;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
//@property (nonatomic, retain) IBOutlet UIImageView *imageViewPicture;

-(IBAction)sayHello:(id) sender;

@end

//
//  Screen1ViewController.h
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "goslowtest2AppDelegate.h"
#import "Suggestion.h"

@interface Screen1ViewController : UIViewController {
	UILabel *label;
	UIButton *button;
	UIImageView *imageViewPicture;
	
	UIImage *currentImage;
	UIImage *currentImageText;
	NSMutableArray *suggestionsArray;
	NSManagedObjectContext *managedObjectContext;
	int switchText;
	
	bool isNotFirstRun;
	
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewPicture;

@property (nonatomic, retain) NSMutableArray *suggestionsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) bool isNotFirstRun;

-(IBAction)sayHello:(id) sender;

@end

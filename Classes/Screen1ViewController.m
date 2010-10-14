//
//  Screen1ViewController.m
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Screen1ViewController.h"
#include <stdlib.h>

@implementation Screen1ViewController

@synthesize label;
@synthesize imageViewPicture;

@synthesize suggestionsArray;
@synthesize managedObjectContext;

@synthesize isNotFirstRun;

- (IBAction) sayHello:(id) sender {
	label.text = @"Hello World!";
}

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	assert(label != nil);
	label.text = @"Hello W-w-world!";
	UIImage *i = [UIImage imageNamed:@"breathe.png"];
	assert(i != nil);
	imageViewPicture.image = i;
	assert(imageViewPicture != nil);
	
	//
	// Core Data Code Below
	//
		
	// Based on http://developer.apple.com/library/ios/#documentation/DataManagement/Conceptual/iPhoneCoreData01/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008305-CH1-SW1
	// Read it before editing!
	
	// Get the Managed Object Context from the root delegate
	managedObjectContext = [(goslowtest2AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
	isNotFirstRun = [(goslowtest2AppDelegate*)[[UIApplication sharedApplication] delegate] isNotFirstRun];
	
	

	// TODO: Import All Suggestions, and only ONCE, since it keeps adding to the database now
	if (!isNotFirstRun) {
		// Create a New Suggestion Card
		Suggestion *newSuggestion = (Suggestion*)[NSEntityDescription insertNewObjectForEntityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
		[newSuggestion setTheme:@"Sleep"];
		[newSuggestion setPicturePath:@"cards/sleep.jpg"];
		NSError *error;
		if(![managedObjectContext save:&error])
			NSLog(@"Error on Saving New Suggestion");
		
	}
	
	// Fetch Suggestions From Data Store
	// TODO: Only fetch suggestions once a day
	// Create Request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	// Set Sort Descriptors
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"theme" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	//TODO: Get a Random Suggestion
	// Fetch Results
	NSError *error2;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error2] mutableCopy];
	assert(mutableFetchResults != nil);
	[self setSuggestionsArray:mutableFetchResults];
	
	int suggestionsArrayLength = [suggestionsArray count];
	int randomIndex = arc4random() % suggestionsArrayLength;
	
	// Read from Suggestions Array and Set View Items Appropriately
	Suggestion *suggestion = (Suggestion*)[suggestionsArray objectAtIndex:randomIndex];
	label.text = [suggestion theme];
	
	
	//TODO: where does sleep.png come from?
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
	
	for (Suggestion* s in suggestionsArray) {
		NSLog(@"Theme: %@", [s theme]);
		NSLog(@"Picture Path: %@", [s picturePath]);
		NSString *stringFromDate = [formatter stringFromDate:[s lastSeen]];
		NSLog(@"date: %@",  stringFromDate);
		
	}
	[formatter release];
	
	//TODO: save the suggestion back to Core Data
	//Set last seen to today's date
	[suggestion setLastSeen:[NSDate date]];
	
	UIImage *newImage = [UIImage imageNamed:[suggestion picturePath]];
	imageViewPicture.image = newImage;
	//TODO: Set Image Path and More Info, and update lastSeen
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.suggestionsArray = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[label release];
	[button release];
	[imageViewPicture release];
	[suggestionsArray release];
	[managedObjectContext release];
    [super dealloc];
}


@end

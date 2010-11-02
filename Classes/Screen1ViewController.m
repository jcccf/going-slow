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
@synthesize infoButton;

@synthesize suggestionsArray;

@synthesize isNotFirstRun;

- (IBAction) sayHello:(id) sender {
	if(switchText == 0){
		[UIView beginAnimations:@"flipping view" context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
							   forView:self.view cache:YES];
		imageViewPicture.hidden = true;
		backText.hidden = false;
		label.hidden = true;
		infoButton.hidden = true;
		switchText = 1;
		firstView.backgroundColor = [UIColor whiteColor];
		[UIView commitAnimations];
	}
	else {
		[UIView beginAnimations:@"flipping view" context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
							   forView:self.view cache:YES];
		backText.hidden = true;
		label.hidden = false;
		imageViewPicture.hidden = false;
		infoButton.hidden = false;
		switchText = 0;
		firstView.backgroundColor = [UIColor blackColor];
		[UIView commitAnimations];
	}
	

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
	
	switchText = 0;
	//backText.hidden = TRUE;
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
	
	isNotFirstRun = [(goslowtest2AppDelegate*)[[UIApplication sharedApplication] delegate] isNotFirstRun];

	// Import All Suggestions, and only ONCE
	if (!isNotFirstRun) {
		// Create a New Suggestion Card
		//system("mkdir ~/goslowImages");
		[[CoreDataManager getCoreDataManagerInstance] addAllSuggestions];
		[[CoreDataManager getCoreDataManagerInstance] addScreenIds];
		
	}
	
	// Read from Suggestions Array and Set View Items Appropriately
	Suggestion *suggestion = [[CoreDataManager getCoreDataManagerInstance] fetchSuggestion];
	label.text = [NSString stringWithFormat:@"%@%@", @" ", [suggestion theme]]; //HACK To space the text correctly on the screen
	
	NSString *html1 = @"<div style=\"font-family: Helvetica; font-size: larger; margin: 10px;\">";
	NSString *html2 = [suggestion moreInfo];
	NSString *html3 = @"</div>";
	NSString *html = [NSString stringWithFormat:@"%@ %@ %@",
					 html1, html2, html3];
	[backText loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]];  
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
	
	for (Suggestion* s in suggestionsArray) {
		NSLog(@"Theme: %@", [s theme]);
		NSLog(@"Picture Path: %@", [s picturePath]);
		NSString *stringFromDate = [formatter stringFromDate:[s lastSeen]];
		NSLog(@"date: %@",  stringFromDate);
	}	
	
	[formatter release];
	
	
	//Set current image to the suggestion selected
	currentImage = [UIImage imageNamed:[suggestion picturePath]];
	NSLog(@"Picture Path: %@", [suggestion picturePath]);
	//assert(newImage != nil);
	imageViewPicture.image = currentImage;
	//currentImage = newImage;
	[currentImage retain];
	
	//Set current text to the selected image text
	currentImageText = [UIImage imageNamed:[suggestion moreInfo]];
	[currentImageText retain];
	//[newImage release];
	
	//Set last seen to today's date
	[suggestion setLastSeen:[NSDate date]];
	
	[[CoreDataManager getCoreDataManagerInstance] saveChanges];
	
	//TEST
	NSMutableArray *textReflections = [[CoreDataManager getCoreDataManagerInstance] fetchReflections:@"TextReflection"];
	for (TextReflection *tr in textReflections) {
		NSLog(@"Text: %@", [tr reflectionText]);
	}
	
	NSMutableArray *colorReflections = [[CoreDataManager getCoreDataManagerInstance] fetchReflections:@"ColorReflection"];
	for (ColorReflection *cr in colorReflections) {
		NSLog(@"Red: %@", [cr colorRed]);
		NSLog(@"Green: %@", [cr colorGreen]);
		NSLog(@"Blue: %@", [cr colorBlue]);
		NSLog(@"Created At: %@", [cr createdAt]);
	}
	
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

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[[CoreDataManager getCoreDataManagerInstance] addLog:[NSNumber numberWithInt:1]];
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
    [super dealloc];
}


@end

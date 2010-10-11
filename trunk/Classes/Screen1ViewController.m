//
//  Screen1ViewController.m
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Screen1ViewController.h"


@implementation Screen1ViewController

@synthesize label;
@synthesize imageViewPicture;

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[label release];
	[button release];
	[imageViewPicture release];
    [super dealloc];
}


@end

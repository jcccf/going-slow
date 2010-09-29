//
//  FirstViewController.m
//  slow
//
//  Created by Akshay Bapat on 9/24/10.
//  Copyright Cornell University 2010. All rights reserved.
//

#import "FirstViewController.h"

#define hello 10

@implementation FirstViewController

@synthesize backGroundImage;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[backGroundImage setImage:[UIImage imageNamed:@"TestImage5150.png"]];
		[backGroundImage setFrame:CGRectMake(33, 33, 33, 33)];
		[self.view addSubview:backGroundImage];
    }
    return self;
}*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[backGroundImage dealloc];
    [super dealloc];
}

@end

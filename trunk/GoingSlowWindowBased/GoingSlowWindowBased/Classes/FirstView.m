    //
//  FirstView.m
//  GoingSlowWindowBased
//
//  Created by Gregory Thomas on 9/29/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "GoingSlowWindowBasedAppDelegate.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"

@implementation FirstView
@synthesize delegateReference;
@synthesize button;
@synthesize myView;
@synthesize cardView;
-(id)init{
	myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	myView.autoresizesSubviews = YES;
	myView.backgroundColor = [UIColor cyanColor];
	self.view = myView;
	displayIndex = 0;
	UIImage *image0 = [UIImage imageNamed:@"breathe.png"];
	UIImage *image1 = [UIImage imageNamed:@"TestImage5150.png"];	
	[self setTitle:@"Home"];
	cardImages = [[NSArray alloc] initWithObjects:image0,image1,nil];
	
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake(0, 0, 320, 480);
	button.alpha = 0.02;
	button.hidden = NO;
	[button addTarget:self action:@selector(changePic:) forControlEvents:UIControlEventTouchUpInside];
	
	cardView = [[UIImageView alloc] init];
	cardView.image = [cardImages objectAtIndex:displayIndex];
	cardView.frame = CGRectMake(0, 0, 320, 480);
	
	[self.view addSubview:cardView];
	
	
	[self.view addSubview:button];
	return self;
}

-(void)changePic:(id)sender
{
	if(displayIndex == 0)
		displayIndex++;
	else {
		displayIndex = 0;
	}

	//[self setTitle:@"CLICKED BUTTON"];
	[cardView setImage:[cardImages objectAtIndex:displayIndex]];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

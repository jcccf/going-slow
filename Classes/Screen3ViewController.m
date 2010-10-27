//
//  Screen3ViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "Screen3ViewController.h"


@implementation Screen3ViewController

@synthesize reflectCameraViewController, reflectTextViewController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		reflectView = [[UIView alloc] init];
		[reflectView retain];
    }
    return self;
}*/



-(IBAction)goToCamera:(id)sender{
	if(reflectCameraViewController == nil){
	reflectCameraViewController = [[UIImagePickerController alloc] init];
	reflectCameraViewController.sourceType = UIImagePickerControllerCameraDeviceRear;
	reflectCameraViewController.allowsEditing = YES;
	reflectCameraViewController.delegate = self;
	reflectTextViewController.title = @"Reflection Pictures";

	}
	[[self navigationController] presentModalViewController:reflectCameraViewController animated:YES];
	
	}

-(IBAction)goToText:(id)sender{
	if(reflectTextViewController == nil){
		reflectTextViewController = [[ReflectTextViewController alloc] initWithNibName:@"ReflectTextViewController" bundle:nil];
		
	}
	[[self navigationController] pushViewController:reflectTextViewController animated:YES];
}

-(IBAction)goToColor:(id)sender{
	if(reflectColorViewController == nil){
		reflectColorViewController = [[ReflectColorViewController alloc] initWithNibName:@"ReflectColorViewController" bundle:nil];
	}
	[[self navigationController] pushViewController:reflectColorViewController animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)storeReflection:(Reflection *)r{
	
}

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

//
//  Screen3ViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "Screen3ViewController.h"


@implementation Screen3ViewController

@synthesize reflectView, textButton, cameraButton, colorButton, saveButton, backButton, colorView, textView, cameraView;

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





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	textView.hidden = YES;
	textView.delegate = self;
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)changeColor:(id)sender{
	
}
- (BOOL)textView:(UITextView *)textV shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textV resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(IBAction)goToText:(id)sender{
	
	textView.hidden = NO;
}
-(IBAction)goToCamera:(id)sender{
	
}
-(IBAction)goToColor:(id)sender{
	
}

-(IBAction)goBack:(id)sender{
	textView.hidden = YES;
	[textView resignFirstResponder];
}
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

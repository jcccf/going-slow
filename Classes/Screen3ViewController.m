//
//  Screen3ViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "Screen3ViewController.h"


@implementation Screen3ViewController

@synthesize colorBox, textButton, cameraButton, colorButton, saveButton, backButton, colorView, textView, cameraView,red,blue,green,redSlider,blueSlider,greenSlider;

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

	red.hidden = YES;
	blue.hidden = YES;
	green.hidden = YES;
	redSlider.hidden = YES;
	greenSlider.hidden = YES;
	blueSlider.hidden = YES;
	colorBox.hidden = YES;
	
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
	CGFloat r = redSlider.value;
	CGFloat g = greenSlider.value;
	CGFloat b = blueSlider.value;
	colorBox.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
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
	cameraButton.hidden= YES;
	colorButton.hidden = YES;
	textButton.hidden = YES;
}
-(IBAction)goToCamera:(id)sender{
	
}
-(IBAction)goToColor:(id)sender{
	cameraButton.hidden= YES;
	colorButton.hidden = YES;
	textButton.hidden = YES;
	colorBox.hidden = NO;
	red.hidden = NO;
	blue.hidden= NO;
	green.hidden = NO;
	redSlider.hidden = NO;
	greenSlider.hidden = NO;
	blueSlider.hidden = NO;
	
}

-(IBAction)goBack:(id)sender{
	textView.hidden = YES;
	red.hidden = YES;
	blue.hidden= YES;
	green.hidden = YES;
	colorBox.hidden = YES;
	redSlider.hidden = YES;
	greenSlider.hidden = YES;
	blueSlider.hidden = YES;
	cameraButton.hidden= NO;
	colorButton.hidden = NO;
	textButton.hidden = NO;
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

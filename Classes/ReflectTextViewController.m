//
//  ReflectTextViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/26/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "ReflectTextViewController.h"


@implementation ReflectTextViewController
@synthesize navigationItem, saveButton, tView, coreDataManager;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		coreDataManager = [[CoreDataManager alloc] init];
    }
    return self;
}

-(IBAction)saveText{
		
	NSString *text = tView.text;
	[coreDataManager addTextReflection:text];
		
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

    [super viewDidLoad];
	self.navigationItem.title = @"Add Text";
	self.navigationItem.leftBarButtonItem.title = @"Back";
	tView.delegate = self;
	[tView becomeFirstResponder];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
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
	[coreDataManager release];
    [super dealloc];
}


@end

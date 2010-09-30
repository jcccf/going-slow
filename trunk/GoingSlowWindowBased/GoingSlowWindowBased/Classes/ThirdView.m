    //
//  ThirdView.m
//  GoingSlowWindowBased
//
//  Created by Gregory Thomas on 9/29/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "GoingSlowWindowBasedAppDelegate.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"


@implementation ThirdView
@synthesize myView;
@synthesize busySlider;
@synthesize reflectButtons;
@synthesize topLabel;
@synthesize navigationBar;
@synthesize textReflectionBox;
@synthesize speakReflectionBox;
@synthesize drawReflectionBox;
@synthesize delegateRef;
@synthesize navItem;
@synthesize saveButton;
-(id)init{
	
	myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	myView.autoresizesSubviews = YES;
	self.view = myView;
	[self setTitle:@"Reflect"];
	
	busySlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 80, 280, 40)];
	
	
	textReflectionBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 160, 300, 230)];
	textReflectionBox.backgroundColor = [UIColor yellowColor];
	[textReflectionBox setReturnKeyType:UIReturnKeyDone];
	textReflectionBox.delegate = self;
	speakReflectionBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 160, 300, 230)];
	speakReflectionBox.backgroundColor = [UIColor blueColor];
	speakReflectionBox.hidden = YES;
	speakReflectionBox.delegate = self;
	[speakReflectionBox setReturnKeyType:UIReturnKeyDone];
	drawReflectionBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 160, 300, 230)];
	drawReflectionBox.backgroundColor = [UIColor redColor];
	[drawReflectionBox setReturnKeyType:UIReturnKeyDone];
	drawReflectionBox.hidden = YES;
	drawReflectionBox.delegate = self;
	
	
	
	NSString *write = @"Write";
	NSString *speak = @"Speak";
	NSString *draw = @"Draw";
	NSArray *reflectOptions = [[NSArray alloc] initWithObjects:write,speak,draw,nil];
	reflectButtons = [[UISegmentedControl alloc] initWithItems:reflectOptions];
	reflectButtons.frame = CGRectMake(10, 120, 300, 40);

	
	[reflectButtons addTarget:self
	 
					   action:@selector(changeView:)
	 
			   forControlEvents:UIControlEventValueChanged];
	
	
	topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 50)];
	topLabel.text = @"How busy have you been?";
	topLabel.textAlignment = UITextAlignmentLeft;
	topLabel.backgroundColor = [UIColor clearColor];
	topLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
	topLabel.textColor = [UIColor blackColor];
	
	saveButton = [[UIBarButtonItem alloc] initWithTitle:@"   Save   "  style:UIBarButtonItemStyleBordered target:nil action:nil];
	
	navItem = [[UINavigationItem alloc] initWithTitle:@"Reflect"];
	[navItem setRightBarButtonItem:saveButton];
	NSArray *navItems = [[NSArray alloc] initWithObjects:navItem,nil];
	
	
	navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
	 navigationBar.delegate = delegateRef;
	[navigationBar setItems:navItems];
	
	
	[self.view addSubview:textReflectionBox];
	[self.view addSubview:speakReflectionBox];
	[self.view addSubview:drawReflectionBox];
	[self.view addSubview:topLabel];
	[self.view addSubview:reflectButtons];
	[self.view addSubview:busySlider];
	[self.view addSubview:navigationBar];
	return self;
}

-(void)changeView:(id)sender{
	if(reflectButtons.selectedSegmentIndex == 0){
		textReflectionBox.hidden = NO;
		speakReflectionBox.hidden = YES;
		drawReflectionBox.hidden = YES;
	}
		
	if(reflectButtons.selectedSegmentIndex == 1){
		textReflectionBox.hidden = YES;
		speakReflectionBox.hidden = NO;
		drawReflectionBox.hidden = YES;
	}
		
	if(reflectButtons.selectedSegmentIndex == 2){
		textReflectionBox.hidden = YES;
		speakReflectionBox.hidden = YES;
		drawReflectionBox.hidden = NO;
	}
	
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
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

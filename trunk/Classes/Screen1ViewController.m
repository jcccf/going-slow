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
	if(switchText == 0){
		imageViewPicture.hidden = true;
		backText.hidden = false;
		label.hidden = true;
		switchText = 1;
		firstView.backgroundColor = [UIColor whiteColor];
		
		
	}
	else {
		backText.hidden = true;
		label.hidden = false;
		imageViewPicture.hidden = false;
		switchText = 0;
		firstView.backgroundColor = [UIColor blackColor];
	}
	

}


//Deletes all objects in the sqllite database
- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
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

-(void)addAllSuggestions{
	[self deleteAllObjects:@"Suggestion"];
	
	NSString *textPaths = @"back deep breathe.jpg,back of Choose Consciously.jpg,backof Connect with Nature.jpg,backof connect with others.jpg,backof Control worry.jpg,backof Eat Well.jpg,backof Exercise.jpg,backof Express Gratitude.jpg,backof Get more sleep.jpg,backof Grow from mistakes.jpg,backof Laughter.jpg,backof Music.jpg,backof Meditation.jpg,backof Play.jpg,backof Powernap.jpg,backof reflect.jpg,backof Relax your Body.jpg,backof Think Positively.jpg,backof Thoughts matter.jpg,backof Use Resources.jpg,backof Visualization.jpg";
	NSArray *textPicturePaths = [textPaths componentsSeparatedByString:@","];
	
	NSString *picturePathsString = @"breathe.jpg,choose_consciously.jpg,connect_with_nature.jpg,connect_with_others.jpg,control_worry.jpg,eat_well.jpg,exercise.jpg,express_gratitude.jpg,get_more_sleep.jpg,grow_from_mistakes.jpg,laugh.jpg,listen_to_music.jpg,meditate.jpg,play.jpg,power_nap.jpg,reflect.jpg,relax_your_body.jpg,think_positively.jpg,thoughts_matter.jpg,use_resources.jpg,visualize.jpg";

	NSArray *picturePaths = [picturePathsString componentsSeparatedByString:@","];
	
	NSString *themeString = @"Breathe,Choose Consciously,Connect With Nature,Connect With Others,Control Worry,Eat Well,Exercise,Express Gratitude,Get More Sleep,Grow From Mistakes,Laugh,Listen To Music,Meditate,Play,Power Nap,Reflect,Relax Your Body,Think Positively,Thoughts Matter,Use Resources,Visualize";

	NSArray *themes = [themeString componentsSeparatedByString:@","];	
	int arrayCount = [picturePaths count];
	
	for(int i = 0; i < arrayCount; i++){
		Suggestion *newSuggestion = (Suggestion*)[NSEntityDescription insertNewObjectForEntityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
		NSString* theme = [themes objectAtIndex:i];
		NSString* picturePath = [picturePaths objectAtIndex:i];
		NSString* infoPath = [textPicturePaths objectAtIndex:i];
		[newSuggestion setTheme:theme];
		[newSuggestion setPicturePath:picturePath];
		[newSuggestion setMoreInfo:infoPath];
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	switchText = 0;
	backText.hidden = TRUE;
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

	//[self deleteAllObjects:@"Suggestion"];
	// TODO: Import All Suggestions, and only ONCE, since it keeps adding to the database now
	if (!isNotFirstRun) {
		// Create a New Suggestion Card
		[self addAllSuggestions];
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
	
	int fetchResultsLength = [mutableFetchResults count];
	int suggestionsArrayLength = [suggestionsArray count];
	int randomIndex = arc4random() % suggestionsArrayLength;
	
	// Read from Suggestions Array and Set View Items Appropriately
	Suggestion *suggestion = (Suggestion*)[suggestionsArray objectAtIndex:randomIndex];
	label.text = [suggestion theme];
	backText.text = [suggestion moreInfo];
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
	
	//TODO: Set Image Path and More Info, and update lastSeen

	currentImage = [UIImage imageNamed:[suggestion picturePath]];
	NSLog([suggestion picturePath]);
	//assert(newImage != nil);
	imageViewPicture.image = currentImage;
	//currentImage = newImage;
	[currentImage retain];
	
	
	//Add logic that gets the current image text 
	//[pathTextByTheme ad
	
	
	currentImageText = [UIImage imageNamed:[suggestion moreInfo]];
	[currentImageText retain];
	//[newImage release];
	
	//TODO: save the suggestion back to Core Data
	//Set last seen to today's date
	
	NSError *saveError;
	[suggestion setLastSeen:[NSDate date]];
	if (![managedObjectContext save:&saveError]) {
		NSLog(@"Saving changes to current suggestion failed: %@", saveError);
	} else {
		// The changes to suggestion have been persisted.
	}
	
	[NSError release];
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

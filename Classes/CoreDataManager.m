//
//  CoreDataManager.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "CoreDataManager.h"


@implementation CoreDataManager

@synthesize appDelegateReference;
@synthesize managedObjectContext;

static CoreDataManager *sharedInstance = nil;

- (id) init {
    if ( self = [super init] ) {
		// Get the Managed Object Context from the root delegate
		managedObjectContext = [(goslowtest2AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    return self;
}

+(CoreDataManager *)getCoreDataManagerInstance{
	
	@synchronized(self) {
        if (sharedInstance == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedInstance;
}

-(void)addReflection:(Reflection *)r{
	
}

-(void)addSuggestion:(NSString *)theme picturePath:(NSString *)picturePath infoPath:(NSString *)infoPath{
	Suggestion *newSuggestion = (Suggestion*)[NSEntityDescription insertNewObjectForEntityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
	[newSuggestion setTheme:theme];
	[newSuggestion setPicturePath:picturePath];
	[newSuggestion setMoreInfo:infoPath];
	
	[self saveChanges];
	
}


//Irrelevant; just make changes to the original suggestion and use saveChanges to update it to Core Data
-(void)updateSuggestion:(NSDate *)date :(int)index{
	
}

//TODO: change this to date difference
-(bool)compareDate {

	NSString *date = @"2009-05-11";
	NSString *nowDate = [[[NSDate date]description]substringToIndex: 10];
	
	// same day
	if([date isEqualToString: nowDate]) {
		// your code
		return YES;
	}
	else {
		return NO;
	}
}
// record that user fetched the date in the method
// look to NSPredicate for SQL-like queries
-(Suggestion*) fetchSuggestion {
	
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
	
	// Fetch Results
	NSError *error2;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error2] mutableCopy];
	assert(mutableFetchResults != nil);
	
	int suggestionsArrayLength = [mutableFetchResults count];
	//Get a Random Suggestion
	int randomIndex = arc4random() % suggestionsArrayLength;
	Suggestion *suggestion = (Suggestion*)[mutableFetchResults objectAtIndex:randomIndex];
	
	//Set last seen to today's date
	[suggestion setLastSeen:[NSDate date]];
	
	NSLog(@"Date: %@", [suggestion lastSeen]);
	
	[self saveChanges];
	
	return suggestion;
	
}


-(void)saveChanges {
	//Save to Core Data
	NSError *saveError;
	if (![managedObjectContext save:&saveError]) {
		NSLog(@"Saving changes failed: %@", saveError);
	} else {
		// The changes to suggestion have been persisted.
		NSLog(@"Changes have been saved.");
	}
	
	[NSError release];
	
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

- (void) dealloc {
    [super dealloc];
}

@end

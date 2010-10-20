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

-(void)addSuggestion:(Suggestion *)s{
	
}

//Irrelevant; just make changes to the original suggestion and use saveChanges to update it to Core Data
-(void)updateSuggestion:(NSDate *)date :(int)index{
	
}


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
	//TODO: Get a Random Suggestion
	// Fetch Results
	NSError *error2;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error2] mutableCopy];
	assert(mutableFetchResults != nil);
	
	int suggestionsArrayLength = [mutableFetchResults count];
	int randomIndex = arc4random() % suggestionsArrayLength;
	
	// Read from Suggestions Array and Set View Items Appropriately
	Suggestion *suggestion = (Suggestion*)[mutableFetchResults objectAtIndex:randomIndex];
	
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

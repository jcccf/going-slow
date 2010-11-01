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

-(void)addColorReflection:(NSArray *)colors{
	ColorReflection *newReflection = (ColorReflection*)[NSEntityDescription insertNewObjectForEntityForName:@"ColorReflection" inManagedObjectContext:managedObjectContext];
	
	NSNumber *red = [colors objectAtIndex:(NSUInteger)0];
	NSNumber *green = [colors objectAtIndex:(NSUInteger)1];
	NSNumber *blue = [colors objectAtIndex:(NSUInteger)2];
	
	[newReflection setColorRed:red];
	[newReflection setColorGreen:green];
	[newReflection setColorBlue:blue];
	[newReflection setCreatedAt:[NSDate date]];
	
	[self saveChanges];	
	
	NSLog(@"Red: %@", [newReflection colorRed]);
	NSLog(@"Green: %@", [newReflection colorGreen]);
	NSLog(@"Blue: %@", [newReflection colorBlue]);
	NSLog(@"Created At: %@", [newReflection createdAt]);
	
}

-(void)addPhotoReflection:(NSString *)filepath{
	PhotoReflection *newReflection = (PhotoReflection*)[NSEntityDescription insertNewObjectForEntityForName:@"PhotoReflection" inManagedObjectContext:managedObjectContext];
	
	[newReflection setFilepath:filepath];
	[newReflection setCreatedAt:[NSDate date]];
	
	[self saveChanges];	
	
	//NSLog(@"Filepath to file: %@", [newReflection filepath]);
	
}

-(void)addTextReflection:(NSString *)reflectionText{
	TextReflection *newReflection = (TextReflection*)[NSEntityDescription insertNewObjectForEntityForName:@"TextReflection" inManagedObjectContext:managedObjectContext];
	
	[newReflection setReflectionText:reflectionText];
	[newReflection setCreatedAt:[NSDate date]];
	
	[self saveChanges];	
	
	NSLog(@"Reflection text: %@", [newReflection reflectionText]);
	
}


-(void)addSuggestion:(NSString *)theme picturePath:(NSString *)picturePath infoPath:(NSString *)infoPath{
	Suggestion *newSuggestion = (Suggestion*)[NSEntityDescription insertNewObjectForEntityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
	[newSuggestion setTheme:theme];
	[newSuggestion setPicturePath:picturePath];
	[newSuggestion setMoreInfo:infoPath];
	
	[self saveChanges];
	
}

//TODO: change this to date difference
-(bool)isToday:(NSDate*)refDate {

	NSString *date = [[refDate description]substringToIndex: 10];
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
	// Create Request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Suggestion" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Set Sort Descriptors
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastSeen" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	// Fetch Results
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	assert(mutableFetchResults != nil);
	
//	NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
//	id element;
//	
//	while(element = [enumerator nextObject]) {
//		Suggestion *suggestion = (Suggestion*) element;
//		// Do your thing with the object.
//		NSLog(@"Date: %@", [suggestion lastSeen]);
//    }
	
	Suggestion *suggestion = (Suggestion*)[mutableFetchResults objectAtIndex:0];
	NSDate *latestDate = [suggestion lastSeen];
	
	//Get a Random Suggestion if it's a new day
	if(![self isToday:latestDate]) {
		
		NSCalendar *calendar = [NSCalendar currentCalendar];
		NSDateComponents *offset = [[NSDateComponents alloc] init];
		[offset setDay:-14];
		// Return the date that was 14 days ago
		NSDate *cutoffDate = [calendar dateByAddingComponents:offset toDate:[NSDate date] options:0];
		
		[offset release];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastSeen <= %@) || (lastSeen == nil)", cutoffDate];
		[request setPredicate:predicate];
		
		// Fetch Results
		NSError *error;
//		[mutableFetchResults release];
		mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
		assert(mutableFetchResults != nil);
		
		int suggestionsArrayLength = [mutableFetchResults count];
		//Get a Random Suggestion
		int randomIndex = arc4random() % suggestionsArrayLength;
		
		suggestion = (Suggestion*)[mutableFetchResults objectAtIndex:randomIndex];		
		
	}
	
	//Set last seen to today's date
	[suggestion setLastSeen:[NSDate date]];
	
	NSLog(@"Date: %@", [suggestion lastSeen]);
	
	[self saveChanges];
	[request release];
	
	return suggestion;
	
}


-(NSMutableArray*) fetchReflections:(NSString*) reflectionType {
	
	// Fetch Suggestions From Data Store
	// Create Request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:reflectionType inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Set Sort Descriptors
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	// Fetch Results
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	assert(mutableFetchResults != nil);
	
	//	NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
	//	id element;
	//	
	//	while(element = [enumerator nextObject]) {
	//		Suggestion *suggestion = (Suggestion*) element;
	//		// Do your thing with the object.
	//		NSLog(@"Date: %@", [suggestion lastSeen]);
	//    }

	
	[request release];
	
	return mutableFetchResults;
	
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

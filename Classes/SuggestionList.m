//
//  SuggestionList.m
//  goslowtest2
//
//  Created by Kevin Tse on 11/11/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "SuggestionList.h"

@implementation SuggestionList
@synthesize suggestions;

static SuggestionList *sharedInstance = nil;

- (id) init {
    if ( self = [super init] ) {
	}
    return self;
}

+(SuggestionList *)getInstance{
	
	@synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[SuggestionList alloc] init]; // assignment not done here
			NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
			
			for (int i = 0; i < 21; i++) {
				[list addObject:[[CoreDataManager getCoreDataManagerInstance] fetchSuggestion]];
			}
			
			[sharedInstance setSuggestions:list];
        }
    }
    return sharedInstance;
}

-(NSMutableArray*) returnArray {
	return suggestions;
}

-(Suggestion*) fetchSuggestion {
	Suggestion *suggestion = (Suggestion*)[suggestions objectAtIndex:0];
	NSDate *latestDate = [suggestion lastSeen];
	int daysElapsed = [[CoreDataManager getCoreDataManagerInstance] daysElapsed:latestDate];
	
	//Remove the first object in the list and reset the pointer to the next object
	for (int i = 0; i < daysElapsed; i++) {
		if ([suggestions count] > 2) {
			[suggestions removeObjectAtIndex:0];
		}
		else {
			for (int j = 0; j < 21; j++) {
				[suggestions addObject:[[CoreDataManager getCoreDataManagerInstance] fetchSuggestion]];
				//TODO: reschedule notifications
			}
			//End the outside for loop
			i = daysElapsed;
		}

	}
	
	suggestion = (Suggestion*)[suggestions objectAtIndex:0];
	
	return suggestion;
	
}

- (void) dealloc {
    [super dealloc];
}

@end


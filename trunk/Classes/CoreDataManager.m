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

-(void)updateSuggestion:(NSDate *)date :(int)index{
	
}

@end

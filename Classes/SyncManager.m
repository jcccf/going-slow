//
//  SyncManager.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "SyncManager.h"


@implementation SyncManager

static SyncManager *sharedInstance = nil;

@synthesize bufferedReflections;

+(SyncManager*)getSyncManagerInstance{
	@synchronized(self){
		if(sharedInstance == nil){
			[[self alloc] init];
		}
	}
	return sharedInstance;
}

-(void)bufferReflection:(Reflection*) r{
	
}

-(void)syncData{
	
}
@end

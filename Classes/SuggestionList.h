//
//  SuggestionList.h
//  goslowtest2
//
//  Created by Kevin Tse on 11/11/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "Suggestion.h"
#import "goslowtest2AppDelegate.h"
#import "SyncManager.h"

@interface SuggestionList: NSObject {
	NSMutableArray* suggestions;
	NSDate *morningDate;
	NSDate *eveningDate;
}

@property (nonatomic, retain) NSArray *suggestions;
@property (nonatomic,assign) NSDate *morningDate;
@property (nonatomic,assign) NSDate *eveningDate;

+(SuggestionList *)getInstance;
-(NSMutableArray*) returnArray;
-(Suggestion*) fetchSuggestion;
-(void) scheduleNotifications;
-(void) setDate:(NSDate*)morning eveningDate:(NSDate*)evening;
@end
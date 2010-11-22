//
//  SuggestionList.m
//  goslowtest2
//
//  Created by Kevin Tse on 11/11/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "SuggestionList.h"

@implementation SuggestionList
@synthesize suggestions, morningDate, eveningDate;

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
//			NSMutableArray *list = [NSMutableArray arrayWithCapacity:10];
//			
//			for (int i = 0; i < 21; i++) {
//				[list addObject:[[CoreDataManager getCoreDataManagerInstance] fetchSuggestion]];
//			}
//			
//			[sharedInstance setSuggestions:list];
			[sharedInstance setSuggestions:[[CoreDataManager getCoreDataManagerInstance]fetchInitialSuggestions]];
        }
    }
    return sharedInstance;
}

-(NSMutableArray*) returnArray {
	return suggestions;
}

-(void) setDate:(NSDate*)morning eveningDate:(NSDate*)evening {
	
	[sharedInstance setMorningDate: morning];
	[sharedInstance setEveningDate: evening];
}

-(Suggestion*) fetchSuggestion {
	
//	for (Suggestion* s in suggestions) {
//		NSLog(@"Theme: %@", [s theme]);
//		NSLog(@"Picture Path: %@", [s picturePath]);
//		NSLog(@"date: %@",  [s lastSeen]);
//	}	
	
	
	Suggestion *suggestion = (Suggestion*)[suggestions objectAtIndex:0];
	NSDate *latestDate = [suggestion lastSeen];
	int daysElapsed = [[CoreDataManager getCoreDataManagerInstance] daysElapsed:latestDate];
	
	int lowSuggestionThreshold = 2;
	
	//Remove the first object in the list and reset the pointer to the next object
	for (int i = 0; i < daysElapsed; i++) {
		if ([suggestions count] > lowSuggestionThreshold) {
			[suggestions removeObjectAtIndex:0];
		}
		else {
			//End the outside for loop
			i = daysElapsed;
		}

	}
	
	if ([suggestions count] <= lowSuggestionThreshold) {
		
		NSMutableArray *newSuggestions = [[CoreDataManager getCoreDataManagerInstance]fetchNextSuggestions];
		for (Suggestion *s in suggestions) {
			[newSuggestions removeObject:s];
		}
		
		[suggestions addObjectsFromArray:newSuggestions];
		
		//Reschedule notifications
		[self scheduleNotifications];
		
	}
	
	//Reset pointer to new suggestion after adjusting the array
	suggestion = (Suggestion*)[suggestions objectAtIndex:0];
	
	if (daysElapsed > 0) {
		NSArray *sugarRay = [NSArray arrayWithObjects:[suggestion theme], [NSDate date], nil];
		
		[[[SyncManager getSyncManagerInstance] bufferedReflections] addObject:sugarRay];
		
		[[SyncManager getSyncManagerInstance] syncData];	
		
	}
	
	
	return suggestion;
	
}

-(void) scheduleSuggestions {
	
	
}

-(void) scheduleNotifications {
	//[self.view removeFromSuperview];
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	for (int i = 0; i < [suggestions count]; i++) {
		
		NSDateComponents *offset = [[NSDateComponents alloc] init];
		[offset setDay:i];
		//[offset setMinute:i];
		NSDate *notificationDate = [calendar dateByAddingComponents:offset toDate:morningDate options:0];
		//NSDate *notificationDate = [calendar dateByAddingComponents:offset toDate:[NSDate date] options:0];
		
		[offset release];
		
		Suggestion *suggestion = [suggestions objectAtIndex:i]; 
		
		UILocalNotification *localNotifMorning = [[UILocalNotification alloc] init];
		if (localNotifMorning == nil)
			return;
		
		localNotifMorning.fireDate = notificationDate;
		localNotifMorning.timeZone = [NSTimeZone defaultTimeZone];
		//localNotifMorning.repeatInterval = NSMinuteCalendarUnit;
		
		localNotifMorning.alertBody = [NSString stringWithFormat:@"Today's Suggestion: %@", [suggestion theme]];
		localNotifMorning.alertAction = @"See More";
	
		// Schedule ONLY for notifications happening in the future
		// Notifications scheduled for the past fire immediately
		if ([[localNotifMorning fireDate] timeIntervalSinceNow] > 0) {
			NSLog(@"Scheduling %@", [suggestion theme]);
			[[UIApplication sharedApplication] scheduleLocalNotification:localNotifMorning];
		}
		
		[localNotifMorning release];
		
		
	}
	
	//UILocalNotification *localNotifMorning = [[UILocalNotification alloc] init];
	UILocalNotification *localNotifEvening = [[UILocalNotification alloc] init];
	//    if (localNotifMorning == nil)
	//        return;
	if (localNotifEvening == nil)
        return;
	
	localNotifEvening.fireDate = eveningDate;
	//localNotifMorning.fireDate = morningDate;
	
	localNotifEvening.timeZone = [NSTimeZone defaultTimeZone];
	//localNotifMorning.timeZone = [NSTimeZone defaultTimeZone];
	
	localNotifEvening.repeatInterval = NSDayCalendarUnit;
	//	localNotifMorning.repeatInterval = NSDayCalendarUnit;
	
	//	localNotifMorning.alertBody = @"Would you like a suggestion?";
	//	localNotifMorning.alertAction = @"See More";
	localNotifEvening.alertBody = @"How was your day?";
	localNotifEvening.alertAction = @"Reflect";
	NSString *key = [NSString stringWithString:@"Type"];
	NSString *val = [NSString stringWithString:@"Reflect"];
	localNotifEvening.userInfo = [NSDictionary dictionaryWithObject:val forKey:key];
	
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotifEvening];
	//[[UIApplication sharedApplication] scheduleLocalNotification:localNotifMorning];
	
	[localNotifEvening release];
	//[localNotifMorning release];
	
	/*localNotif.fireDate = [itemDate dateByAddingTimeInterval:1];
	 
	 //1 day repeat interval
	 localNotif.repeatInterval = NSDayCalendarUnit;
	 // localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
	 localNotif.timeZone = [NSTimeZone defaultTimeZone];
	 
	 // Notification details
	 localNotif.alertBody = @"You should reflect";
	 // Set the action button
	 localNotif.alertAction = @"Reflect";
	 
	 localNotif.soundName = UILocalNotificationDefaultSoundName;
	 localNotif.applicationIconBadgeNumber = 1;
	 
	 // Specify custom data for the notification
	 NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
	 localNotif.userInfo = infoDict;
	 
	 // Schedule the notification
	 [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
	 [localNotif release];*/
	
}

- (void) dealloc {
    [super dealloc];
}

@end


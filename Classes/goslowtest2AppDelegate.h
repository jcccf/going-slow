//
//  goslowtest2AppDelegate.h
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface goslowtest2AppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *tabController;
    UIWindow *window;
	UILocalNotification *suggestionNotification;
	UILocalNotification *reflectionNotification;
	
	NSInteger *timeMorning;
	NSInteger *timeEvening;
	bool *isNotFirstRun;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabController;
@property (nonatomic, retain) IBOutlet UILocalNotification *suggestionNotification;
@property (nonatomic, retain) IBOutlet UILocalNotification *reflectionNotification;

@property (nonatomic) NSInteger *timeMorning;
@property (nonatomic) NSInteger *timeEvening;
@property (nonatomic) bool *isNotFirstRun;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;
- (void) setReflectionNotificationTime:(NSDate *)d;
- (void) setSuggestionNotificationTime:(NSDate *)d;
- (void) removeSuggestionTime;
- (void) removeReflectionTime;

@end


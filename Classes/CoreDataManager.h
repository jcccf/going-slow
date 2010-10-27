//
//  CoreDataManager.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Suggestion.h"
#import "Reflection.h"
#import "goslowtest2AppDelegate.h"


@interface CoreDataManager : NSObject {
	goslowtest2AppDelegate *appDelegateReference;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic,retain) goslowtest2AppDelegate *appDelegateReference;
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

-(void)addSuggestion:(NSString *)theme picturePath:(NSString *)picturePath infoPath:(NSString *)infoPath;
//-(void)updateSuggestion:(NSDate *) date:(int)index;
-(void)addReflection:(NSString *)reflectionText reflectionPicturePath:(NSString *)reflectionPicturePath reflectionColors:(NSArray *)colors;
-(void)saveChanges;
-(Suggestion*)fetchSuggestion;
-(void)deleteAllObjects: (NSString *) entityDescription;
+(CoreDataManager *)getCoreDataManagerInstance;

@end

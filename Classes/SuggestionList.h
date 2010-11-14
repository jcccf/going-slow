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


@interface SuggestionList: NSObject {
	NSMutableArray* suggestions;
}

@property (nonatomic, retain) NSArray *suggestions;

+(SuggestionList *)getInstance;
-(NSMutableArray*) returnArray;
-(Suggestion*) fetchSuggestion;
@end
//
//  SyncManager.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reflection.h"


@interface SyncManager : NSObject {

	NSMutableArray *bufferedReflections;
}

@property (nonatomic,retain) NSMutableArray *bufferedReflections;

- (void) bufferReflection: (Reflection *)r;
- (void) syncData;
+(SyncManager*) getSyncManagerInstance;
@end

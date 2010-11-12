//
//  SyncManager.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reflection.h"

@class Reachability;

@interface SyncManager : NSObject {
	int userId;
	NSMutableArray *bufferedReflections;
	Reachability* wifiReach;
}

@property (nonatomic,retain) NSMutableArray *bufferedReflections;

- (void) setUserId:(int)uid;
- (void) bufferTextReflection:(NSString*)text;
- (void) bufferPhotoReflection:(UIImage*)image;
- (void) bufferColorReflectionWithRed:(int)r andGreen:(int)g andBlue:(int)b;

- (void) syncData;

- (void) cleanup: (NSString *) output;

+(SyncManager*) getSyncManagerInstance;
@end

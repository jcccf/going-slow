//
//  HistoryTableViewController.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/27/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryReflectionViewController.h"
#import "CoreDataManager.h"
#import "Reflection.h"

@interface HistoryTableViewController : UITableViewController {
	HistoryReflectionViewController *histRefViewCont;
	NSMutableArray *dates;
	NSMutableArray *colorReflectionsToDate;
	NSMutableArray *textReflectionsToDate;
	NSMutableArray *photoReflectionsToDate;
	NSMutableArray *reflectionsPutInTable;
	NSMutableDictionary *reflectionIndexTable;
	CoreDataManager *coreDataManager;
}

@property(nonatomic,retain) HistoryReflectionViewController *histRefViewCont;
@property(nonatomic,retain) NSMutableArray *dates;
@property(nonatomic,retain) NSMutableArray *colorReflectionsToDate;
@property(nonatomic,retain) NSMutableArray *textReflectionsToDate;
@property(nonatomic,retain) NSMutableArray *photoReflectionsToDate;
@property(nonatomic,retain) NSMutableArray *reflectionsPutInTable;
@property(nonatomic,retain) NSMutableDictionary *reflectionIndexTable;
@property(nonatomic,retain) CoreDataManager *coreDataManager;
@end

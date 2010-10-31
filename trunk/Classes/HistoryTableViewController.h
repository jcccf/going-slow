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
}

@property(nonatomic,retain) HistoryReflectionViewController *histRefViewCont;
@end

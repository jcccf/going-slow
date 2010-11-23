//
//  NotificationTime.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/12/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goslowtest2AppDelegate.h"
#import "CoreDataManager.h"
#import "Suggestion.h"

@interface NotificationTime : UITableViewController {
	//IBOutlet UITableView *tableview;
	IBOutlet UIDatePicker *datePicker;
	goslowtest2AppDelegate *delegateReference;
	NSDate *morningDate;
	NSDate *eveningDate;
	UIBarButtonItem *doneButton;    // this button appears only when the date picker is open	
	NSArray *dataArray;	
	NSArray *dataArray2;	
	NSDateFormatter *dateFormatter;
	UIBarButtonItem *infoButton;
}

//@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) goslowtest2AppDelegate *delegateReference;
@property (nonatomic,assign) NSDate *morningDate;
@property (nonatomic,assign) NSDate *eveningDate;
@property (nonatomic, retain) NSArray *dataArray; 
@property (nonatomic, retain) NSArray *dataArray2; 
@property (nonatomic, retain) NSDateFormatter *dateFormatter; 
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *infoButton;


- (IBAction) goToHomeScreen:(id)sender;
-(IBAction) dateAction:(id)sender;
-(IBAction) showInfo:(id)sender;

@end


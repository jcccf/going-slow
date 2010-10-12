//
//  NotificationTime.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/12/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goslowtest2AppDelegate.h"

@interface NotificationTime : UIViewController {
	//IBOutlet UITableView *tableview;
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UITextField *eventText;
	goslowtest2AppDelegate *delegateReference;
}

//@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UITextField *eventText;
@property (nonatomic, retain) goslowtest2AppDelegate *delegateReference;

- (IBAction) scheduleAlarm:(id) sender;
- (IBAction) removeAlarm:(id) sender;

@end


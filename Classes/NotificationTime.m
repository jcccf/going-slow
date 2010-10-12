//
//  NotificationTime.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/12/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "NotificationTime.h"


@implementation NotificationTime

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	delegateReference = [[UIApplication sharedApplication] delegate];
	[datePicker setDate:[NSDate date]];
    [super viewDidLoad];
	
	//[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

@synthesize datePicker, eventText, delegateReference;

- (IBAction) removeAlarm:(id) sender{
	
}
- (IBAction) scheduleAlarm:(id) sender {
	
	//cancels all other notifications assigned to this application
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
    // Get the current date
    NSDate *pickerDate = [datePicker date];
	
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:pickerDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
												   fromDate:pickerDate];
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    [dateComps release];
	
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
	localNotif.fireDate = [itemDate dateByAddingTimeInterval:1];
	
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
    [localNotif release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	datePicker = nil;
	//tableview = nil;
	eventText = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end

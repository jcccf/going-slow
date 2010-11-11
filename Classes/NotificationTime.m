//
//  NotificationTime.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/12/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "NotificationTime.h"


@implementation NotificationTime
@synthesize datePicker, eventText, delegateReference, morningEvening;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*-(id) init{
	self = [super initWithNibName:@"NotificationTime" bundle:nil];
	
	return self;
	
}*/


-(IBAction)goToHomeScreen:(id)sender{
	//[self.view removeFromSuperview];
	
	UILocalNotification *localNotifMorning = [[UILocalNotification alloc] init];
	UILocalNotification *localNotifEvening = [[UILocalNotification alloc] init];
    if (localNotifMorning == nil)
        return;
	if (localNotifEvening == nil)
        return;
	
	localNotifEvening.fireDate = eveningDate;
	localNotifMorning.fireDate = morningDate;
	
	localNotifEvening.timeZone = [NSTimeZone defaultTimeZone];
	localNotifEvening.timeZone = [NSTimeZone defaultTimeZone];
	
	localNotifEvening.repeatInterval = NSDayCalendarUnit;
	localNotifMorning.repeatInterval = NSDayCalendarUnit;
	
	localNotifMorning.alertBody = @"Would you like a suggestion?";
	localNotifMorning.alertAction = @"See More";
	localNotifEvening.alertBody = @"How was your day?";
	localNotifEvening.alertAction = @"Reflect";
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotifEvening];
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotifMorning];
	
	[localNotifEvening release];
	[localNotifMorning release];
	
	/*localNotif.fireDate = [itemDate dateByAddingTimeInterval:1];
	
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
    [localNotif release];*/
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your notifications times have been updated" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	//[delegateReference.window addSubview:delegateReference.tabController.view];
	
}

-(IBAction)dateChanged:(id)sender{
	if(morningEvening.selectedSegmentIndex == 0){
		morningDate = [datePicker date];
		[morningDate retain];
		NSLog(@"Changing morning date");
	}
	else{
		NSLog(@"Changing evening date");
		eveningDate = [datePicker date];
		[eveningDate retain];
	}
	
}

-(IBAction)segmentChange:(id)sender{
	if(morningEvening.selectedSegmentIndex == 0){
		NSLog(@"InsideMorning Segment");
		[datePicker setDate:morningDate];
	}
	else {
		NSLog(@"Inside Evening Segment");
		NSLog([eveningDate description]);
		assert(eveningDate != nil);
		[datePicker setDate:eveningDate];
	}

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//delegateReference = [[UIApplication sharedApplication] delegate];
	
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
    // Get the current date
    NSDate *pickerDate = [datePicker date];
	
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:pickerDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
												   fromDate:pickerDate];
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	//NSDateComponents *dateComp1 = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:10];
	[dateComps setMinute:0];
	[dateComps setSecond:0];
	
	//[dateComp1 setHour:22];
	//[dateComp1 setMinute:0];

	// Notification will fire in one minute
	//[dateComps setSecond:[timeComponents second]];
	morningDate =[calendar dateFromComponents:dateComps];
	[dateComps setHour:22];
	eveningDate = [calendar dateFromComponents:dateComps];
	[eveningDate retain];
	[morningDate retain];
	NSLog([eveningDate description]);
	[datePicker setDate:morningDate];
	[dateComps release];
	
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

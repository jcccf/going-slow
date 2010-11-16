//
//  NotificationTime.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/12/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "NotificationTime.h"


@implementation NotificationTime
@synthesize datePicker, delegateReference, doneButton, dataArray, dateFormatter, infoButton, dataArray2;



-(IBAction)goToHomeScreen:(id)sender{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.datePicker.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	// start the slide down animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	
	// we need to perform some post operations after the animation is complete
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
	
	self.datePicker.frame = endFrame;
	[UIView commitAnimations];
	
	// grow the table back again in vertical size to make room for the date picker
	CGRect newFrame = self.tableView.frame;
	newFrame.size.height += self.datePicker.frame.size.height;
	self.tableView.frame = newFrame;
//	//[self.view removeFromSuperview];
//	[[UIApplication sharedApplication] cancelAllLocalNotifications];
//	
//	NSMutableArray *suggestionsArray = [[SuggestionList getInstance] returnArray];
//	NSCalendar *calendar = [NSCalendar currentCalendar];
//	
//	for (int i = 0; i < [suggestionsArray count]; i++) {
//
//		NSDateComponents *offset = [[NSDateComponents alloc] init];
//		[offset setDay:i];
//		//[offset setMinute:i];
//		NSDate *notificationDate = [calendar dateByAddingComponents:offset toDate:morningDate options:0];
//		//NSDate *notificationDate = [calendar dateByAddingComponents:offset toDate:[NSDate date] options:0];
//		
//		[offset release];
//		
//		Suggestion *suggestion = [suggestionsArray objectAtIndex:i]; 
//		
//		UILocalNotification *localNotifMorning = [[UILocalNotification alloc] init];
//		if (localNotifMorning == nil)
//			return;
//		
//		localNotifMorning.fireDate = notificationDate;
//		localNotifMorning.timeZone = [NSTimeZone defaultTimeZone];
//		//localNotifMorning.repeatInterval = NSMinuteCalendarUnit;
//		
//		localNotifMorning.alertBody = [NSString stringWithFormat:@"Today's Suggestion: %@", [suggestion theme]];
//		localNotifMorning.alertAction = @"See More";
//		
//		[[UIApplication sharedApplication] scheduleLocalNotification:localNotifMorning];
//		
//		[localNotifMorning release];
//		
//		
//	}
//	
//	//UILocalNotification *localNotifMorning = [[UILocalNotification alloc] init];
//	UILocalNotification *localNotifEvening = [[UILocalNotification alloc] init];
////    if (localNotifMorning == nil)
////        return;
//	if (localNotifEvening == nil)
//        return;
//	
//	localNotifEvening.fireDate = eveningDate;
//	//localNotifMorning.fireDate = morningDate;
//	
//	localNotifEvening.timeZone = [NSTimeZone defaultTimeZone];
//	//localNotifMorning.timeZone = [NSTimeZone defaultTimeZone];
//	
//	localNotifEvening.repeatInterval = NSDayCalendarUnit;
////	localNotifMorning.repeatInterval = NSDayCalendarUnit;
//	
////	localNotifMorning.alertBody = @"Would you like a suggestion?";
////	localNotifMorning.alertAction = @"See More";
//	localNotifEvening.alertBody = @"How was your day?";
//	localNotifEvening.alertAction = @"Reflect";
//	NSString *key = [NSString stringWithString:@"Type"];
//	NSString *val = [NSString stringWithString:@"Reflect"];
//	localNotifEvening.userInfo = [NSDictionary dictionaryWithObject:val forKey:key];
//	
//	
//	[[UIApplication sharedApplication] scheduleLocalNotification:localNotifEvening];
//	//[[UIApplication sharedApplication] scheduleLocalNotification:localNotifMorning];
//	
//	[localNotifEvening release];
//	//[localNotifMorning release];
//	
//	/*localNotif.fireDate = [itemDate dateByAddingTimeInterval:1];
//	
//	//1 day repeat interval
//	localNotif.repeatInterval = NSDayCalendarUnit;
//	// localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
//    localNotif.timeZone = [NSTimeZone defaultTimeZone];
//	
//	// Notification details
//    localNotif.alertBody = @"You should reflect";
//	// Set the action button
//    localNotif.alertAction = @"Reflect";
//	
//    localNotif.soundName = UILocalNotificationDefaultSoundName;
//    localNotif.applicationIconBadgeNumber = 1;
//	
//	// Specify custom data for the notification
//    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
//    localNotif.userInfo = infoDict;
//	
//	// Schedule the notification
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
//    [localNotif release];*/
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	
	if([indexPath row] == 0) {
		morningDate = [datePicker date];
		[morningDate retain];
		NSLog(@"Changing morning date");
		NSLog([morningDate description]);
	}
	if([indexPath row] == 1) {
		eveningDate = [datePicker date];
		[eveningDate retain];
		NSLog(@"Changing evening date");
		NSLog([eveningDate description]);
	}
	
		// remove the "Done" button in the nav bar
	
	self.navigationItem.rightBarButtonItem = self.infoButton;
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[[SuggestionList getInstance] setDate:morningDate eveningDate: eveningDate];

	[[SuggestionList getInstance] scheduleNotifications];
	
}

	

- (IBAction)dateAction:(id)sender
{
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.datePicker.date];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
	self.datePicker.date = [self.dateFormatter dateFromString:targetCell.detailTextLabel.text];
	
	// check if our date picker is already on screen
	if (self.datePicker.superview == nil)
	{
		[self.view.window addSubview: self.datePicker];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		//
		// compute the start frame
		CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
		CGSize pickerSize = [self.datePicker sizeThatFits:CGSizeZero];
		CGRect startRect = CGRectMake(0.0,
									  screenRect.origin.y + screenRect.size.height,
									  pickerSize.width, pickerSize.height);
		self.datePicker.frame = startRect;
		
		// compute the end frame
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width,
									   pickerSize.height);
		// start the slide up animation
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		
		// we need to perform some post operations after the animation is complete
		[UIView setAnimationDelegate:self];
		
		self.datePicker.frame = pickerRect;
		
		[UIView commitAnimations];
		
		// add the "Done" button to the nav bar
		self.navigationItem.rightBarButtonItem = self.doneButton;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"CustomCellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [self.dataArray2 objectAtIndex:indexPath.row];
	
	return cell;
}

- (void)slideDownDidStop
{
	// the date picker has finished sliding downwards, so remove it
	[self.datePicker removeFromSuperview];
}

-(IBAction)showInfo:(id)sender{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About" message:@"Go Slow is an application that helps you reduce stress. It gives you a suggestion in the morning and a reminder to reflect in the evening."
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.infoButton;
	//delegateReference = [[UIApplication sharedApplication] delegate];
	self.dataArray = [NSArray arrayWithObjects:@"Morning Reminder", @"Evening Reminder", nil];
	
	self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	//self.infoButton
	
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
    // Get the current date
    NSDate *pickerDate = [NSDate date];
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
	
	
	morningDate =[calendar dateFromComponents:dateComps];
	[dateComps setHour:22];
	eveningDate = [calendar dateFromComponents:dateComps];
	[eveningDate retain];
	[morningDate retain];
	
	self.dataArray2=[NSArray arrayWithObjects:[self.dateFormatter stringFromDate:morningDate], [self.dateFormatter stringFromDate:eveningDate], nil];
	
	[[SuggestionList getInstance] setDate:morningDate eveningDate: eveningDate];
	
	[[SuggestionList getInstance] scheduleNotifications];
	
	NSLog([eveningDate description]);
	[datePicker setDate:morningDate];
	[dateComps release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	datePicker = nil;
	//tableview = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end

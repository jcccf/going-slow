//
//  HistoryTableViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/27/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "HistoryTableViewController.h"


@implementation HistoryTableViewController
@synthesize histRefViewCont, dates, textReflectionsToDate, colorReflectionsToDate, photoReflectionsToDate, reflectionsPutInTable, reflectionIndexTable;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	imageFilePathDict = [[NSMutableDictionary alloc] init];
	self.navigationItem.title = @"Diary";
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)populateArrysAndSortDates{
	dates = [[NSMutableArray alloc] init];
	textReflectionsToDate = [[CoreDataManager getCoreDataManagerInstance] fetchReflections:@"TextReflection"];
	photoReflectionsToDate = [[CoreDataManager getCoreDataManagerInstance] fetchReflections:@"PhotoReflection"];
	colorReflectionsToDate = [[CoreDataManager getCoreDataManagerInstance] fetchReflections:@"ColorReflection"];
	
	
	//NSLog([NSString stringWithFormat:@"We got %i text reflections from database", [textReflectionsToDate size]]);
	for(TextReflection *t in textReflectionsToDate){
		if(![dates containsObject:[[[t createdAt] description] substringToIndex: 10]]){	
			[dates addObject:[[[t createdAt] description] substringToIndex: 10]];
			NSLog([NSString stringWithFormat:@"Added Text Date %@ to date array", [[t createdAt] description]]);
		}
		else{
			NSLog(@"Duplicate Date Text");
		}
	}
	
	for(ColorReflection *t in colorReflectionsToDate){
		if(![dates containsObject:[[[t createdAt] description] substringToIndex: 10]]){	
			[dates addObject:[[[t createdAt] description] substringToIndex: 10]];
			NSLog([NSString stringWithFormat:@"Added Color Date %@ to date array", [[t createdAt] description]]);
		}
		else{
			NSLog(@"Duplicate Date Color");
		}
	}
	for(PhotoReflection *t in photoReflectionsToDate){
		if(![dates containsObject:[[[t createdAt] description] substringToIndex: 10]]){	
			[dates addObject:[[[t createdAt] description] substringToIndex: 10]];
			NSLog([NSString stringWithFormat:@"Added Photo Date %@ to date array", [[t createdAt] description]]);
		}
		else{
			NSLog(@"Duplicate Date Photo");
		}
	}
	
	NSLog(@"There are %i dates in dates", [dates count]);
	
	[dates sortUsingSelector:@selector(compare:)];
	
	
	for(NSString *s in dates){
		NSLog([NSString stringWithFormat:@"Date : %@", s]);	
		
	}
	
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
	
	//[self populateArrysAndSortDates];
	reflectionsPutInTable = [[NSMutableArray alloc] init];
	reflectionIndexTable = [[NSMutableDictionary alloc] init];
	numPhotos = 1;
	[[self view] reloadData];
    [super viewDidAppear:animated];
	[[CoreDataManager getCoreDataManagerInstance] addLog:[NSNumber numberWithInt:2]];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	[self populateArrysAndSortDates];
	NSLog([NSString stringWithFormat:@"Dates count when determining section number %i", [dates count]]);
    return [dates count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	NSString *dateCompareString = [dates objectAtIndex:section];
	int count = 0;
	
	for(TextReflection *t in textReflectionsToDate){
		if([[[[t createdAt] description] substringToIndex :10] isEqualToString:dateCompareString])
			count++;
	}
	for(ColorReflection *c in colorReflectionsToDate){
		if([[[[c createdAt] description] substringToIndex :10] isEqualToString:dateCompareString])
			count++;
	}
	for(PhotoReflection *p in photoReflectionsToDate){
		if([[[[p createdAt] description] substringToIndex :10] isEqualToString:dateCompareString])
			count++;
	}
	//This needs to be changed to the number of reflections stored on the phone to date
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	BOOL keepLooping = YES;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSString *dateCompareString = [dates objectAtIndex:[indexPath section]];
	

	for(TextReflection *t in textReflectionsToDate){
		if(keepLooping){
		if([[[[t createdAt] description] substringToIndex :10] isEqualToString:dateCompareString]){
			if(![reflectionsPutInTable containsObject:t]){
				[reflectionsPutInTable addObject:t];
				[reflectionIndexTable setObject:t forKey:indexPath];
				int min = [[t reflectionText] length];
						   if(min >= 30){
							   min = 30;   
						   }
				NSLog([NSString stringWithFormat:@"Adding text %@ to Cell %i::%i", [t reflectionText], [indexPath section], [indexPath row]]);
				cell.textLabel.text = [[t reflectionText] substringToIndex:min];
				cell.backgroundView = nil;
				keepLooping = NO;
			}
		}
		}
	}
	

	for(ColorReflection *c in colorReflectionsToDate){
		if(keepLooping){
		if([[[[c createdAt] description] substringToIndex :10] isEqualToString:dateCompareString])
			if(![reflectionsPutInTable containsObject:c]){
				[reflectionsPutInTable addObject:c];
				[reflectionIndexTable setObject:c forKey:indexPath];
				//cell.textLabel.text = [[c reflectionText] substringToIndex:15];
				keepLooping = NO;
				UIView *vi = [[UIView alloc] init];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.text = @"";
				vi.backgroundColor = [UIColor colorWithRed:[[c colorRed]floatValue] green:[[c colorGreen]floatValue] blue:[[c colorBlue]floatValue] alpha:1];
				cell.backgroundView = vi;		
			}}
	}
	

	for(PhotoReflection *p in photoReflectionsToDate){
		if(keepLooping){
		if([[[[p createdAt] description] substringToIndex :10] isEqualToString:dateCompareString])
			if(![reflectionsPutInTable containsObject:p]){
				[reflectionsPutInTable addObject:p];
				[reflectionIndexTable setObject:p forKey:indexPath];
				//UIImage *im = [UIImage imageWithContentsOfFile:[p filepath]];
				//cell.backgroundView = [[UIImageView alloc] initWithImage:im];
				cell.textLabel.text = [NSString stringWithFormat:@"Photo %i", numPhotos];
				numPhotos++;
				cell.backgroundView = nil;
				keepLooping = NO;
			}
		}
	}
	
	//cell.accessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	cell.textLabel.textAlignment = UITextAlignmentLeft;
	
	//Here make the text the date of the reflection or type, or whatever is right for the cell's text
	//cell.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d",[indexPath section],[indexPath row]];
    // Configure the cell...
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [dates objectAtIndex:section];
}

-(UITableViewCellAccessoryType)tableView:(UITableView*)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellAccessoryDisclosureIndicator;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	/****************************/
	//Here we need to decide based on the selection of the table the folllowing:
	//1)what kind of reflection it is
	//2)Based on that reflection, display the appropriate views in histRefViewCont
	if (histRefViewCont == nil) {
		histRefViewCont = [[HistoryReflectionViewController alloc] initWithNibName:@"HistoryReflectionViewController" bundle:nil];
		
	}
	
	NSObject *ob = [reflectionIndexTable objectForKey:indexPath];
	
	
	
	if([ob isKindOfClass:[TextReflection class]]){
		TextReflection *r = (TextReflection*)ob;
		histRefViewCont.navigationItem.title = [NSString stringWithFormat:@"Text for day %@", [[[r createdAt] description] substringToIndex:10]];
		histRefViewCont.t.hidden = NO;
		histRefViewCont.i.hidden = YES;
		histRefViewCont.te = [r reflectionText];
		//histRefViewCont.t.text = [r reflectionText];
		[[self navigationController] pushViewController:histRefViewCont animated:YES];
	}
	else{
		if([ob isKindOfClass:[ColorReflection class]]){
			
		}
		else{
			PhotoReflection *p = (PhotoReflection*)ob;
			histRefViewCont.navigationItem.title = [NSString stringWithFormat:@"Photo for date %@",[[[p createdAt] description] substringToIndex:10]];
			histRefViewCont.t.hidden = YES;
			histRefViewCont.i.hidden = NO;
			NSLog([NSString stringWithFormat:@"%@", [p filepath]]);
			histRefViewCont.im = [UIImage imageWithContentsOfFile:[p filepath]];
			//UIImage *image = [UIImage imageWithContentsOfFile:[p filepath]];
			//assert(image != nil);
			//histRefViewCont.view = histRefViewCont.i;
			[[self navigationController] pushViewController:histRefViewCont animated:NO];
			//[image release];
		}
	}
	
	//histRefViewCont.navigationItem.title = ([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
	//[[self navigationController] pushViewController:histRefViewCont animated:NO];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[[CoreDataManager getCoreDataManagerInstance] release];
    [super dealloc];
}


@end


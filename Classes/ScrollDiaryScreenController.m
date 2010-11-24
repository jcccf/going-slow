//
//  ScrollDiaryScreenController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 11/23/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "ScrollDiaryScreenController.h"
#import "ScrollViewPageController.h"
#import "DayTableObject.h"

#import "ReflectionTableManager.h"
#import "ColorReflection.h"
#import "TextReflection.h"
#import "HistoryReflectionViewController.h"
#import "PhotoReflection.h"



static NSUInteger kNumberOfPages = 0;

static currentPage = 0;

static NSMutableArray* dates = nil;

static BOOL firstLoad = YES;

@implementation ScrollDiaryScreenController

@synthesize scrollView, dateTableView, viewControllers, tableManager, dateToPageDict,histRefViewCont, imagesForFilePath;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(NSMutableArray*)getColors{
	
	NSString *dateKey = [dates objectAtIndex:currentPage];
	
	DayTableObject *d = [tableManager.dayToTableRepDict objectForKey:dateKey];
	
	NSMutableArray *allref = [d reflections];
	
	NSMutableArray *returnValue = [[NSMutableArray alloc] init];
	[returnValue retain];
	
	for(Reflection *r in allref){
		if([r isKindOfClass:[ColorReflection class]])
			[returnValue addObject:r];
	}
	
	return returnValue;
	
}

-(void)loadScrollViewWithPage:(int)page{
	
	if(page < 0)
		return;
	if(page >= kNumberOfPages){
		return;
	}
	
	ScrollViewPageController *s = [viewControllers objectAtIndex:page];
	
	//s should never be nil
	assert(s != nil);
	
	assert(s.view != nil);
	
	assert(s.imageView != nil);
	
	[scrollView addSubview:s.view];
	
	
	
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView1{
	if(scrollView1 = scrollView){
		CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if(currentPage != page){
			currentPage = page;
			[dateTableView reloadData];
		}
		
		[self loadScrollViewWithPage:page-1];
		[self loadScrollViewWithPage:page];
		[self loadScrollViewWithPage:page+1];
			
	}
	
}

-(void)viewDidAppear:(BOOL)animated{
	
	//dateToPageDict = [[NSMutableDictionary alloc] init];
	
	//set kNumberofPages here with how many dates are in coredata etc.
	viewControllers = [[NSMutableArray alloc] init];
	
	tableManager = [[ReflectionTableManager alloc] init];
	
	[tableManager retain];
	
	kNumberOfPages = [tableManager.dayToTableRepDict count];
	
	
	NSArray* s = [[tableManager dayToTableRepDict] allKeys];
	
	dates = [[NSMutableArray alloc] init];
	
	[dates addObjectsFromArray:s];
	
    [dates sortUsingSelector:@selector(compare:)];
	
	
	
	
	//add ScrolViewPageControllers here.  The imageViews are instantiated here and added to the scrollView
	for(int i = 0; i < kNumberOfPages; i++){
		
		ScrollViewPageController *s = [[ScrollViewPageController alloc] init];
		UIView *v = [[UIView alloc] init];
		
		// Get a Random Color for a Day
		NSString *dateKey = [dates objectAtIndex:i];
		DayTableObject *d = [tableManager.dayToTableRepDict objectForKey:dateKey];
		NSMutableArray *allref = [d reflections];
		NSMutableArray *colors = [[NSMutableArray alloc] init];
		for(Reflection *r in allref){
			if([r isKindOfClass:[ColorReflection class]])
				[colors addObject:r];
		}
		CGFloat red = 1.0f;
		CGFloat green = 1.0f;
		CGFloat blue = 1.0f;
		if ([colors count] > 0) {
			ColorReflection* cr = (ColorReflection*) [colors objectAtIndex:(arc4random() % [colors count])];
			red = [[cr colorRed] floatValue];
			green = [[cr colorGreen] floatValue];
			blue = [[cr colorGreen] floatValue];
		}
//		CGFloat red = (arc4random() % 32767) / 32767.0f;
//		CGFloat green = (arc4random() % 32767) / 32767.0f;
//		CGFloat blue = (arc4random() % 32767) / 32767.0f;
		UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
		UIImage *img = [UIImage imageNamed:@"DiaryFlower.png" withColor:randomColor];
		
		//CHANGE THIS TO REPRESENT THE CORRECT FLOWER
		s.imageView = [[UIImageView alloc] initWithImage:img];
		s.imageView.frame = CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
		[v addSubview:s.imageView];
		
		// Add Left Arrow
		if (i != 0) {
			UIImageView* leftArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArrowLeft.png"]];
			leftArrow.frame = CGRectMake(i*scrollView.frame.size.width+10, 80, 25, 25);
			[v addSubview:leftArrow];
		}
		
		// Add Right Arrow
		if (i < kNumberOfPages-1 ) {
			UIImageView* rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArrowRight.png"]];
			rightArrow.frame = CGRectMake((i+1)*scrollView.frame.size.width-35, 80, 25, 25);
			[v addSubview:rightArrow];
		}
			
		s.view = v;
		[viewControllers addObject:s];
		
	}
	
	scrollView.pagingEnabled = YES;
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * (kNumberOfPages),scrollView.frame.size.height);
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.scrollsToTop = NO;
	scrollView.delegate = self;
	scrollView.alwaysBounceHorizontal = YES;
	scrollView.clipsToBounds = YES;
	
	//only go to the most recent date if we just loaded the view otherwise, stay at the date they were on...
	if(firstLoad){
	[scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(kNumberOfPages-1), 0)];
		
	}
    [self loadScrollViewWithPage:kNumberOfPages-1];
	[self loadScrollViewWithPage:kNumberOfPages-2];
	
	//CoreDataManager *c = [CoreDataManager getCoreDataManagerInstance];
	
	firstLoad = NO;
	[dateTableView reloadData];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self viewDidAppear:NO];
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)makeThisDateTable{

	thisDateTable = [[NSMutableArray alloc] init];
	
	if([dates count] > 0){
	NSString *dateKey = [dates objectAtIndex:currentPage];
	
	DayTableObject *d = [tableManager.dayToTableRepDict objectForKey:dateKey];
	
	NSMutableArray *allref = [d reflections];
	
	for(Reflection *r in allref){
		if(![r isKindOfClass:[ColorReflection class]]){
			[thisDateTable addObject:r];
		}
		
	}
	}
	
	
	
}

- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	[self makeThisDateTable];
	
	
    return [thisDateTable count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	Reflection *r = [thisDateTable objectAtIndex:[indexPath row]];
	
	if([r isKindOfClass:[TextReflection class]]){
		TextReflection *t = (TextReflection*)r;
		NSString *text = [t reflectionText];
		if([text length] > 30){
			text = [text substringToIndex:30];
		}
		cell.textLabel.text = text;
		
	}
	if([r isKindOfClass:[PhotoReflection class]]){
			
		cell.textLabel.text = @"Photo";
	}
	
	
    
    // Configure the cell...
	
	
	//cell.textLabel.text = [NSString stringWithFormat:@"Cell number %i", [indexPath row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	
	//TODO
	//return the correct date...
	if([dates count] > 0){
	return [dates objectAtIndex:currentPage];
	}
	else {
		return @"Empty Diary";
	}

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
	
	Reflection *r = [thisDateTable objectAtIndex:[indexPath row]];
	
	if(histRefViewCont == nil){
		histRefViewCont = [[HistoryReflectionViewController alloc] initWithNibName:@"HistoryReflectionViewController" bundle:nil];
	}
	
	if([r isKindOfClass:[TextReflection class]]){
		TextReflection *t = (TextReflection*)r;
		histRefViewCont.navigationItem.title = [NSString stringWithFormat:@"Text for day %@", [[[t createdAt] description] substringToIndex:10]];
		histRefViewCont.t.hidden = NO;
		histRefViewCont.i.hidden = YES;
		histRefViewCont.te = [t reflectionText];
		//histRefViewCont.t.text = [r reflectionText];
		[[self navigationController] pushViewController:histRefViewCont animated:YES];
		
		
	}
	else{
		
		PhotoReflection *p = (PhotoReflection*)r;
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


@end
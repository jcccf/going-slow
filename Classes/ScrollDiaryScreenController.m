//
//  ScrollDiaryScreenController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 11/23/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "ScrollDiaryScreenController.h"
#import "ScrollViewPageController.h"



static NSUInteger kNumberOfPages = 6;

static currentPage = 0;


@implementation ScrollDiaryScreenController

@synthesize scrollView, dateTableView, viewControllers;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(NSArray*)getColors:(NSDate*)date{
	
	
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
		currentPage = page;
		
		[self loadScrollViewWithPage:page-1];
		[self loadScrollViewWithPage:page];
		[self loadScrollViewWithPage:page+1];
			
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//set kNumberofPages here with how many dates are in coredata etc.
	viewControllers = [[NSMutableArray alloc] init];
	
	
	//add ScrolViewPageControllers here.  The imageViews are instantiated here and added to the scrollView
	for(int i = 0; i < kNumberOfPages; i++){
			
		ScrollViewPageController *s = [[ScrollViewPageController alloc] init];
		
		//right now image views are just repeat of "breathe".  
		
		//TODO:
		
		//CHANGE THIS TO REPRESENT THE CORRECT FLOWER
		s.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"breathe.png"]];
		//set image view frame etc.
		s.imageView.frame = CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
		
		UIView *v = [[UIView alloc] init];
		[v addSubview:s.imageView];
		s.view = v;
		
		[viewControllers addObject:s];
		
	}
	
	scrollView.pagingEnabled = YES;
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages,scrollView.frame.size.height);
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.scrollsToTop = NO;
	scrollView.delegate = self;
	scrollView.alwaysBounceHorizontal = YES;
	scrollView.clipsToBounds = YES;
	[scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*kNumberOfPages, 0)];
    [self loadScrollViewWithPage:kNumberOfPages];
	[self loadScrollViewWithPage:kNumberOfPages-1];
	
	
	
	
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
    return kNumberOfPages;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	cell.textLabel.text = [NSString stringWithFormat:@"Cell number %i", [indexPath row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	
	//TODO
	//return the correct date...
	return @"Date of the reflection...";
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
}


@end

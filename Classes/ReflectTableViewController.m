//
//  ReflectTableViewController.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/27/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "ReflectTableViewController.h"


@implementation ReflectTableViewController

@synthesize reflectCameraViewController, reflectTextViewController;
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"How was your day?";
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	coreDataManager = [CoreDataManager getCoreDataManagerInstance];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[coreDataManager addLog:[NSNumber numberWithInt:3]];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		if([indexPath row] == 2){
			cell.imageView.image = [UIImage imageNamed:@"icon_digital_camera2.png"];
			cell.textLabel.text = @"Add Photo";
			cell.textLabel.textAlignment = UITextAlignmentLeft;
		}
		
		else {
			if([indexPath row] == 1){
				cell.imageView.image = [UIImage imageNamed:@"icon_document_pen.png"];
				cell.textLabel.text = @"Add Text";
				cell.textLabel.textAlignment = UITextAlignmentLeft;
			}
			else {
				cell.imageView.image = [UIImage imageNamed:@"icon_color_wheel.png"];
				cell.textLabel.text = @"Add Color";
				cell.textLabel.textAlignment = UITextAlignmentLeft;
			}

		}

    }
    
    // Configure the cell...
    
    return cell;
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
	
	if([indexPath row] == 2)
		[self goToCamera];
	if([indexPath row] == 1)
		[self goToText];
	if([indexPath row] == 0)
		[self goToColor];
}

#pragma mark -
#pragma mark Memory management



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 reflectView = [[UIView alloc] init];
 [reflectView retain];
 }
 return self;
 }*/



-(void) goToCamera
{
	if(reflectCameraViewController == nil){
		reflectCameraViewController = [[UIImagePickerController alloc] init];
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
			reflectCameraViewController.sourceType = UIImagePickerControllerSourceTypeCamera;}
		else {
			reflectCameraViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		}
		reflectCameraViewController.allowsEditing = NO;
		reflectCameraViewController.delegate = self;
		//reflectTextViewController.title = @"Reflection Pictures";
		
	}
	[[self navigationController] presentModalViewController:reflectCameraViewController animated:YES];
	
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	//Save image to disk
	
	NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 0.25f)];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *imagePath = [paths objectAtIndex:0];
	NSString *fullPath = [NSString stringWithFormat:@"%@/%@.jpg",imagePath,[[NSDate date] description]];
	
	
	BOOL f = [imageData writeToFile:fullPath atomically:YES];
	
	if(!f)
		NSLog(@"Image save fail");
	else {
		NSLog(@"Image saved!");
	}

	
	[[CoreDataManager getCoreDataManagerInstance] addPhotoReflection:fullPath];
	

	[[self navigationController] dismissModalViewControllerAnimated:YES];
	// Save image
	//UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	//[picker release];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	UIAlertView *alert;
	
	// Unable to save the image  
	if (error)
		alert = [[UIAlertView alloc] initWithTitle:@"Error" 
										   message:@"Unable to save image to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	else // All is well
		alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image saved to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	[alert show];
	[alert release];
	[[self navigationController] dismissModalViewControllerAnimated:YES];
}

-(void)goToText
{
	if(reflectTextViewController == nil){
		reflectTextViewController = [[ReflectTextViewController alloc] initWithNibName:@"ReflectTextViewController" bundle:nil];
		
	}
	[[self navigationController] pushViewController:reflectTextViewController animated:YES];
}

-(void)goToColor
{
	if(reflectColorViewController == nil){
		reflectColorViewController = [[ReflectColorViewController alloc] initWithNibName:@"ReflectColorViewController" bundle:nil];
	}
	[[self navigationController] pushViewController:reflectColorViewController animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void)storeReflection:(Reflection *)r{
	
}

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
	[coreDataManager release];
    [super dealloc];
}


@end


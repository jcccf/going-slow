//
//  SyncManager.m
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import "SyncManager.h"

// Posting constants
#define NOTIFY_AND_LEAVE(X) {[self cleanup:X]; return;}
#define DATA(X)	[X dataUsingEncoding:NSUTF8StringEncoding]
#define IMAGE_CONTENT @"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n"
#define STRING_CONTENT @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define MULTIPART @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"

@implementation SyncManager

static SyncManager *sharedInstance = nil;

@synthesize bufferedReflections;

+(SyncManager*)getSyncManagerInstance{
	@synchronized(self){
		if(sharedInstance == nil){
			sharedInstance = [[self alloc] init];
		}
	}
	return sharedInstance;
}

- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict
{
    id boundary = @"------------0x0x0x0x0x0x0x0x";
    NSArray* keys = [dict allKeys];
    NSMutableData* result = [NSMutableData data];
	
    for (int i = 0; i < [keys count]; i++) 
    {
        id value = [dict valueForKey: [keys objectAtIndex:i]];
        [result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
		if ([value isKindOfClass:[NSData class]]) 
		{
			// handle image data
			NSString *formstring = [NSString stringWithFormat:IMAGE_CONTENT, [keys objectAtIndex:i]];
			[result appendData: DATA(formstring)];
			[result appendData:value];
		}
		else 
		{
			// all non-image fields assumed to be strings
			NSString *formstring = [NSString stringWithFormat:STRING_CONTENT, [keys objectAtIndex:i]];
			[result appendData: DATA(formstring)];
			[result appendData:DATA(value)];
		}
		
		NSString *formstring = @"\r\n";
        [result appendData:DATA(formstring)];
    }
	
	NSString *formstring =[NSString stringWithFormat:@"--%@--\r\n", boundary];
    [result appendData:DATA(formstring)];
    return result;
}

-(void)setUserId:(int)uid{
	userId = uid; //TODO Does this work?
}

-(NSString*)getUserIdAsString{
	assert(userId != 0); // Have you set the userId??
	return [NSString stringWithFormat: @"%d", userId];
}

-(NSString*)getIntAsString:(int)i{
	return [NSString stringWithFormat: @"%d", i];
}

-(void) bufferTextReflection:(NSString *)text{
	NSLog(@"Buffering Text Reflection");
	assert(text != nil);
	NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    [post_dict setObject:text forKey:@"text_reflection[text]"];
	[post_dict setObject:[self getUserIdAsString] forKey:@"text_reflection[user_id]"];
	NSData *postData = [self generateFormDataFromPostDictionary:post_dict];
	[post_dict release];
	
	// Establish the API request. Use upload vs uploadAndPost for skip tweet
    NSString *baseurl = @"http://wl58-rails.cac.cornell.edu/app/text_reflections"; 
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (!urlRequest) NOTIFY_AND_LEAVE(@"Error creating the URL Request");
	
    [urlRequest setHTTPMethod: @"POST"];
	[urlRequest setValue:MULTIPART forHTTPHeaderField: @"Content-Type"];
    [urlRequest setHTTPBody:postData];
	
	// Submit & retrieve results
	NSLog(@"Contacting Rails....");
	[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}

-(void) bufferPhotoReflection:(UIImage *)image{
	NSLog(@"Buffering Photo Reflection");
	assert(image != nil);
	NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
	[post_dict setObject:UIImageJPEGRepresentation(image, 0.75f) forKey:@"photo_reflection[uploaded_picture]"];
	[post_dict setObject:[self getUserIdAsString] forKey:@"photo_reflection[user_id]"];
    NSData *postData = [self generateFormDataFromPostDictionary:post_dict];
	[post_dict release];
	
	// Establish the API request. Use upload vs uploadAndPost for skip tweet
    NSString *baseurl = @"http://wl58-rails.cac.cornell.edu/app/photo_reflections"; 
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (!urlRequest) NOTIFY_AND_LEAVE(@"Error creating the URL Request");
	
    [urlRequest setHTTPMethod: @"POST"];
	[urlRequest setValue:MULTIPART forHTTPHeaderField: @"Content-Type"];
    [urlRequest setHTTPBody:postData];
	
	// Submit & retrieve results
	NSLog(@"Contacting Rails....");
	[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}

-(void) bufferColorReflectionWithRed:(int)r andGreen:(int)g andBlue:(int)b{
	NSLog(@"Buffering Color Reflection");
	assert(r >= 0 && r <=255);
	assert(g >= 0 && g <=255);
	assert(b >= 0 && b <=255);
	NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    [post_dict setObject:[self getIntAsString:r] forKey:@"color_reflection[red]"];
	[post_dict setObject:[self getIntAsString:g] forKey:@"color_reflection[blue]"];
	[post_dict setObject:[self getIntAsString:b] forKey:@"color_reflection[green]"];
	[post_dict setObject:[self getUserIdAsString] forKey:@"color_reflection[user_id]"];
	NSData *postData = [self generateFormDataFromPostDictionary:post_dict];
	[post_dict release];
	
	// Establish the API request. Use upload vs uploadAndPost for skip tweet
    NSString *baseurl = @"http://wl58-rails.cac.cornell.edu/app/color_reflections"; 
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (!urlRequest) NOTIFY_AND_LEAVE(@"Error creating the URL Request");
	
    [urlRequest setHTTPMethod: @"POST"];
	[urlRequest setValue:MULTIPART forHTTPHeaderField: @"Content-Type"];
    [urlRequest setHTTPBody:postData];
	
	// Submit & retrieve results
	NSLog(@"Contacting Rails....");
	[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}

-(void)syncData{
	// TODO
	// So we would most likely want to buffer urlRequest objects in an array
	// And only when we have an internet connection (WiFi only), we execute all the urlRequests
	// All the requests above are asynchronous, i.e. they automatically create an upload thread.
	// And how to use this class:
	// 1. Get the singleton instance
	// 2. Pass it the user id of this device
	// 3. Call the appropriate buffer functions
	// 4. Call syncData whenever we can
}

- (void) cleanup: (NSString *) output
{
	NSLog(@"Error occured - %@", output);
}

#pragma mark URLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received response...");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *outstring = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"%@", [NSString stringWithFormat: @"Success: %@", outstring]);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
	
    // inform the user
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Error" message:[NSString stringWithFormat:@"The upload failed with this error: %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
	
    NSLog(@"Connection failed! Error - %@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"upload succeeded!");
    [connection release];
}
@end

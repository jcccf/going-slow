//
//  Screen1ViewController.m
//  goslowtest2
//
//  Created by Kevin Tse on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Screen1ViewController.h"
#include <stdlib.h>

@implementation Screen1ViewController

@synthesize label;
@synthesize imageViewPicture;

@synthesize suggestionsArray;

@synthesize isNotFirstRun;
@synthesize coreDataManager;

- (IBAction) sayHello:(id) sender {
	if(switchText == 0){
		[UIView beginAnimations:@"flipping view" context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
							   forView:self.view cache:YES];
		imageViewPicture.hidden = true;
		backText.hidden = false;
		label.hidden = true;
		switchText = 1;
		firstView.backgroundColor = [UIColor whiteColor];
		[UIView commitAnimations];
	}
	else {
		[UIView beginAnimations:@"flipping view" context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
							   forView:self.view cache:YES];
		backText.hidden = true;
		label.hidden = false;
		imageViewPicture.hidden = false;
		switchText = 0;
		firstView.backgroundColor = [UIColor blackColor];
		[UIView commitAnimations];
	}
	

}

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
 */



-(void)addAllSuggestions{
	[coreDataManager deleteAllObjects:@"Suggestion"];
	
	//NSString *textPaths = @"<b>Deep breathing</b> can reduce anxiety and disrupt repetitive or negative thoughts by focusing awareness on the present moment. Changing your breathing can shift your mood and perspective. <i>Try taking a deep breath in through the nose for 3 seconds... hold for 2 seconds... breathe out through the mouth for 6 seconds...</i>,back of Choose Consciously.jpg,backof Connect with Nature.jpg,backof connect with others.jpg,backof Control worry.jpg,backof Eat Well.jpg,backof Exercise.jpg,backof Express Gratitude.jpg,backof Get more sleep.jpg,backof Grow from mistakes.jpg,backof Laughter.jpg,backof Music.jpg,backof Meditation.jpg,backof Play.jpg,backof Powernap.jpg,backof reflect.jpg,backof Relax your Body.jpg,backof Think Positively.jpg,backof Thoughts matter.jpg,backof Use Resources.jpg,backof Visualization.jpg";
	NSMutableArray *textPicturePaths = [NSMutableArray array];

	[textPicturePaths addObject:@"<b>Deep breathing</b> can reduce anxiety and disrupt repetitive or negative thoughts by focusing awareness on the present moment. Changing your breathing can shift your mood and perspective. <i>Try taking a deep breath in through the nose for 3 seconds... hold for 2 seconds... breathe out through the mouth for 6 seconds...</i>"];
	[textPicturePaths addObject:@"<b>Choose consciously.</b> Making conscious choices based on your personal values and priorities means living with intention. It can increase your power over how you spend your time, respond to others, and react to situations.<br /><b>Try this:</b> <i>Think of one thing you want to accomplish today. Focus your mind on this intention. Notice the increased sense of control and clarity on how to proceed.</i>"];
	[textPicturePaths addObject:@"<b>Nature is in perfect balance.</b> When you view it or immerse yourself in it, you can connect with your own natural equilibrium. Nature can remind you to keep life in perspective, and help you feel renewed and focused. <br /><b>Try this:</b><i> Go for a walk, take in the view outside your window, watch a squirrel, or listen to the wind. Notice how it influences your thoughts and overall mood.</i>"];
	[textPicturePaths addObject:@"<b>Connecting with people</b> who respect and care about you, and offer support rather than judgment, is one of the best ways to restore balance and renew your hope (or “energy”). Studies show that people who have close and trusting relationships feel less stressed, anxious, and depressed.<br /><b>Try this</b>: <i>Take time every day to share a meal, walk to class, see a film, or shoot hoops with a good friend.</i>"];
	[textPicturePaths addObject:@"<b>Control worry.</b> Sometimes worry is a symptom that something needs your attention. Focusing on the source of the worry can help you explore its seriousness and take action. Other times, the source of worry is beyond your control. If such worries create repetitive thoughts or anxiety for you, learning how to “let go” can help restore peace of mind. <br /><b>Try this:</b> <i>Worried about things you cannot change? Let go of the source of the worry. Instead, take action where you can: focus on responding in a healthy way. Breathe. Move. Laugh.</i>"];
	[textPicturePaths addObject:@"<b>Eat well.</b> Quality food, eaten at regular intervals, provides the fuel your body and mind need to be productive throughout the day. It also provides the energy needed to buffer life’s daily stressors. <i>Choose a variety of food - colors, textures, tastes - at meals. Combine foods (e.g. an apple and a piece of cheese) to create a high-energy snack. Take time to enjoy your food: notice the flavor and feel of each bite.</i>"];
	[textPicturePaths addObject:@"<b>Exercise</b> is a healthy way to release pent-up energy, anger, or anxiety. Just 30 minutes of moderate exercise releases endorphins, the body’s natural mood enhancers. Any physical movement can help relieve stress. Try walking, running, hiking, dancing, swimming, skating, shooting hoops, or working out at the gym."];
	[textPicturePaths addObject:@"<b>Express Gratitude.</b> Gratitude is an attitude you can choose, even when things are difficult. Giving and receiving appreciation reminds us that we are not alone and belong to something bigger than ourselves.<br /><b>Try this:</b> <i>Make a list of people and things you are grateful for today. Add to the list over time. Express your thanks daily. Notice how it makes you feel.</i>"];
	[textPicturePaths addObject:@"<b>Get more sleep.</b> The benefits will affect nearly every area of your life. Sleep helps repair the body, helps you cope better with stress, and improves memory and learning. After a good night’s sleep your thoughts are clearer, your reactions faster, and your emotions less fragile.<br /><b>Try this:</b> <i>Set your bedtime 15-30 minutes earlier. Gradually, add more minutes until you are getting at least eight hours each night.<i>"];
	[textPicturePaths addObject:@"<b>Grow from mistakes.</b> Successful people say what they learned from their mistakes enabled them to succeed. Give yourself permission to be imperfect so you can open yourself to learning. “Failure” doesn’t mean you aren’t doing your best. It may mean it’s time to evaluate what got in the way of a better result.<br /><b>Try this:</b> <i>Use self-examination or ask for feedback on where to focus your efforts next time to create a different outcome.</i>"];
	[textPicturePaths addObject:@"<b>Laughter</b> jolts us out of our usual state of mind and can eliminate negative feelings. As a result, humor can be a powerful antidote to burn-out. Hearty belly-laughs exercise muscles, stimulate circulation, decrease stress hormones, and increase your immune system’s defenses, making laughter one of the most beneficial stress reduction techniques you can practice."];
	[textPicturePaths addObject:@"<b>Music</b> can energize or relax you. Studies show it can lower blood pressure and respiration, creating a calming effect. <i>Be conscious of how music makes you feel. Choose what you need at the moment (e.g. to lighten a heavy mood; to help you relax and fall asleep).</i> Have fun discovering new music: attend performances; make your own (sing, drum, etc.). Enjoy sharing it all with your friends."];
	[textPicturePaths addObject:@"<b>Meditation<b> is the process of tuning out the world and turning your attention inward. Focus your attention on your breath, a word or phrase, or an image. <i>Observe without judgment any distracting thoughts that arise as you “tune in;” release them as you exhale. Return your attention inward.</i> Once you acquire the skill, mindfulness meditation can be done anywhere, for a few minutes or longer when possible."];
	[textPicturePaths addObject:@"<b>Play!</b> Enjoy a pleasurable, no-pressure activity. Being “child-like\" (different from “child<u>ish</u>”) allows you to explore, to experience your feelings in the moment, to release your tension in a creative way, and to rebound from disappointments with greater ease. <i>Whether it’s finger painting, jumping in leaves, or reading a book “just for fun,” take time to experience the joy of play every day.</i>"];
	[textPicturePaths addObject:@"<b>Power naps</b>, most effective in the afternoon, can make you more alert, reduce stress, and boost cognitive functioning. <i>Find a suitable place to relax, take a few deep breaths, and focus your attention on sleep. Enjoy giving your body this time to recharge.</i> To avoid feeling groggy afterward, limit your power nap to 20-30 minutes."];
	[textPicturePaths addObject:@"<b>Self-reflection</b> allows you to re-connect with your thoughts, feelings, and needs. It can help you “take stock” of attitudes and behaviors you want to keep, and those you hope to change. Making time to reflect can reduce stress by keeping you centered on what is most important for you.<br /><b>Try this</b>: <i>Keep a personal journal as a tool of self-discovery, to explore ideas, and set intentions.</i>"];
	[textPicturePaths addObject:@"<b>Progressive muscle relaxation</b> systematically relieves bodily tension and helps you feel more relaxed within minutes. <i>Starting with your toes and working your way up to your head, slowly tighten… hold… and then relax your various muscle groups (e.g. feet, legs, abdomen, buttocks, shoulders, arms, hands, face). As you release, think to yourself “these muscles are now relaxed.”</i> You may notice a feeling of heaviness as tension leaves your body."];
	[textPicturePaths addObject:@"<b>Think positively.</b> A healthy dose of optimism helps you make the best of stressful situations and increases your chance of success. Positive thinking allows you to hold on to positive feelings about yourself in times of disappointment, and to bounce back more quickly. <br /><b>Try this:</b><i> Remind yourself each day of one of your strengths. How can you use these to overcome adversity and accomplish goals?</i>"];
	[textPicturePaths addObject:@"<b>Thoughts matter</b> when it comes to stress. Every thought, every perception creates feelings that can either activate the stress response or the relaxation response. By becoming more aware of your thought patterns, you can identify what triggers your responses. Many strategies can help you counter stressful thoughts and maintain emotional balance."];
	[textPicturePaths addObject:@"<b>Use Resources.</b> Hundreds of people across campus can offer information, support, and encouragement when you encounter challenges. Reaching out to others can save time, reduce frustration, and provide options or perspective you may not have considered. Everyone needs a little support once in a while.<br /><b>Try this:</b> <i>Access resources early, before an issue becomes problematic.</i>"];
	[textPicturePaths addObject:@"<b>Visualization:</b> By mentally rehearing a task you want to master, you can achieve many of the same benefits you might from actual, physical practice. <i>Close your eyes and take a few deep breaths. Imagine yourself acting the task (e.g. taking an exam, having an important conversation). Now, focus on how your success feels (jazzed, relieved, satisfied, smart, etc.). Stay with that feeling for a while.</i>"];

	
	NSString *picturePathsString = @"breathe.jpg,choose_consciously.jpg,connect_with_nature.jpg,connect_with_others.jpg,control_worry.jpg,eat_well.jpg,exercise.jpg,express_gratitude.jpg,get_more_sleep.jpg,grow_from_mistakes.jpg,laugh.jpg,listen_to_music.jpg,meditate.jpg,play.jpg,power_nap.jpg,reflect.jpg,relax_your_body.jpg,think_positively.jpg,thoughts_matter.jpg,use_resources.jpg,visualize.jpg";

	NSArray *picturePaths = [picturePathsString componentsSeparatedByString:@","];
	
	NSString *themeString = @"Breathe,Choose Consciously,Connect With Nature,Connect With Others,Control Worry,Eat Well,Exercise,Express Gratitude,Get More Sleep,Grow From Mistakes,Laugh,Listen To Music,Meditate,Play,Power Nap,Reflect,Relax Your Body,Think Positively,Thoughts Matter,Use Resources,Visualize";

	NSArray *themes = [themeString componentsSeparatedByString:@","];	
	int arrayCount = [picturePaths count];
	
	for(int i = 0; i < arrayCount; i++){
		NSString* theme = [themes objectAtIndex:i];
		NSString* picturePath = [picturePaths objectAtIndex:i];
		NSString* infoPath = [textPicturePaths objectAtIndex:i];
		
		[coreDataManager addSuggestion:theme picturePath:picturePath infoPath:infoPath];
		
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	coreDataManager = [[CoreDataManager alloc] init];
	
	switchText = 0;
	//backText.hidden = TRUE;
	assert(label != nil);
	label.text = @"Hello W-w-world!";
	UIImage *i = [UIImage imageNamed:@"breathe.png"];
	assert(i != nil);
	imageViewPicture.image = i;
	assert(imageViewPicture != nil);
	
	//
	// Core Data Code Below
	//
		
	// Based on http://developer.apple.com/library/ios/#documentation/DataManagement/Conceptual/iPhoneCoreData01/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008305-CH1-SW1
	// Read it before editing!
	
	isNotFirstRun = [(goslowtest2AppDelegate*)[[UIApplication sharedApplication] delegate] isNotFirstRun];

	// Import All Suggestions, and only ONCE
	if (!isNotFirstRun) {
		// Create a New Suggestion Card
		[self addAllSuggestions];
		[coreDataManager saveChanges];
		
	}
	
	// Read from Suggestions Array and Set View Items Appropriately
	Suggestion *suggestion = [coreDataManager fetchSuggestion];
	label.text = [suggestion theme];
	//TODO: Pick an appropriate font.
	
	NSString *html1 = @"<div style=\"font-family: Helvetica; font-size: larger; margin: 10px;\">";
	NSString *html2 = [suggestion moreInfo];
	NSString *html3 = @"</div>";
	NSString *html = [NSString stringWithFormat:@"%@ %@ %@",
					 html1, html2, html3];
	[backText loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]];  
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
	
	for (Suggestion* s in suggestionsArray) {
		NSLog(@"Theme: %@", [s theme]);
		NSLog(@"Picture Path: %@", [s picturePath]);
		NSString *stringFromDate = [formatter stringFromDate:[s lastSeen]];
		NSLog(@"date: %@",  stringFromDate);
	}	
	
	[formatter release];
	
	
	//Set current image to the suggestion selected
	currentImage = [UIImage imageNamed:[suggestion picturePath]];
	NSLog(@"Picture Path: %@", [suggestion picturePath]);
	//assert(newImage != nil);
	imageViewPicture.image = currentImage;
	//currentImage = newImage;
	[currentImage retain];
	
	//Set current text to the selected image text
	currentImageText = [UIImage imageNamed:[suggestion moreInfo]];
	[currentImageText retain];
	//[newImage release];
	
	//Set last seen to today's date
	[suggestion setLastSeen:[NSDate date]];
	
	[coreDataManager saveChanges];
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
	self.suggestionsArray = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[label release];
	[button release];
	[imageViewPicture release];
	[suggestionsArray release];
	[coreDataManager release];
    [super dealloc];
}


@end

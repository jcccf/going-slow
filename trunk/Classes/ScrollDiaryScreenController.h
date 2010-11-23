//
//  ScrollDiaryScreenController.h
//  goslowtest2
//
//  Created by Gregory Thomas on 11/23/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageManager;


@interface ScrollDiaryScreenController : UIViewController <UIScrollViewDelegate>{

	IBOutlet UIScrollView *scrollView;
	IBOutlet UITableView *dateTableView;
	IBOutlet UIPageControl *pageControl;
	
	NSMutableArray *viewControllers;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UITableView *dateTableView;
@property(nonatomic,retain) UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableArray *viewControllers;


-(void)loadScrollViewWithPage:(int)page;

-(NSArray*)getColors:(NSDate*)date;
@end

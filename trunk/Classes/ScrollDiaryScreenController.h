//
//  ScrollDiaryScreenController.h
//  goslowtest2
//
//  Created by Gregory Thomas on 11/23/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReflectionTableManager;

@class PageManager;

@class HistoryReflectionViewController;


@interface ScrollDiaryScreenController : UIViewController <UIScrollViewDelegate>{

	IBOutlet UIScrollView *scrollView;
	IBOutlet UITableView *dateTableView;
	IBOutlet UIPageControl *pageControl;
	
	NSMutableDictionary *dateToPageDict;
	
	ReflectionTableManager *tableManager;
	
	HistoryReflectionViewController *histRefViewCont;
	
	
	NSMutableArray *thisDateTable;
	NSMutableArray *viewControllers;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UITableView *dateTableView;
@property(nonatomic,retain) UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableArray *viewControllers;
@property(nonatomic,retain) ReflectionTableManager *tableManager;
@property(nonatomic,retain) NSMutableDictionary *dateToPageDict;
@property(nonatomic,retain) NSMutableArray *thisDateTable;
@property(nonatomic,retain) HistoryReflectionViewController *histRefViewCont;


-(void)loadScrollViewWithPage:(int)page;

-(NSMutableArray*)getColors;
@end

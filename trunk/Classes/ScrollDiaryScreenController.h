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
	
	
	//dictionary given a file path returns an image.  This is so we don't load from disk everytime we reload the tableView with photos
	NSMutableDictionary *imagesForFilePath;
	
	NSMutableArray *thisDateTable;
	NSMutableArray *viewControllers;
	
	UIImageView *emptyDiaryImage;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UITableView *dateTableView;
@property(nonatomic,retain) UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableArray *viewControllers;
@property(nonatomic,retain) ReflectionTableManager *tableManager;
@property(nonatomic,retain) NSMutableDictionary *dateToPageDict;
@property(nonatomic,retain) NSMutableArray *thisDateTable;
@property(nonatomic,retain) HistoryReflectionViewController *histRefViewCont;
@property(nonatomic,retain) IBOutlet UIImageView* emptyDiaryImage;
@property(nonatomic,retain) NSMutableDictionary *imagesForFilePath;

-(void)loadScrollViewWithPage:(int)page;

-(NSMutableArray*)getColorsForPage:(int)page;
@end

//
//  Screen3ViewController.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reflection.h"
#import "ReflectColorView.h"
#import "ReflectCameraView.h"
#import "ReflectTextView.h"

@interface Screen3ViewController : UIViewController {

	IBOutlet UIView *reflectView;
	IBOutlet UIButton *textButton;
	IBOutlet UIButton *cameraButton;
	IBOutlet UIButton *colorButton;
	IBOutlet UIBarItem *saveButton;
	IBOutlet UIBarItem *backButton;
	IBOutlet ReflectColorView *colorView;
	IBOutlet ReflectCameraView *cameraView;
	IBOutlet UITextView *textView;
	
}

-(void)storeReflection:(Reflection *)r;

@property(nonatomic,retain) UIView *reflectView;
@property(nonatomic,retain) UIButton *textButton;
@property(nonatomic,retain) UIButton *cameraButton;
@property(nonatomic,retain) UIButton *colorButton;
@property(nonatomic,retain) UIBarItem *saveButton;
@property(nonatomic,retain) UIBarItem *backButton;
@property(nonatomic,retain) ReflectColorView *colorView;
@property(nonatomic,retain) ReflectCameraView *cameraView;
@property(nonatomic,retain) UITextView *textView;

-(IBAction)goToText:(id)sender;

-(IBAction)changeColor:(id)sender;
	

-(IBAction)goToCamera:(id)sender;
	

-(IBAction)goToColor:(id)sender;
	
-(IBAction)goBack:(id)sender;

@end

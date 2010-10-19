//
//  Reflection.h
//  goslowtest2
//
//  Created by Gregory Thomas on 10/18/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Reflection : NSManagedObject {

}

@property (nonatomic,retain) NSString *reflectionPicturePath;
@property (nonatomic) int colorDayRed;
@property (nonatomic) int colorDayGreen;
@property (nonatomic) int colorDayBlue;
@property (nonatomic,retain) NSString *reflectionText;
@property (nonatomic,retain) NSDate *timeStamp;
@end

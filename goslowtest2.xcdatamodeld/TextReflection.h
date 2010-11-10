//
//  TextReflection.h
//  goslowtest2
//
//  Created by Kevin Tse on 10/27/10.
//  Copyright 2010 Cornell University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TextReflection : NSManagedObject {
	
}

@property (nonatomic,retain) NSString *reflectionText;
@property (nonatomic,retain) NSDate *createdAt;
@end
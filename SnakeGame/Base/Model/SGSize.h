//
//  SGSize.h
//  SnakeGame
//
//  Created by wei on 2018/10/19.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGPoint.h"

/**
 Represent SnakeGame's size
 */
@interface SGSize : NSObject

/**
 width
 */
@property (assign , nonatomic) NSInteger width;

/**
 height
 */
@property (assign , nonatomic) NSInteger height;

/**
 init with width and height

 @param width width
 @param height height
 @return size
 */
- (instancetype)initWithWidth:(NSInteger)width AndHeight: (NSInteger)height;

/**
 return YES if SGPoint over the bounds
 
 @param point SGPoint
 @return bool
 */
- (BOOL)isOverBound:(SGPoint*)point;

@end

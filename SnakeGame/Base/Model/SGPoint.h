//
//  SGPoint.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represent SnakeGame's point
 */
@interface SGPoint : NSObject

/**
 x
 */
@property (assign , nonatomic) NSInteger x;

/**
 y
 */
@property (assign , nonatomic) NSInteger y;

/**
 init

 @param x x
 @param y y
 @return SGPoint
 */
- (instancetype)initWithX:(NSInteger)x AndY: (NSInteger)y;

/**
 return YES if self is equal to point

 @param point point
 @return boolean
 */
- (BOOL)isEqualSGPoint:(SGPoint*)point;

@end

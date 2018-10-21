//
//  SnakeModel.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGPoint.h"
#import "SGSpaceItem.h"

typedef enum : NSUInteger {
    SnakeDirectionLeft = 0,
    SnakeDirectionRight,
    SnakeDirectionUp,
    SnakeDirectionDown
} SnakeDirection;

/**
 snake model
 */
@interface SnakeModel : NSObject

/**
 bodyItem
 */
@property (strong, nonatomic) NSMutableArray<SGSpaceItem*>* bodyItems;

/**
 Length of snake's body
 */
@property (nonatomic, readonly) NSInteger snakeLength;

/**
 snake head
 */
@property (copy, readonly) SGSpaceItem *snakeHead;

/**
 Direction of snake
 */
@property (assign, nonatomic) SnakeDirection snakeDirection;


- (instancetype)initWithSGPoint:(SGPoint*)point andDirecetion:(SnakeDirection)direction;

/**
 Move to next Step
 */
- (void)moveToNextStep;

/**
 When snake ate food
 */
- (void)ateFood;

/**
 return YES if head crash into body

 @return YES or NO
 */
- (BOOL)isCrashOnSnakeBody;

/**
 return YES if snake head on point

 @param point SGPoint
 @return YES or NO
 */
- (BOOL)isHeadOnPoint:(SGPoint*)point;

/**
 return YES if point on sanke body or head

 @param point SGPoint
 @return YES or NO
 */
- (BOOL)isPointOnSnake:(SGPoint *)point;

@end



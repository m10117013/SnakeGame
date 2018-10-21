//
//  SpaceArea.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGSize.h"

@interface SGSpaceContext : NSObject

/**
 core graphics frame size
 */
@property (assign, nonatomic) CGSize viewSize;

/**
 game plot size
 */
@property (strong, nonatomic) SGSize *plotSize;

/**
 square width
 */
@property (assign, nonatomic) NSInteger squareWidth;

/**
 border Width
 */
@property (assign, nonatomic) CGFloat borderWidth;

/**
 border Height
 */
@property (assign, nonatomic) CGFloat borderHeight;


/**
    init

 @param size view's frame size
 @param GameSize expects game size
 @return SGSpaceContext
 */
- (instancetype)initWithFrameSize:(CGSize)size SGize:(SGSize*)GameSize;


/**
 Transfer game space point to CGPoint

 @param point game point
 @return cgpoint
 */
- (CGPoint)transferSGPointToFramePoint: (SGPoint*)point;

@end

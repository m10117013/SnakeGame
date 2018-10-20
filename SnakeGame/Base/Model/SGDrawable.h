//
//  Drawable.h
//  SnakeGame
//
//  Created by wei on 2018/10/17.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SGSpaceContext.h"

/**
 Snake game drawable protocol
 */
@protocol SGDrawable <NSObject>

/**
 Drawing on CGContextRef with SGSpaceContext

 @param context context
 @param spaceArea spaceArea
 */
- (void)drawInConent:(CGContextRef)context withSpace:(SGSpaceContext*)spaceArea;

@end


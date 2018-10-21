//
//  SnakeModel+Drawable.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SnakeModel+Drawable.h"
#import <UIKit/UIKit.h>

@implementation SnakeModel (Drawable)

- (void)drawInConent:(CGContextRef)context withSpace:(SGSpaceContext*)spaceArea {
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, spaceArea.squareWidth);
    for (SGSpaceItem *item in self.bodyItems) {
        CGPoint point = [spaceArea transferSGPointToFramePoint: item.location];
        CGContextMoveToPoint(context, point.x + spaceArea.squareWidth / 2, point.y);
        CGContextAddLineToPoint(context, point.x + spaceArea.squareWidth / 2, point.y + spaceArea.squareWidth);
    }
}

@end

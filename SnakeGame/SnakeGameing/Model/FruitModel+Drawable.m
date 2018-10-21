//
//  FruitModel+Drawable.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "FruitModel+Drawable.h"

@implementation FruitModel (Drawable)

- (void)drawInConent:(CGContextRef)context withSpace:(SGSpaceContext*)spaceArea {
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, spaceArea.squareWidth);
    CGPoint point = [spaceArea transferSGPointToFramePoint: self.item.location];
    CGContextMoveToPoint(context, point.x + spaceArea.squareWidth/2, point.y);
    CGContextAddLineToPoint(context, point.x + spaceArea.squareWidth/2, point.y + spaceArea.squareWidth);
}

@end

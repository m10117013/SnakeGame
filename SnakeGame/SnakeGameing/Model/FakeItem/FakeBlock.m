//
//  FakeBlock.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "FakeBlock.h"
#import "SGPoint.h"

@implementation FakeBlock

- (void)drawInConent:(CGContextRef)context withSpace:(SGSpaceContext*)spaceArea {
    
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    
    CGContextSetLineWidth(context, spaceArea.squareWidth);

    CGPoint point = [spaceArea transferSGPointToFramePoint: self.location];
    CGContextMoveToPoint(context, point.x + spaceArea.squareWidth / 2, point.y);
    CGContextAddLineToPoint(context, point.x + spaceArea.squareWidth / 2, point.y + spaceArea.squareWidth);
}
@end

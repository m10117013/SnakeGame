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
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, spaceArea.preBlock);

    CGPoint point = [spaceArea transferSGPointToAeraPlotPoint: self.location];
    CGContextMoveToPoint(context, point.x + spaceArea.preBlock / 2, point.y);
    CGContextAddLineToPoint(context, point.x + spaceArea.preBlock / 2, point.y + spaceArea.preBlock);
}
@end

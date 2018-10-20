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
    
    CGContextSetLineWidth(context, spaceArea.preBlock);
    
    for (SpaceItem *item in self.bodyItems) {
        CGPoint point = [spaceArea transferSGPointToAeraPlotPoint: item.location];
        CGContextMoveToPoint(context, point.x + spaceArea.preBlock / 2, point.y);
        CGContextAddLineToPoint(context, point.x + spaceArea.preBlock / 2, point.y + spaceArea.preBlock);
    }
}

@end

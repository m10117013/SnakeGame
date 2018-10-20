//
//  SpaceArea.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SGSpaceContext.h"
#import "SGPoint.h"


@implementation SGSpaceContext

- (instancetype)initWithCGSize:(CGSize)size SGize:(SGSize*)GameSize
{
    self = [super init];
    if (self) {
        self.plotSize = GameSize;
        self.viewSize = size;
        self.preBlock = (NSInteger)(ceil(MIN((NSInteger)size.height / (GameSize.height + 1), (NSInteger)size.width / (GameSize.width + 1))));
        _borderWidth = (size.width - self.preBlock * (GameSize.width + 1)) / 2;
        _borderHeight = (size.height - self.preBlock * (GameSize.height + 1)) / 2;
    }
    return self;
}

- (CGPoint)transferSGPointToAeraPlotPoint: (SGPoint*)point {
    CGFloat width = (point.x * self.preBlock) +  self.borderWidth;
    CGFloat height = (point.y * self.preBlock) +  self.borderHeight;
    return CGPointMake(width, height);
}

@end

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

- (instancetype)initWithFrameSize:(CGSize)size SGize:(SGSize*)GameSize
{
    self = [super init];
    if (self) {
        self.plotSize = GameSize;
        self.viewSize = size;
        self.squareWidth = (NSInteger)(ceil(MIN((NSInteger)size.height / GameSize.height, (NSInteger)size.width / GameSize.width)));
        _borderWidth = (size.width - self.squareWidth * GameSize.width) / 2;
        _borderHeight = (size.height - self.squareWidth * GameSize.height) / 2;
    }
    return self;
}

- (void)setViewSize:(CGSize)size {
    _viewSize = size;
    SGSize *GameSize = self.plotSize;
    self.squareWidth = (NSInteger)(ceil(MIN((NSInteger)size.height / GameSize.height, (NSInteger)size.width / GameSize.width)));
    _borderWidth = (size.width - self.squareWidth * GameSize.width) / 2;
    _borderHeight = (size.height - self.squareWidth * GameSize.height) / 2;
}



- (CGPoint)transferSGPointToFramePoint: (SGPoint*)point {
    CGFloat width = (point.x * self.squareWidth) +  self.borderWidth;
    CGFloat height = (point.y * self.squareWidth) +  self.borderHeight;
    return CGPointMake(width, height);
}

@end

//
//  SGSize.m
//  SnakeGame
//
//  Created by wei on 2018/10/19.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SGSize.h"

@implementation SGSize

- (instancetype)initWithWidth:(NSInteger)width AndHeight: (NSInteger)height {
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
    }
    return self;
}

- (BOOL)isOverBound:(SGPoint*)point {
    return (point.x < 0) | (point.x > self.width) | (point.y < 0) | (point.y > self.height);
}

@end

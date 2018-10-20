//
//  spaceItem.m
//  SnakeGame
//
//  Created by wei on 2018/10/17.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SpaceItem.h"

@implementation SpaceItem

- (instancetype)initWithLocation: (SGPoint*)location {
    self = [super init];
    if (self) {
        self.location = location;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    SpaceItem *item = [[[self class] allocWithZone:zone] init];
    item.location = [self.location copy];
    return item;
}

@end

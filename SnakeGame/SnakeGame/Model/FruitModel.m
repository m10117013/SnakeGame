//
//  FruitModel.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "FruitModel.h"

@implementation FruitModel

- (instancetype)initWithLocation:(SGPoint *)location {
    self = [super init];
    if (self) {
        self.item = [[SpaceItem alloc] initWithLocation:location];
    }
    return self;
}

- (NSInteger)score {
    return 10;
}

@end

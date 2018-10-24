//
//  SGPoint.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SGPoint.h"

@implementation SGPoint

- (instancetype)initWithX: (NSInteger)x AndY: (NSInteger)y {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    SGPoint *locatino = [[[self class] allocWithZone:zone] init];
    locatino.x = self.x;
    locatino.y = self.y;
    return locatino;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass: [SGPoint class]]) {
        return self.x == ((SGPoint*)object).x && self.y == ((SGPoint*)object).y;
    }
    return false;
}

- (BOOL)isEqualSGPoint:(SGPoint*)location {
     return self.x == location.x && self.y == location.y;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"SGPoint x:%ld y:%ld", self.x , self.y];
}

- (NSUInteger)hash {
    //( y << 16 ) ^ x;
    NSUInteger x = self.x;
    NSUInteger y = self.y;
    return (y << 16) ^ x;
}

@end


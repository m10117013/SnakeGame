//
//  SnakeModel.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SnakeModel.h"
#import "SpaceItem.h"

@interface SnakeModel()

@property (assign, nonatomic) BOOL isCrashOnBody;

@property (copy, nonatomic) SpaceItem *tailShade;

@end

@implementation SnakeModel

- (instancetype)init {
    return [self initWithSGPoint:[[SGPoint alloc] initWithX:0 AndY:0] andDirecetion:SnakeDirectionRight];
}

- (instancetype)initWithSGPoint:(SGPoint*)point andDirecetion:(SnakeDirection)direction{
    self = [super init];
    if (self) {
        //default direction
        self.snakeDirection = direction;
        self.bodyItems = [NSMutableArray new];
        //firstBlock
        [self.bodyItems addObject:[[SpaceItem alloc] initWithLocation:point]];
    }
    return self;
}

#pragma mark - public method

- (NSInteger)snakeLength {
    if (self.bodyItems && self.bodyItems.count > 0) {
        return self.bodyItems.count;
    }
    return 0;
}

- (SpaceItem *)snakeHead {
    if (self.bodyItems && self.bodyItems.count > 0) {
        return [self.bodyItems.lastObject copy];
    }
    return nil;
}

- (void)moveToNextStep {
    SpaceItem *newHead = [self snakeHead];
    switch (self.snakeDirection) {
        case SnakeDirectionLeft:
            newHead.location.x -= 1;
            break;
        case SnakeDirectionRight:
            newHead.location.x += 1;
            break;
        case SnakeDirectionUp:
            newHead.location.y -= 1;
            break;
        case SnakeDirectionDown:
            newHead.location.y += 1;
            break;
        default:
            NSAssert(false , @"error unexpect direction");
            break;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.bodyItems enumerateObjectsUsingBlock:^(SpaceItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.location isEqual:newHead.location]) {
            *stop = true;
            weakSelf.isCrashOnBody = true;
        }
    }];
    [self.bodyItems addObject:newHead];

    self.tailShade = [self.bodyItems objectAtIndex:0];
    //remive tail
    [self.bodyItems removeObjectAtIndex:0];
}

- (void)ateFood {
    if (self.tailShade) {
        [self.bodyItems insertObject:self.tailShade atIndex:0];
        self.tailShade = nil;
    }
}

- (BOOL)isCrashOnSnakeBody {
    __block BOOL returnVal = NO;
    [self.bodyItems enumerateObjectsUsingBlock:^(SpaceItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != self.bodyItems.lastObject) {
            if ([obj.location isEqual:self.bodyItems.lastObject.location]) {
                returnVal = YES;
            }
        }
    }];
    return returnVal;
}

- (BOOL)isHeadOnPoint:(SGPoint *)location {
    SpaceItem* item = self.bodyItems.lastObject;
    return [item.location isEqual:location];
}

- (BOOL)isPointOnSnake:(SGPoint *)location {
    __block BOOL returnVal = NO;
    [self.bodyItems enumerateObjectsUsingBlock:^(SpaceItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.location isEqual:location]) {
            returnVal = YES;
        }
    }];
    return returnVal;
}

@end

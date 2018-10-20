//
//  FruitModel.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpaceItem.h"

@interface FruitModel : NSObject

@property (strong, nonatomic) SpaceItem* item;

@property (readonly, nonatomic) NSInteger score;

- (instancetype)initWithLocation:(SGPoint *)location;


@end

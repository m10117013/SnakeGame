//
//  spaceItem.h
//  SnakeGame
//
//  Created by wei on 2018/10/17.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGPoint.h"

/**
 This model use for minimal space in lattice.
 */
@interface SGSpaceItem : NSObject

/**
 The position in lattice.
 */
@property (copy , nonatomic) SGPoint* location;

- (instancetype)initWithLocation: (SGPoint*)location;

@end

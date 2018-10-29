//
//  FakeBlock.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGDrawable.h"
#import "SGSpaceItem.h"

@interface FakeBlock : SGSpaceItem <SGDrawable>

@property (copy, nonatomic) UIColor *color;

@end


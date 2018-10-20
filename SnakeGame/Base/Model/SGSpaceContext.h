//
//  SpaceArea.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGSize.h"

@interface SGSpaceContext : NSObject

@property (assign, nonatomic) CGSize viewSize;

@property (strong, nonatomic) SGSize *plotSize;

@property (assign, nonatomic) NSInteger preBlock;

@property (assign, nonatomic) CGFloat borderWidth;

@property (assign, nonatomic) CGFloat borderHeight;

- (instancetype)initWithCGSize:(CGSize)size SGize:(SGSize*)GameSize;

- (CGPoint)transferSGPointToAeraPlotPoint: (SGPoint*)point;

@end

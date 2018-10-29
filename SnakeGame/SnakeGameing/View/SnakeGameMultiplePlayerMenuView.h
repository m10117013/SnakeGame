//
//  SnakeGameMultiplePlayerMenuView.h
//  SnakeGame
//
//  Created by wei on 2018/10/24.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnakeGameMenuView.h"

@interface SnakeGameMultiplePlayerMenuView : SnakeGameMenuView

@property (assign, nonatomic) BOOL isHost;

@property (strong, nonatomic) UILabel* waitPerson;

@property (strong, nonatomic) UILabel *yourSnakeColor;

@end


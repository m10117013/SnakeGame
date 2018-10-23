//
//  SinglePlayerSnakeGameViewController.h
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnakeGameBoardView.h"

@interface SinglePlayerSnakeGameViewController : UIViewController

/**
 snake game view
 */
@property (strong, nonatomic) SnakeGameBoardView *snakeGameView;


/**
 space context
 */
@property (strong, nonatomic) SGSpaceContext *spaceContext;

@end

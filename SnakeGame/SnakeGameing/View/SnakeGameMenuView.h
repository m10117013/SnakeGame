//
//  SnakeGameMenuView.h
//  SnakeGame
//
//  Created by wei on 2018/10/20.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIkit.h>

@class SnakeGameMenuView;

@protocol SnakeGameMenuViewDelegate <NSObject>

/**
 When start button was clicked.

 @param snakeGameMenuView snakeGameMenuView
 @param button button
 */
- (void)onSnakeGameMenuView:(SnakeGameMenuView *)snakeGameMenuView didClickStartButton:(UIButton *)button;

@end


@interface SnakeGameMenuView : UIView

/**
 start button
 */
@property (strong, nonatomic) UIButton *startButton;

/**
 delegate
 */
@property (weak, nonatomic) id<SnakeGameMenuViewDelegate> delegate;
@end


//
//  ScoreBoardView.h
//  SnakeGame
//
//  Created by wei on 2018/10/19.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScoreBoardView;

/**
 Game Over View
  This view use for when player lose game.
  Display score , Restart button
 */
@protocol ScoreBoardViewDelegate <NSObject>

/**
 When user clicked restart button.

 @param scoreBoardView scoreBoardView
 @param button restart button
 */
- (void)onScoreBoardView:(ScoreBoardView *)scoreBoardView didClickRestartButton:(UIButton *)button;

@end

@interface ScoreBoardView : UIView

/**
 UI delegate
 */
@property (weak, nonatomic) id<ScoreBoardViewDelegate> delegate;


/**
 set score

 @param score score
 */
- (void)setScore:(NSInteger)score;

@end



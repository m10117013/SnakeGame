//
//  ScoreMultiplePlayerBoardView.h
//  SnakeGame
//
//  Created by wei on 2018/10/24.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreBoardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScoreMultiplePlayerBoardView : ScoreBoardView

- (void)setScores:(NSArray *)scores;

@end

NS_ASSUME_NONNULL_END

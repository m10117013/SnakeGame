//
//  SnakeGameBoardView.h
//  SnakeGame
//
//  Created by wei on 2018/10/17.
//  Copyright © 2018 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGDrawable.h"
#import "SGSpaceContext.h"

@class SnakeGameBoardView;
/**
 pannig direction

 - UIPanGestureRecognizerDirectionUndefined: unknow event
 - UIPanGestureRecognizerDirectionUp: up event
 - UIPanGestureRecognizerDirectionDown: down event
 - UIPanGestureRecognizerDirectionLeft: left event
 - UIPanGestureRecognizerDirectionRight: right event
 */
typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
    UIPanGestureRecognizerDirectionUndefined,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
    UIPanGestureRecognizerDirectionLeft,
    UIPanGestureRecognizerDirectionRight
};

/**
 UI delegate of SnakeGameBoard
 */
@protocol SnakeGameBoardViewDelegate <NSObject>

/**
  SnakeGameBoard panning event

 @param view SnakeGameBoard
 @param direction panning direction
 */
- (void)onSnakeGameBoardView:(SnakeGameBoardView *)view didPanningWithDirction: (UIPanGestureRecognizerDirection)direction;

@end

/**
 Data source of SnakeGameBoard
 */
@protocol SnakeGameBoardViewDataSource <NSObject>

- (NSArray<id<SGDrawable>>*)drawableItemsForView:(SnakeGameBoardView*)view;

@end

/**
 The SnakeGame's board , use for drawing game.
 */
@interface SnakeGameBoardView : UIView


/**
 init with spaceContext

 @param spaceContext spaceContext
 @return view
 */
- (instancetype)initWithSpaceContex:(SGSpaceContext *)spaceContext;

/**
 refresh views
 */
- (void)refreshViews;


/**
 space context
 */
@property (strong, nonatomic) SGSpaceContext* spaceContext;

/**
 UI delegate
 */
@property (weak, nonatomic) id<SnakeGameBoardViewDelegate> delegate;

/**
 Data source delegate
 */
@property (weak, nonatomic) id<SnakeGameBoardViewDataSource>
dataSource;

/**
 Setup view's gesture
 */
- (void)setupGesture;

@end



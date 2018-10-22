//
//  SinglePlayerSnakeGameViewController.m
//  SnakeGame
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SinglePlayerSnakeGameViewController.h"
#import "SGSpaceItem.h"
#import "SnakeGameBoardView.h"
#import "SnakeGameMenuView.h"
#import "ScoreBoardView.h"
#import "FakeBlock.h"
#import "SnakeModel.h"
#import "FruitModel.h"
#import "SnakeModel+Drawable.h"
#import "FruitModel+Drawable.h"

//// default game plot width
const NSInteger kDefaultGameBoardWidth = 10;
/// default game plot height
const NSInteger kDefaultGameBoardHeight = 10;
/// default game timer
const CGFloat kDefaultTimer = 0.3;

const BOOL kFullScreen = true;

@interface SinglePlayerSnakeGameViewController () <SnakeGameMenuViewDelegate, SnakeGameBoardViewDelegate,SnakeGameBoardViewDataSource , ScoreBoardViewDelegate>

/**
 game's timer
 */
@property (strong, nonatomic) NSTimer *gameTimer;

/**
 score
 */
@property (assign, nonatomic) NSInteger score;
/**
 snake object
 */
@property (strong, nonatomic) SnakeModel *snake;

/**
 fruit object
 */
@property (strong, nonatomic) FruitModel *fruit;


/**
 To prevent snake double turn in one step
 */
@property (assign, nonatomic) BOOL lockStep;

/**
 space context
 */
@property (strong, nonatomic) SGSpaceContext *spaceContext;

#pragma mark views
/**
 snake game view
 */
@property (strong, nonatomic) SnakeGameBoardView *snakeGameView;

/**
 score view
 */
@property (strong, nonatomic) ScoreBoardView *scoreBoardView;

/**
 menu view
 */
@property (strong, nonatomic) SnakeGameMenuView *menuView;

@end

@implementation SinglePlayerSnakeGameViewController

#pragma mark - getter and setter

- (SnakeGameBoardView *)snakeGameView {
    if (!_snakeGameView) {
        _snakeGameView = [[SnakeGameBoardView alloc] initWithSpaceContex:self.spaceContext];
        _snakeGameView.delegate = self;
        _snakeGameView.dataSource = self;
        [_snakeGameView setupGesture];
    }
    return _snakeGameView;
}

- (SGSpaceContext *)spaceContext {
    if (!_spaceContext) {
        SGSpaceContext* space;
        if (kFullScreen) {
        CGFloat w = self.view.bounds.size.width / 10;
        CGFloat h = self.view.bounds.size.height / 10;
            space = [[SGSpaceContext alloc] initWithFrameSize:self.view.bounds.size SGize:[[SGSize alloc] initWithWidth:w AndHeight:h]];
        
        } else {
            space = [[SGSpaceContext alloc] initWithFrameSize:self.view.bounds.size SGize:[[SGSize alloc] initWithWidth:kDefaultGameBoardWidth AndHeight:kDefaultGameBoardHeight]];
        }
        _spaceContext = space;
    }
    return _spaceContext;
}

- (SnakeModel *)snake {
    if (!_snake) {
        _snake = [[SnakeModel alloc] init];
        _snake.snakeDirection = SnakeDirectionRight;
    }
    return _snake;
}

- (SnakeGameMenuView *)menuView {
    if (!_menuView) {
        SnakeGameMenuView *gameMenuView = [[SnakeGameMenuView alloc] initWithFrame:CGRectZero];
        gameMenuView.delegate = self;
        gameMenuView.hidden = YES;
        gameMenuView.alpha = 0;
        _menuView = gameMenuView;
    }
    
    return _menuView;
}

- (ScoreBoardView *)scoreBoardView {
    if (!_scoreBoardView) {
        ScoreBoardView *view = [[ScoreBoardView alloc] initWithFrame:CGRectZero];
        view.delegate = self;
        _scoreBoardView = view;
    }
    return _scoreBoardView;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showMenu];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.gameTimer invalidate];
}

#pragma mark -

- (void)setupViews {
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.snakeGameView];
    [self.snakeGameView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(weakSelf.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(weakSelf.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.top.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
        }
        
    }];
}

///start game
- (void)startGame {
    if (_gameTimer.isValid)
        [_gameTimer invalidate];
    
    self.snake = [[SnakeModel alloc] initWithSGPoint: [[SGPoint alloc]initWithX:0 AndY:0] andDirecetion:SnakeDirectionRight];
    self.score = 0;
    self.fruit = [self allocateNewFruitModel];
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)kDefaultTimer target:self selector:@selector(moveOneStep) userInfo:nil repeats:YES];
    [_gameTimer fire];
}

///move one step
- (void)moveOneStep {
    //moveNextStep
    [self.snake moveToNextStep];
    if ([self.snake isHeadOnPoint:self.fruit.item.location]) {
        [self.snake ateFood];
        self.score += self.fruit.score;
        FruitModel *fruit = [self allocateNewFruitModel];
        self.fruit = fruit;
    }
    
    //if over bounds or crash in body
    BOOL over = [self.spaceContext.plotSize isOverBound:self.snake.snakeHead.location];
    if (self.snake.isCrashOnSnakeBody || over) {
        [self gameOver];
    }
    
    self.lockStep = false;
    [self.snakeGameView refreshViews];
}

// random allocate fruit in game
- (FruitModel *)allocateNewFruitModel {
    FruitModel *foodModel;
    
    NSInteger blockCount = self.spaceContext.plotSize.width * self.spaceContext.plotSize.height;
    NSMutableSet<SGPoint*> *usedSet = [[NSMutableSet alloc] init] ;
    BOOL notfound = YES;
    while (notfound) {
        int valueX = arc4random() % (self.spaceContext.plotSize.width);
        int valueY = arc4random() % (self.spaceContext.plotSize.height);
        SGPoint *point = [[SGPoint alloc] initWithX:valueX AndY:valueY];
        
        if ([usedSet containsObject:point])
            continue;
        
        if (![self.snake isPointOnSnake:point] && ![point isEqual:self.fruit.item.location]) {
            foodModel = [[FruitModel alloc] initWithLocation:point];
            notfound = NO;
        }
        
        [usedSet addObject:point];
        if (usedSet.count == blockCount) {
             notfound = NO;
            [self gameOver];
        }
        
    }
    return foodModel;
}

- (void)gameOver {
    [self.gameTimer invalidate];
    [self showGameOver];
}

- (void)showMenu {
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@100);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    [self.menuView setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.menuView.alpha = 1;
        [self.view setNeedsLayout];
    }];
}

- (void)showGameOver {
    __weak typeof(self) weakSelf = self;
    [self.view addSubview: self.scoreBoardView];
    [self.scoreBoardView setScore:self.score];
    self.scoreBoardView.alpha = 0;
    [self.scoreBoardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.height.equalTo(@200);
        make.width.equalTo(@200);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scoreBoardView.alpha = 1;
        [self.view setNeedsLayout];
    }];
}

#pragma mark - SnakeGameBoard delegate

- (void)onSnakeGameBoardView:(SnakeGameBoardView *)view didPanningWithDirction: (UIPanGestureRecognizerDirection)direction {
    
    if (self.lockStep) {
        //snake havn't move yet, reject action
        return;
    }
    
    SnakeDirection newDirection = SnakeDirectionLeft;
    switch (direction) {
        case UIPanGestureRecognizerDirectionLeft:
            newDirection = SnakeDirectionLeft;
            break;
        case UIPanGestureRecognizerDirectionRight:
            newDirection = SnakeDirectionRight;
            break;
        case UIPanGestureRecognizerDirectionUp:
            newDirection = SnakeDirectionUp;
            break;
        case UIPanGestureRecognizerDirectionDown:
            newDirection = SnakeDirectionDown;
            break;
        default:
            break;
    }
    //should be 90 degree conrner
    if ((newDirection == SnakeDirectionUp && self.snake.snakeDirection == SnakeDirectionDown)
        || (newDirection == SnakeDirectionDown && self.snake.snakeDirection == SnakeDirectionUp)
        || (newDirection == SnakeDirectionLeft && self.snake.snakeDirection == SnakeDirectionRight)
        || (newDirection == SnakeDirectionRight && self.snake.snakeDirection == SnakeDirectionLeft)
        ) {
        return;
    }
    
    
    self.lockStep = true;
    [self.snake setSnakeDirection:newDirection];
}

#pragma mark - SnakeGameBoardView data source

- (NSArray<id<SGDrawable>> *)drawableItemsForView:(SnakeGameBoardView *)view {
    if (self.gameTimer.isValid) {
//        FakeBlock *fake = [[FakeBlock alloc] init];
//        fake.location = [[SGPoint alloc] initWithX:0 AndY:0];
//
//        FakeBlock *fake1 = [[FakeBlock alloc] init];
//        fake1.location = [[SGPoint alloc] initWithX:0 AndY:10];
//
//        FakeBlock *fake2 = [[FakeBlock alloc] init];
//        fake2.location = [[SGPoint alloc] initWithX:10 AndY:0];
//
//        FakeBlock *fake3 = [[FakeBlock alloc] init];
//        fake3.location = [[SGPoint alloc] initWithX:10 AndY:10];
        return @[self.snake,self.fruit];
    }
    return nil;
}



#pragma mark - ScoreBoardView delegate

- (void)onScoreBoardView:(ScoreBoardView *)scoreBoardView didClickRestartButton:(UIButton *)button {
    [scoreBoardView removeFromSuperview];
    [self startGame];
}


#pragma mark - SnakeGameMenuView delegate

- (void)onSnakeGameMenuView:(SnakeGameMenuView *)snakeGameMenuView didClickStartButton:(UIButton *)button {
        [snakeGameMenuView removeFromSuperview];
        [self startGame];
}

@end

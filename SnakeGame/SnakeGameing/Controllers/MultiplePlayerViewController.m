//
//  MultiplePlayerViewController.m
//  SnakeGame
//
//  Created by 金融研發一部-柯昊瑋 on 2018/10/23.
//  Copyright © 2018 wei. All rights reserved.
//

#import "MultiplePlayerViewController.h"

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
#import "UIColor+HexString.h"
#import "ScoreMultiplePlayerBoardView.h"

@import SocketIO;


@interface MultiplePlayerViewController () <SnakeGameMenuViewDelegate , ScoreBoardViewDelegate>

@property (strong, nonatomic) SocketIOClient* socket;

@property (strong, nonatomic) SocketManager* manager;

@property (strong, nonatomic) NSArray<FakeBlock*>* items;

@property (copy, nonatomic) NSString *snakeID;

@property (copy, nonatomic) UIColor *snakeColor;

@property (assign, nonatomic) BOOL isHost;

@property (strong, nonatomic) ScoreMultiplePlayerBoardView *scoresBoardView;

/**
 menu view
 */
@property (strong, nonatomic) SnakeGameMultiplePlayerMenuView *hostMenuView;

@end

@implementation MultiplePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://127.0.0.1:8088"];
    self.manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @NO, @"compress": @YES}];
    SocketIOClient* socket = self.manager.defaultSocket;
    self.socket = socket;
    [self addHandlers];
    [socket connect];
}

- (SnakeGameMultiplePlayerMenuView *)hostMenuView {
    if (!_hostMenuView) {
        SnakeGameMultiplePlayerMenuView *gameMenuView = [[SnakeGameMultiplePlayerMenuView alloc] initWithFrame:CGRectZero];
        gameMenuView.delegate = self;
        gameMenuView.hidden = YES;
        gameMenuView.alpha = 0;
        _hostMenuView = gameMenuView;
    }
    
    return _hostMenuView;
}



- (ScoreMultiplePlayerBoardView *)scoresBoardView {
    if (!_scoresBoardView) {
        ScoreMultiplePlayerBoardView *view = [[ScoreMultiplePlayerBoardView alloc] initWithFrame:CGRectZero];
        view.delegate = self;
        view.hidden = NO;
        view.alpha = 0;
        _scoresBoardView = view;
    }
    
    return _scoresBoardView;
}



- (void)addHandlers {
    __weak typeof(self) weakSelf = self;
    //server sataus
    [self.socket on:@"statusChange" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"%@",data[0]);
    }];
    
    [self.socket on:@"join" callback:^(NSArray* data, SocketAckEmitter* ack) {
        weakSelf.hostMenuView.waitPerson.text = [NSString stringWithFormat:@"房間人數 : %@",data[0][@"count"]];
    }];
    
    [self.socket on:@"host" callback:^(NSArray* data, SocketAckEmitter* ack) {
        self.isHost = true;
        [weakSelf showHostMenu];
    }];
    
    
    [self.socket on:@"player" callback:^(NSArray* data, SocketAckEmitter* ack) {
        self.isHost = false;
        [weakSelf showHostMenu];
    }];
    
    [self.socket on:@"leave" callback:^(NSArray* data, SocketAckEmitter* ack) {
    
    }];
    
    [self.socket on:@"start" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self.hostMenuView removeFromSuperview];
        [self.scoresBoardView removeFromSuperview];
    }];
    
    [self.socket on:@"roomFull" callback:^(NSArray* data, SocketAckEmitter* ack) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Room is full"
                                                                       message:@"This room is full."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        NSLog(@"FULL ROOM");
    }];
    
    [self.socket on:@"snakeID" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSString *ID = data[0][@"ID"];
        NSString *snakeColor = data[0][@"snakeColor"];
        self.snakeID = ID;
        self.snakeColor = [UIColor colorWithHexString:snakeColor];
        
        self.hostMenuView.yourSnakeColor.text =  [NSString stringWithFormat:@"Your ID is %@",ID];
        self.hostMenuView.yourSnakeColor.textColor = self.snakeColor;
    }];
    
    [self.socket on:@"gameingData" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSMutableArray<FakeBlock*> *fakeitems =  [NSMutableArray new];
        [data[0] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {\
            NSString *colorString = obj[@"color"];
            UIColor *color = [UIColor colorWithHexString:colorString];
            NSArray *nodes = obj[@"node"];
            [nodes enumerateObjectsUsingBlock:^(id  _Nonnull node, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *stringX = (NSString *)node[@"x"];
                NSString *stringY = (NSString *)node[@"y"];
                FakeBlock *fakeItem = [[FakeBlock alloc] initWithLocation: [[SGPoint alloc] initWithX:[stringX integerValue] AndY:[stringY integerValue]]];
                fakeItem.color = color;
                [fakeitems addObject: fakeItem];
            }];
        }];
        self.items = [fakeitems copy];
        [self.snakeGameView refreshViews];
    }];
    
    [self.socket on:@"gameover" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [data[0] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",[NSString stringWithFormat:@"snakeID %@",obj[@"snakeID"]]);
            NSLog(@"%@",[NSString stringWithFormat:@"score %@",obj[@"score"]]);
        }];
        
        [weakSelf showGameOver:data[0]];
    }];
    
    [self.socket on:@"eliminate" callback:^(NSArray* data, SocketAckEmitter* ack) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                       message:@"you lost."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        NSLog(@"lost game");
    }];
    
    [self.socket on:@"onAera" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSDictionary *json = (NSDictionary *)data[0];
        NSString *widthString = json[@"width"];
        NSString *heightString = json[@"height"];
        self.spaceContext = [[SGSpaceContext alloc] initWithFrameSize:self.view.bounds.size SGize: [[SGSize alloc] initWithWidth:[widthString integerValue] AndHeight:[heightString integerValue]]];
        self.snakeGameView.spaceContext = self.spaceContext;
    }];
}

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

- (void)showMenu {
    
}

- (void)showHostMenu {
    self.hostMenuView.isHost = self.isHost;
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.hostMenuView];
    [self.hostMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    [self.hostMenuView setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.hostMenuView.alpha = 1;
        [self.view setNeedsLayout];
    }];
}

- (void)showGameOver : (NSArray*) scores {
    __weak typeof(self) weakSelf = self;
    [self.view addSubview: self.scoresBoardView];
    [self.scoresBoardView setScores:scores];
    self.scoresBoardView.alpha = 0;
    [self.scoresBoardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.height.equalTo(@300);
        make.width.equalTo(@200);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scoresBoardView.alpha = 1;
        [self.view setNeedsLayout];
    }];
}

#pragma mark - SnakeGameBoardView data source

- (NSArray<id<SGDrawable>> *)drawableItemsForView:(SnakeGameBoardView *)view {
    return self.items;
}


#pragma mark - SnakeGameBoard delegate

- (void)onSnakeGameBoardView:(SnakeGameBoardView *)view didPanningWithDirction: (UIPanGestureRecognizerDirection)direction {
    
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
    
    [self.socket emit:@"move" with: @[@{@"direct" : @(newDirection)}]];
}

- (void)onSnakeGameMenuView:(SnakeGameMenuView *)snakeGameMenuView didClickStartButton:(UIButton *)button {
    [snakeGameMenuView removeFromSuperview];
    [self.socket emit:@"start" with: @[@"start"]];
}

- (void)onScoreBoardView:(ScoreBoardView *)scoreBoardView didClickRestartButton:(UIButton *)button {
    [scoreBoardView removeFromSuperview];
    [self showHostMenu];
}

@end

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

@import SocketIO;


@interface MultiplePlayerViewController ()

@property (strong, nonatomic) SocketIOClient* socket;

@property (strong, nonatomic) SocketManager* manager;

@property (strong, nonatomic) NSArray<FakeBlock*>* items;
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

- (void)addHandlers {
    
    //server sataus
    [self.socket on:@"statusChange" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"%@",data[0]);
    }];
    
    [self.socket on:@"news" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"zz");
    }];
    
    [self.socket on:@"join" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"zz");
    }];
    
    [self.socket on:@"host" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"i'm host");
    }];
    
    [self.socket on:@"leave" callback:^(NSArray* data, SocketAckEmitter* ack) {
    
    }];
    
    [self.socket on:@"start" callback:^(NSArray* data, SocketAckEmitter* ack) {
     
    }];
    
    [self.socket on:@"name" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
    }];
    
    [self.socket on:@"gameingData" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
        NSMutableArray<FakeBlock*> *fakeitems =  [NSMutableArray new];
        [data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger x = (NSString *)obj[@"location"][@"x"];
            NSInteger y = obj[@"location"][@"y"];
            [fakeitems addObject: [[FakeBlock alloc] initWithLocation: [[SGPoint alloc] initWithX:obj[@"location"][@"x"] AndY:obj[@"location"][@"y"]]]];
        }];
        
        self.items = [fakeitems copy];
        [self.snakeGameView refreshViews];
    }];
    
    [self.socket on:@"gameover" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
    }];
    
    [self.socket on:@"onAera" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSDictionary *json = (NSDictionary *)data[0];
        self.spaceContext = [[SGSpaceContext alloc] initWithFrameSize:self.view.bounds.size SGize: [[SGSize alloc] initWithWidth:json[@"width"] AndHeight:json[@"height"]]];
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


@end

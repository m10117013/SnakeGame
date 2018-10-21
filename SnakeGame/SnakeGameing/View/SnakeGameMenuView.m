//
//  SnakeGameMenuView.m
//  SnakeGame
//
//  Created by wei on 2018/10/20.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SnakeGameMenuView.h"
#import <Masonry/Masonry.h>

@interface SnakeGameMenuView()

/**
 start button
 */
@property (strong, nonatomic) UIButton *startButton;


@end


@implementation SnakeGameMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    __weak typeof(self) weakSelf = self;
    
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 4;
    self.layer.cornerRadius = 10;
    
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
}

- (UIButton *)startButton {
    if (!_startButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button addTarget:self action:@selector(onStartButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"START" forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.layer.borderWidth = 1;
        _startButton = button;
    }
    return _startButton;
}


#pragma mark - Button event delegate
    
- (void)onStartButtonClicked:(UIButton*)sender {
    if ([self.delegate respondsToSelector:@selector(onSnakeGameMenuView:didClickStartButton:)]) {
        [self.delegate onSnakeGameMenuView:self didClickStartButton:sender];
    }
}
    
@end

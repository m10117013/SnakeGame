//
//  ScoreMultiplePlayerBoardView.m
//  SnakeGame
//
//  Created by wei on 2018/10/24.
//  Copyright © 2018 wei. All rights reserved.
//

#import "ScoreMultiplePlayerBoardView.h"
#import <Masonry/Masonry.h>
#import "ScoreMultiplePlayerBoardView.h"


@interface ScoreMultiplePlayerBoardView()

/**
 restartButton
 */
@property (strong, nonatomic) UIButton *restartButton;


/**
 scoreLabel
 */
@property (strong, nonatomic) UITextView *scoreLabel;

/**
 title Label
 */
@property (strong, nonatomic) UILabel* titleLabel;

@end

@implementation ScoreMultiplePlayerBoardView

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
    
    [self addSubview:self.scoreLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.restartButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@150);
    }];
    
    [self.restartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.scoreLabel.mas_bottom).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@44);
    }];
}

- (UITextView *)scoreLabel {
    if (!_scoreLabel) {
        UITextView *label = [[UITextView alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor yellowColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColor.clearColor;
        _scoreLabel = label;
    }
    return _scoreLabel;
}

- (UIButton *)restartButton {
    if (!_restartButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button addTarget:self action:@selector(onRestartButtonDidClick:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"OK" forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 10;
        _restartButton = button;
    }
    return  _restartButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"GAME OVER";
        label.textColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.numberOfLines = 4;
        label.minimumScaleFactor = 0.5;
        label.font = [UIFont systemFontOfSize:23];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}


#pragma mark - public method

- (void)setScores:(NSArray *)scores {
    __block NSString *str = @"";
    [scores enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@ - %@\n",obj[@"snakeID"],obj[@"score"]]];
    }];
    self.scoreLabel.text = str;
}

#pragma mark - button click event

- (void)onRestartButtonDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(onScoreBoardView:didClickRestartButton:)]) {
        [self.delegate onScoreBoardView:self didClickRestartButton:sender];
    }
}
@end

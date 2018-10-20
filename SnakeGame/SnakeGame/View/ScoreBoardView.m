//
//  ScoreBoardView.m
//  SnakeGame
//
//  Created by wei on 2018/10/19.
//  Copyright © 2018 wei. All rights reserved.
//

#import "ScoreBoardView.h"
#import <Masonry/Masonry.h>

const NSString *kTitleColor = @"";

@interface ScoreBoardView()

/**
 restartButton
 */
@property (strong, nonatomic) UIButton *restartButton;

/**
 scoreLabel
 */
@property (strong, nonatomic) UILabel *scoreLabel;

/**
 title Label
 */
@property (strong, nonatomic) UILabel* titleLabel;

@end

@implementation ScoreBoardView

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
        make.height.equalTo(@44);
    }];
    
    [self.restartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.scoreLabel.mas_bottom).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@44);
    }];
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"0";
        label.textColor = [UIColor yellowColor];
        label.font = [UIFont systemFontOfSize:17];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.5;
        label.textAlignment = NSTextAlignmentCenter;
        _scoreLabel = label;
    }
    return _scoreLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"GAME OVER";
        label.textColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.5;
        label.font = [UIFont systemFontOfSize:23];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)restartButton {
    if (!_restartButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button addTarget:self action:@selector(onRestartButtonDidClick:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"RESTART" forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 10;
        _restartButton = button;
    }
    return  _restartButton;
}

#pragma mark - public method

- (void)setScore:(NSInteger)score {
    self.scoreLabel.text = [NSString stringWithFormat:@"YOUR SCORE : %ld",score];
}

#pragma mark - button click event

- (void)onRestartButtonDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(onScoreBoardView:didClickRestartButton:)]) {
        [self.delegate onScoreBoardView:self didClickRestartButton:sender];
    }
}
@end

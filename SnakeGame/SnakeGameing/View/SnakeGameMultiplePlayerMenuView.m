//
//  SnakeGameMultiplePlayerMenuView.m
//  SnakeGame
//
//  Created by wei on 2018/10/24.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SnakeGameMultiplePlayerMenuView.h"
#import <Masonry/Masonry.h>

@interface SnakeGameMultiplePlayerMenuView ()


@end

@implementation SnakeGameMultiplePlayerMenuView

- (UILabel *)waitPerson {
    if (!_waitPerson) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor whiteColor];
        label.text = @"房間人數 : ";
        label.textAlignment = NSTextAlignmentCenter;
        _waitPerson = label;
    }
    return _waitPerson;
}

- (UILabel *)yourSnakeColor {
    if (!_yourSnakeColor) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor whiteColor];
        label.text = @"your are snake";
        label.textAlignment = NSTextAlignmentCenter;
        _yourSnakeColor = label;
    }
    return _yourSnakeColor;
}

- (void)setupViews {
    __weak typeof(self) weakSelf = self;
    
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 4;
    self.layer.cornerRadius = 10;
    
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    
    [self addSubview:self.waitPerson];
    [self.waitPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.startButton.mas_bottom).offset(20);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
    }];
    
    [self addSubview:self.yourSnakeColor];
    [self.yourSnakeColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.waitPerson.mas_bottom).offset(20);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
    }];
}

- (void)setIsHost:(BOOL)isHost {
    _isHost = isHost;
    if (!isHost) {
        [self.startButton setHidden:YES];
        [self.startButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.waitPerson.text = @"等待房主開始";
    } else {
        [self.startButton setHidden:NO];
        [self.startButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
        }];
    }
}

@end

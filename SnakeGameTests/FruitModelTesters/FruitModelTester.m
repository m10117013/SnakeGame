//
//  FruitModelTester.m
//  SnakeGameTests
//
//  Created by wei on 2018/10/21.
//  Copyright © 2018 wei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "FruitModel.h"

///test base model
SpecBegin(FruitModelTester)

describe(@"Testing_FruitModel", ^{
    it(@"test fruit model", ^{
        SGPoint *point = [[SGPoint alloc] initWithX:10 AndY:20];
        FruitModel *model = [[FruitModel alloc] initWithLocation:point];
        expect(model.item.location).equal([point copy]);
        expect(model.score).beGreaterThan(0);
    });
});



SpecEnd

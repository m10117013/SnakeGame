//
//  SnakeModelTest.m
//  SnakeGameTests
//
//  Created by wei on 2018/10/18.
//  Copyright © 2018 wei. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "SnakeModel.h"

SpecBegin(SnakeModelTest)

///test snake model
describe(@"Testing_SnakeModel", ^{
   
    it(@"test snake moveing", ^{
        SGPoint *startPoint = [[SGPoint alloc] initWithX:2 AndY:0];
        SnakeModel *snake = [[SnakeModel alloc] initWithSGPoint:startPoint andDirecetion:SnakeDirectionLeft];
        //move left
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:1 AndY:0]);
        
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:0 AndY:0]);
        
        //move right
        [snake setSnakeDirection:SnakeDirectionRight];
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:1 AndY:0]);
        
        //move up
        [snake setSnakeDirection:SnakeDirectionUp];
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:1 AndY:-1]);
        
        //move down
        [snake setSnakeDirection:SnakeDirectionDown];
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:1 AndY:0]);
        
        [snake moveToNextStep];
        expect(snake.snakeHead.location).equal([[SGPoint alloc] initWithX:1 AndY:1]);
        
        expect([snake snakeLength]).equal(1);
    });
    
    it(@"test snake crash on body", ^{
        NSArray *snakeItems = @[[[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:1 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:2 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:3 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:3 AndY:1]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:2 AndY:1]]
                                ];
        SnakeModel *snake = [[SnakeModel alloc] init];
        snake.bodyItems = [snakeItems mutableCopy];
        [snake setSnakeDirection:SnakeDirectionUp];
        [snake moveToNextStep];
        expect([snake isCrashOnSnakeBody]).equal(YES);
    });
    
    
    it(@"test snake ate food", ^{
        NSArray *snakeItems = @[[[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:1 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:2 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:3 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:4 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:5 AndY:0]]
                                ];
        SnakeModel *snake = [[SnakeModel alloc] init];
        snake.bodyItems = [snakeItems mutableCopy];
        [snake setSnakeDirection:SnakeDirectionRight];
        [snake moveToNextStep];
        //ate food
        [snake ateFood];
        expect([snake snakeLength]).equal(6);
        expect(snake.bodyItems[0].location).equal([[SGPoint alloc] initWithX:1 AndY:0]);
    });
    
    
    it(@"test isHeadOnPoint", ^{
        NSArray *snakeItems = @[[[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:1 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:2 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:3 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:4 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:5 AndY:0]]
                                ];
        SnakeModel *snake = [[SnakeModel alloc] init];
        snake.bodyItems = [snakeItems mutableCopy];
        [snake setSnakeDirection:SnakeDirectionRight];
        [snake moveToNextStep];

        expect([snake isHeadOnPoint:[[SGPoint alloc] initWithX:6 AndY:0]]).equal(YES);
        expect([snake isHeadOnPoint:[[SGPoint alloc] initWithX:7 AndY:0]]).equal(NO);
        expect([snake isHeadOnPoint:[[SGPoint alloc] initWithX:6 AndY:1]]).equal(NO);
    });
    
    
    it(@"test isPointOnSnake", ^{
        NSArray *snakeItems = @[[[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:1 AndY:0]],
                                [[SGSpaceItem alloc] initWithLocation:[[SGPoint alloc] initWithX:2 AndY:0]]
                                ];
        SnakeModel *snake = [[SnakeModel alloc] init];
        snake.bodyItems = [snakeItems mutableCopy];
        
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:1 AndY:0]]).equal(YES);
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:2 AndY:0]]).equal(YES);
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:6 AndY:1]]).equal(NO);
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:6 AndY:0]]).equal(NO);
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:7 AndY:0]]).equal(NO);
        expect([snake isPointOnSnake:[[SGPoint alloc] initWithX:6 AndY:1]]).equal(NO);
    });

});

SpecEnd

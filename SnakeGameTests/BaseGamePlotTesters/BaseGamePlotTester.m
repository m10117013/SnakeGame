//
//  SpaceArea.m
//  SnakeGameTests
//
//  Created by wei on 2018/10/20.
//  Copyright © 2018 wei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "SGSpaceContext.h"

///test base model
SpecBegin(BaseGamePlotTester)

describe(@"Testing_SpaceArea", ^{
    
    it(@"test SGSize square width", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        CGSize size = CGSizeMake(320, 480);
        SGSpaceContext *space = [[SGSpaceContext alloc] initWithFrameSize:size SGize:sgSize];
        expect(space.squareWidth).equal(2);
    });
    
    
    it(@"test spaceContext transferSGPointToFramePoint", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        CGSize size = CGSizeMake(320, 480);
        SGSpaceContext *space = [[SGSpaceContext alloc] initWithFrameSize:size SGize:sgSize];
        expect(space.squareWidth).equal(2);
        SGPoint *point = [[SGPoint alloc] initWithX:100 AndY:200];
        expect([space transferSGPointToFramePoint:point]).equal(CGPointMake(260, 440));
    });
    
    
    
    it(@"test sgSize over bound", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        //This should in bounds
        SGPoint *point = [[SGPoint alloc] initWithX:99 AndY:199];
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:0 AndY:0];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:50 AndY:50];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:20 AndY:70];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:100 AndY:20];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:-1 AndY:20];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:99 AndY:-1];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:50 AndY:200];;
        expect([sgSize isOverBound:point]).equal(YES);
    });
    
    it(@"test point equal", ^{
        SGPoint *point = [[SGPoint alloc] initWithX:100 AndY:200];
        SGPoint *point2 = [[SGPoint alloc] initWithX:100 AndY:200];
        expect([point isEqual:point2]).equal(YES);
        expect([point isEqualSGPoint:point2]).equal(YES);
        
        //should not equal
        SGPoint *point3 = [[SGPoint alloc] initWithX:1 AndY:1];
        expect([point isEqual:point3]).equal(NO);
        expect([point isEqualSGPoint:point3]).equal(NO);
        
        //testing copy of point
        SGPoint *copyPoint = [point copy];
        expect([point isEqual:copyPoint]).equal(YES);
        expect([point isEqualSGPoint:copyPoint]).equal(YES);
        
        //testing object comparison
        NSObject *object = [[NSObject alloc] init];
        expect([point isEqual:object]).equal(NO);
    });
    
});

SpecEnd


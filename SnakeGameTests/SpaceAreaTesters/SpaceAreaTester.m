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
#import "SpaceAreaTester.m"
#import "SGSpaceContext.h"

SpecBegin(SpaceAreaTester)

describe(@"Testing_SpaceArea", ^{
    
    it(@"測試", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        CGSize size = CGSizeMake(320, 480);
        SGSpaceContext *space = [[SGSpaceContext alloc] initWithCGSize:size SGize:sgSize];
        expect(space.preBlock).equal(2);
    });
    
    
    it(@"測試", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        CGSize size = CGSizeMake(320, 480);
        SGSpaceContext *space = [[SGSpaceContext alloc] initWithCGSize:size SGize:sgSize];
        expect(space.preBlock).equal(2);
        SGPoint *point = [[SGPoint alloc] initWithX:100 AndY:200];
        expect([space transferSGPointToAeraPlotPoint:point]).equal(CGPointMake(259, 439));
    });
    
    
    
    it(@"test_point_over_bound", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        //This should in bounds
        SGPoint *point = [[SGPoint alloc] initWithX:100 AndY:200];
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:0 AndY:0];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:100 AndY:200];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:50 AndY:50];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should in bounds
        point = [[SGPoint alloc] initWithX:20 AndY:70];;
        expect([sgSize isOverBound:point]).equal(NO);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:101 AndY:20];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:-1 AndY:20];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:99 AndY:-1];;
        expect([sgSize isOverBound:point]).equal(YES);
        
        //This should out bounds
        point = [[SGPoint alloc] initWithX:50 AndY:201];;
        expect([sgSize isOverBound:point]).equal(YES);
    });
    
    it(@"test_point_equal", ^{
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
    
    it(@"測試", ^{
        SGSize *sgSize = [[SGSize alloc] initWithWidth:100 AndHeight:200];
        CGSize size = CGSizeMake(320, 480);
        SGSpaceContext *space = [[SGSpaceContext alloc] initWithCGSize:size SGize:sgSize];
        expect(space.preBlock).equal(2);
    });
    
    
});







SpecEnd


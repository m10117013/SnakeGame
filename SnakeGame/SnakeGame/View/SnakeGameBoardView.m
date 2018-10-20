//
//  SnakeGameBoardView.m
//  SnakeGame
//
//  Created by wei on 2018/10/17.
//  Copyright © 2018 wei. All rights reserved.
//

#import "SnakeGameBoardView.h"
#import "UIColor+HexString.h"

// default backguard color
static NSString* const kDefaultBackguardColor = @"000000";
// default backguard color
static NSString* const kDefaultBorderBackguardColor = @"FFFFFF";

@interface SnakeGameBoardView()

/**
 pan gesture
 */
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;

@end

@implementation SnakeGameBoardView

- (instancetype)initWithSpaceContex:(SGSpaceContext *)spaceContext {
    self = [super init];
    if (self) {
        self.spaceContext = spaceContext;
        self.backgroundColor = [UIColor colorWithHexString:kDefaultBackguardColor];
    }
    return self;
}

- (instancetype)init {
    return [self initWithSpaceContex:nil];
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _panGesture = panGesture;
    }
    return _panGesture;
}

- (void)setupGesture {
    [self addGestureRecognizer:self.panGesture];
}

- (void)refreshViews {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor colorWithHexString:kDefaultBorderBackguardColor];
    
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetLineWidth(context, self.spaceContext.borderWidth);
    CGContextMoveToPoint(context, self.spaceContext.borderWidth/2, 0);
    CGContextAddLineToPoint(context, self.spaceContext.borderWidth/2, self.frame.size.height);
    
    CGContextMoveToPoint(context, self.frame.size.width - self.spaceContext.borderWidth/2, 0);
    CGContextAddLineToPoint(context, self.frame.size.width - self.spaceContext.borderWidth/2, self.frame.size.height);
    
    CGContextStrokePath(context);
    CGContextSetLineWidth(context, self.spaceContext.borderHeight);
    CGContextMoveToPoint(context, 0, self.spaceContext.borderHeight/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.spaceContext.borderHeight/2);
    CGContextMoveToPoint(context, 0, self.frame.size.height - self.spaceContext.borderHeight/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - self.spaceContext.borderHeight/2);

    CGContextStrokePath(context);
    
    if ([self.dataSource respondsToSelector:@selector(drawableItemsForView:)]) {
        NSArray<id<SGDrawable>> *items = [self.dataSource drawableItemsForView:self];
        //draw something
        [items enumerateObjectsUsingBlock:^(id<SGDrawable> obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj drawInConent:context withSpace:self.spaceContext];
            CGContextStrokePath(context);
        }];
    } else {
//        NSAssert(false, @"Error dataSource did not implement drawableItemsForView");
    }
}

#pragma mark - Gesture Event handler

- (void)handleGesture:(UIPanGestureRecognizer*)sender {
        
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:self];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            if ([self.delegate respondsToSelector:@selector(onSnakeGameBoardView:didPanningWithDirction:)]) {
                [self.delegate onSnakeGameBoardView:self didPanningWithDirction:direction];
            }
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }
}


@end

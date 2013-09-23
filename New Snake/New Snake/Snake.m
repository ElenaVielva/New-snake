//
//  Snake.m
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "Snake.h"
#import "Constants.h"

#import "CCGL.h"

@implementation Snake

@synthesize dir = dir_;
@synthesize head = head_;

-(id) init {
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //@TODO: Change the positions to a new grid system
        head_ = ccp(marginH+5*gridSize+gridSize/2, marginH+10*gridSize+gridSize/2);
//        head_ = ccp(size.width*0.05+55, size.height*0.05+55);
        dir_ = right;
        
        tail = [[NSMutableArray array] retain];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-gridSize, head_.y)]];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-gridSize, head_.y-gridSize)]];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-gridSize, head_.y-2*gridSize)]];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-gridSize, head_.y-3*gridSize)]];
    }
    return self;
}

-(void) draw {
    
    if (death) {
        for (int i=0;i<[tail count];i++) {
            CGPoint tailpart = [[tail objectAtIndex:i] CGPointValue];
            ccDrawSolidRect(ccp(tailpart.x-5, tailpart.y-5), ccp(tailpart.x+5, tailpart.y+5), ccc4f(1, 0.33, 0, 1));
        }
        return;
    }
    ccDrawSolidRect(ccp(head_.x-5, head_.y-5), ccp(head_.x+5, head_.y+5), ccc4f(0.91, 0.91, 0.92, 1));
    for (int i=0;i<[tail count];i++) {
        CGPoint tailpart = [[tail objectAtIndex:i] CGPointValue];
        ccDrawSolidRect(ccp(tailpart.x-5, tailpart.y-5), ccp(tailpart.x+5, tailpart.y+5), ccc4f(0.91, 0.91, 0.92, 1));
    }
}

-(BOOL) move:(int) direction {
    
    BOOL collide = NO;
    
    if ( ((direction == up) && (dir_ == down)) ||
         ((direction == down) && (dir_ == up)) ||
         ((direction == left) && (dir_ == right)) ||
         ((direction == right) && (dir_ == left)) ||
         direction == same ){
        direction = dir_;
    }
    CGPoint nextHead = CGPointZero;
    
    switch (direction) {
        case left:
            nextHead = ccp(head_.x-gridSize, head_.y);
            break;
        case right:
            nextHead = ccp(head_.x+gridSize, head_.y);
            break;
        case up:
            nextHead = ccp(head_.x, head_.y+gridSize);
            break;
        case down:
            nextHead = ccp(head_.x, head_.y-gridSize);
            break;
        default:
            NSLog(@"???");
            break;
    }
    
    
    ultPos = [[tail objectAtIndexedSubscript:[tail count]-1] CGPointValue];
    
    for (int i=[tail count]-1; i>0; i--) {
        CGPoint tailPrev = [[tail objectAtIndex:i-1] CGPointValue];
        [tail setObject:[NSValue valueWithCGPoint:tailPrev] atIndexedSubscript:i];
        if (CGPointEqualToPoint(tailPrev, nextHead)) {
            NSLog(@"Se ha chocado consigo misma!!");
            collide = YES;
        }
    }
    [tail setObject:[NSValue valueWithCGPoint:head_] atIndexedSubscript:0];
    
    head_ = nextHead;
    dir_ = direction;
    
    return !collide;
}

-(BOOL) eat:(CGPoint) foodPos {
    if (CGPointEqualToPoint(head_, foodPos)) {
        [tail addObject:[NSValue valueWithCGPoint:ultPos]];
        return YES;
    }
    return NO;
}

-(BOOL) isOnSnake:(CGPoint)pos {
//    NSLog(@"Punto a comprobar %f %f",pos.x, pos.y);
//    NSLog(@"Cabeza %f %f", head_.x, head_.y);
    if (CGPointEqualToPoint(head_, pos)) {
        return YES;
    }
    for (int i=0; i<[tail count]; i++) {
        CGPoint tailPos = [[tail objectAtIndexedSubscript:i] CGPointValue];
//        NSLog(@"Cola %d %f %f", i, tailPos.x, tailPos.y);
        if (CGPointEqualToPoint(tailPos, pos)) {
            return YES;
        }
    }
    return NO;
}

-(void) die {
    death = YES;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    NSLog(@"Deallocating %@",self);
	
    [tail release];
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

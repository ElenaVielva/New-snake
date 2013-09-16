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
        head_ = ccp(size.width*0.5, size.height*0.5);
        dir_ = right;
        
        tail = [[NSMutableArray array] retain];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-10, head_.y)]];
        [tail addObject:[NSValue valueWithCGPoint:CGPointMake(head_.x-10, head_.y-10)]];
    }
    return self;
}


-(void) draw {
    
    ccDrawSolidRect(ccp(head_.x-5, head_.y-5), ccp(head_.x+5, head_.y+5), ccc4f(233, 233, 235, 1));
    for (int i=0;i<[tail count];i++) {
        CGPoint tailpart = [[tail objectAtIndex:i] CGPointValue];
        ccDrawSolidRect(ccp(tailpart.x-5, tailpart.y-5), ccp(tailpart.x+5, tailpart.y+5), ccc4f(233, 233, 235, 1));
    }
}

-(BOOL) move:(int) direction {
    
    if ( ((direction == up) && (dir_ == down)) ||
         ((direction == down) && (dir_ == up)) ||
         ((direction == left) && (dir_ == right)) ||
         ((direction == right) && (dir_ == left))){
        direction = dir_;
    }
    
    for (int i=[tail count]-1; i>0; i--) {
        CGPoint tailPrev = [[tail objectAtIndex:i-1] CGPointValue];
        [tail setObject:[NSValue valueWithCGPoint:tailPrev] atIndexedSubscript:i];
    }
    [tail setObject:[NSValue valueWithCGPoint:head_] atIndexedSubscript:0];
    
    switch (direction) {
        case left:
            head_ = ccp(head_.x-10, head_.y);
            break;
        case right:
            head_ = ccp(head_.x+10, head_.y);
            break;
        case up:
            head_ = ccp(head_.x, head_.y+10);
            break;
        case down:
            head_ = ccp(head_.x, head_.y-10);
            break;
        default:
            break;
    }
    
    dir_ = direction;
    
    return YES;
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

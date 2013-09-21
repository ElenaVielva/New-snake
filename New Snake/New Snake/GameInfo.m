//
//  GameInfo.m
//  New snake
//
//  Created by Elena Vielva on 21/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "GameInfo.h"


@implementation GameInfo

-(id) initWithLevel:(int) level {
    self = [super init];
    if (self) {
        _level = level;
        _gameScore = 0;
        
        CGSize size = [CCDirector sharedDirector].winSize;
        _posFood = ccp(size.width*0.5+20, size.height*0.5);
    }
    return self;
}

-(void) eatFood {
    _gameScore+=_level;
    NSLog(@"Score: %d",_gameScore);
    
    CGPoint tempPos;
    do {
        tempPos = ccpAdd(_posFood,ccp(20,0));
    } while ([snake isOnSnake:tempPos]);
    
    _posFood = tempPos;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    NSLog(@"Deallocating %@",self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

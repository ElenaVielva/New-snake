//
//  GameInfo.m
//  New snake
//
//  Created by Elena Vielva on 21/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "GameInfo.h"
#import "Info.h"
#import "Constants.h"

@implementation GameInfo

@synthesize posFood = posFood_;
@synthesize gameScore = gameScore_;
@synthesize level = level_;

-(id) initWithLevel:(int) level Player:(Snake *)player {
    self = [super init];
    if (self) {
        level_ = level;
        gameScore_ = 0;
        
        limL = [Info sharedInfo].limL;
        limR = [Info sharedInfo].limR;
        limU = [Info sharedInfo].limU;
        limD = [Info sharedInfo].limD;
        
        posFood_ = ccp(limL+12*gridSize+gridSize/2, limD+8*gridSize+gridSize/2);
        
        snake = player;
    }
    return self;
}

-(void) eatFood {
    gameScore_+=level_+1;
    
    CGPoint tempPos;
    do {
        int col = arc4random() % [Info sharedInfo].numCols;
        int row = arc4random() % [Info sharedInfo].numRows;
        tempPos = ccp(marginH + col*gridSize+gridSize/2, marginH + row*gridSize+gridSize/2);

    } while ([snake isOnSnake:tempPos]);
    
    posFood_ = tempPos;
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

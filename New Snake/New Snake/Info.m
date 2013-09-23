//
//  Info.m
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import "Info.h"
#import "cocos2d.h"
#import "Snake.h"
#import "Constants.h"

static Info *shared;

@implementation Info

@synthesize level = _level;
@synthesize score = _score;
@synthesize limL = _limL;
@synthesize limR = _limR;
@synthesize limD = _limD;
@synthesize limU = _limU;

@synthesize boundaries = _boundaries;

+(Info*) sharedInfo {
    if (shared) {
        return shared;
    }
    shared = [[Info alloc] init];
    return shared;
}

-(id) init {
    self = [super init];
    if (self) {
        _level = 0;
        _score = 0;
        
        _boundaries = YES;
        
        CGSize size = [CCDirector sharedDirector].winSize;
        
        // Number of columns and rows of the grid
        int cols = (size.width-2*marginH)/gridSize;
        int rows = (size.height-marginH-marginV)/gridSize;
        
        // Extra space of the last column and row
        float extraCol = (size.width-2*marginH)/(gridSize*1.0)-cols;
        float extraRow = (size.height-marginH-marginV)/(gridSize*1.0)-rows;
        
        _limL = marginH;
        _limR = size.width-marginH-extraCol*gridSize;
        _limD = marginH;
        _limU = size.height-marginV-extraRow*gridSize;
        
    }
    return self;
}


@end

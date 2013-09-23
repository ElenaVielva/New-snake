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

@synthesize level = level_;
@synthesize score = score_;
@synthesize limL = limL_;
@synthesize limR = limR_;
@synthesize limD = limD_;
@synthesize limU = limU_;

@synthesize numCols = numCols_;
@synthesize numRows = numRows_;

@synthesize boundaries = boundaries_;

+(Info*) sharedInfo {
    if (shared) {
        return shared;
    }
    shared = [[Info alloc] init];
    return shared;
}

-(void) saveState {
    NSLog(@"Save state");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:level_ forKey:@"Last level"];
    [prefs setInteger:score_ forKey:@"Best score"];
    [prefs setBool:boundaries_ forKey:@"Last boundaries"];
    
    NSLog(@"Post save state. Level %d, score %d, borders %d",
          [prefs integerForKey:@"Last level"],[prefs integerForKey:@"Best score"],[prefs boolForKey:@"Last boundaries"]);
}

-(id) init {
    self = [super init];
    if (self) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([prefs objectForKey:@"First Time"] != nil) {
            level_ = [prefs integerForKey:@"Last level"];
            score_ = [prefs integerForKey:@"Best score"];
            boundaries_ = [prefs boolForKey:@"Last boundaries"];
            NSLog(@"Not first time. Level %d, score %d, borders %d",level_,score_,boundaries_);
        } else {
            NSLog(@"First time");
            level_ = 0;
            score_ = 0;
            boundaries_ = YES;
            [prefs setObject:[NSNumber numberWithBool:YES] forKey:@"First Time"];
            [self saveState];
        }
        
        
        CGSize size = [CCDirector sharedDirector].winSize;
        
        // Number of columns and rows of the grid
        numCols_ = (size.width-2*marginH)/gridSize;
        numRows_ = (size.height-marginH-marginV)/gridSize;
        
        // Extra space of the last column and row
        float extraCol = (size.width-2*marginH)/(gridSize*1.0)-numCols_;
        float extraRow = (size.height-marginH-marginV)/(gridSize*1.0)-numRows_;
        
        limL_ = marginH;
        limR_ = size.width-marginH-extraCol*gridSize;
        limD_ = marginH;
        limU_ = size.height-marginV-extraRow*gridSize;
        
    }
    return self;
}

- (void) updateScore:(int)score {
    NSLog(@"Update Score %d (prev %d)",score, score_);
    if (score > score_) {
        NSLog(@"Best score");
        score_ = score;
    }
    [self saveState];
}


@end

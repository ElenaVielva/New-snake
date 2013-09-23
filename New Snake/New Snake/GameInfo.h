//
//  GameInfo.h
//  New snake
//
//  Created by Elena Vielva on 21/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Snake.h"

@interface GameInfo : NSObject {
    
    int level_;
    int gameScore_;
    CGPoint posFood_;
    
    float limL, limR, limD, limU;
    
    Snake *snake;
}

@property (nonatomic) int level;
@property (nonatomic, readonly) int gameScore;
@property (nonatomic) CGPoint posFood;

-(id) initWithLevel:(int) level Player:(Snake*) player;
-(void) eatFood;

@end

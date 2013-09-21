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
    
    int _level;
    int _gameScore;
    CGPoint _posFood;
    
    Snake *snake;
}

@property (nonatomic) int level;
@property (nonatomic) int gameScore;
@property (nonatomic) CGPoint posFood;

-(id) initWithLevel:(int) level;
-(void) eatFood;

@end

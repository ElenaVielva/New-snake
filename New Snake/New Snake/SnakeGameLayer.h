//
//  SnakeGameLayer.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Snake.h"
#import "ScenarioLimits.h"
#import "GameInfo.h"


@interface SnakeGameLayer : CCLayer <UIAccelerometerDelegate> {
    int level;

    CGSize size;
    int countDown;
    CCLabelTTF *labelCountDown;
    CCLabelTTF *endLabel;
    CCLabelTTF *scoreLabel;
    
    float refAccX;
    float refAccY;
    
    float currAccX;
    float currAccY;
    
    Snake *player;
    ScenarioLimits *scene;
    GameInfo *info;
    
    float limL, limR, limD, limU;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

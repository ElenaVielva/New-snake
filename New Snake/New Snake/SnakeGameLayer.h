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
#import "GameInfo.h"

@interface SnakeGameLayer : CCLayer <UIAccelerometerDelegate> {
    int level;

    int countDown;
    CCLabelTTF *labelCountDown;
    CCLabelTTF *endLabel;
    
    float refAccX;
    float refAccY;
    
    float currAccX;
    float currAccY;
    
    Snake *player;
    GameInfo *info;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

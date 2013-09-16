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

@interface SnakeGameLayer : CCLayer {
    int level;

//    CCLabelTTF *snake;
    
    float prevAccX;
    float prevAccY;
    
    float currAccX;
    float currAccY;
    
    int direction;
    
    Snake *player;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

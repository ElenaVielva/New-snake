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

@interface SnakeGameLayer : CCLayer <UIAccelerometerDelegate> {
    int level;

    CCLabelTTF *endLabel;
    
    float refAccX;
    float refAccY;
    float refAccZ;
    
    float currAccX;
    float currAccY;
    float currAccZ;
    
    int direction;
    
    Snake *player;
    
    int countDown;
    CCLabelTTF *labelCountDown;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

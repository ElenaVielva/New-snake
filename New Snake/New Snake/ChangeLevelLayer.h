//
//  ChangeLevelLayer.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface ChangeLevelLayer : CCLayer {
    int currentSelected;
    CCMenuItem *levels[NUMLEVELS];
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

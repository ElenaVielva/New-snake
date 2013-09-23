//
//  ChangeLevelBoundaries.h
//  New snake
//
//  Created by Elena Vielva on 23/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ChangeLevelBoundaries : CCLayer {
    BOOL boundaries;
    CCMenuItemFont *borders;
    CCMenuItemFont *noBorders;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

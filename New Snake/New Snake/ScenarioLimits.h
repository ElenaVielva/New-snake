//
//  ScenarioLimits.h
//  New snake
//
//  Created by Elena Vielva on 22/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScenarioLimits : CCNode {
    BOOL bound;
    CGSize size;
    
    CGPoint ldcorner;
    CGPoint lucorner;
    CGPoint rdcorner;
    CGPoint rucorner;
}

//-(id) initWithLimits:(NSArray*)limits;
-(id) initWithBoundary:(BOOL)boundary;


-(BOOL) willCollide:(CGPoint) headPos;

@end

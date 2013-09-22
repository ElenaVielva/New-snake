//
//  ScenarioLimits.m
//  New snake
//
//  Created by Elena Vielva on 22/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "ScenarioLimits.h"
#import "CCGL.h"
#import "Constants.h"

@implementation ScenarioLimits

-(id) initWithBoundary:(BOOL)boundary {
    self = [super init];
    if (self) {
        bound = boundary;
        size = [CCDirector sharedDirector].winSize;
        
        ldcorner = ccp(size.width*limLeft, size.height*limDown);
        lucorner = ccp(size.width*limLeft, size.height*limUp);
        rdcorner = ccp(size.width*limRight, size.height*limDown);
        rucorner = ccp(size.width*limRight, size.height*limUp);
    }
    return self;
}

-(BOOL) willCollide:(CGPoint)headPos {
    if (bound) {
        if ((headPos.x > (size.width*limRight)) ||
            (headPos.x < (size.width*limLeft)) ||
            (headPos.y > (size.height*limUp))||
            (headPos.y < (size.height*limDown)) ) {
            return YES;
        }
    }
    return NO;
}

-(void) draw {
    
    if (bound) {
        ccDrawColor4F(0.91, 0.91, 0.92, 1);
        
        ccDrawLine(ldcorner, lucorner);
        ccDrawLine(lucorner, rucorner);
        ccDrawLine(rucorner, rdcorner);
        ccDrawLine(rdcorner, ldcorner);
    } else {
        ccDrawColor4F(0.91, 0.91, 0.92, 1);
        
        drawDashedLine(ldcorner, lucorner, 3);
        drawDashedLine(lucorner, rucorner, 3);
        drawDashedLine(rucorner, rdcorner, 3);
        drawDashedLine(rdcorner, ldcorner, 3);
    }
}

static void drawDashedLine(CGPoint origin, CGPoint destination, float dashLength) {
	float dx = destination.x - origin.x;
    float dy = destination.y - origin.y;
    float dist = sqrtf(dx * dx + dy * dy);
    float x = dx / dist * dashLength;
    float y = dy / dist * dashLength;
    CGPoint p1 = origin;
    for(float i = 0; i <= dist / dashLength / 2.0; i++) {
        CGPoint p2 = CGPointMake(p1.x + x, p1.y + y);
        ccDrawLine(p1, p2);
        p1 = CGPointMake(p1.x + x * 2.0, p1.y + y * 2.0);
    }
}

-(void) dealloc {
    // in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    NSLog(@"Deallocating %@",self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

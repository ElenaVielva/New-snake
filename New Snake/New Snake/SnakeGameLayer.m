//
//  SnakeGameLayer.m
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "SnakeGameLayer.h"

#import "Info.h"
#import "Constants.h"

@implementation SnakeGameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SnakeGameLayer *layer = [SnakeGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		level = [Info sharedInfo].level;
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

        
        switch (level) {
            case easy:
                [self schedule:@selector(move) interval:0.8f];
                break;
            case medium:
                [self schedule:@selector(move) interval:0.4f];
                break;
            case hard:
                [self schedule:@selector(move) interval:0.2f];
                break;
            default:
                break;
        }
		
        player = [Snake node];
        [self addChild:player];
        
        
        endLabel = [CCLabelTTF labelWithString:@"End! Ooooh!" fontName:@"American Typewriter" fontSize:20];
        endLabel.color = ccWHITE;
        endLabel.visible = NO;
        endLabel.position = ccp(size.width*0.5, size.height*0.5);
        [self addChild:endLabel];
        
        
        prevAccX = 0;
        prevAccY = 0;
        
        [self setAccelerometerEnabled:YES];
        
	}
	return self;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
    
    NSLog(@"Acceleration: %f %f", acceleration.x, acceleration.y);

    currAccX = acceleration.x;
    currAccY = acceleration.y;
    
}

- (void) move {
    
    if (currAccX-prevAccX<-0.3) {
        direction = up;
    } else if (currAccX-prevAccX>0.3) {
        direction = down;
    } else if (currAccY-prevAccY>0.1) {
        direction = right;
    } else if (currAccY-prevAccY<-0.1) {
        direction = left;
    }
    
    prevAccX = currAccX;
    prevAccY = currAccY;
    
    if (![player move:direction]) {
        [self unschedule:@selector(move)];
        endLabel.visible = YES;
        [self setAccelerometerEnabled:NO];
    };
//    CGPoint pos = player.head;
//    switch (direction) {
//        case left:
//            player.head = ccp(pos.x-10, pos.y);
//            break;
//        case right:
//            player.head = ccp(pos.x+10, pos.y);
//            break;
//        case up:
//            player.head = ccp(pos.x, pos.y+10);
//            break;
//        case down:
//            player.head = ccp(pos.x, pos.y-10);
//            break;
//        default:
//            break;
//    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    NSLog(@"Deallocating %@",self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

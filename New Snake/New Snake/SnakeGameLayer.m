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
#import "MenuLayer.h"

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

        
        		
        player = [Snake node];
        [self addChild:player];
        
        
        endLabel = [CCLabelTTF labelWithString:@"Game Over" fontName:@"American Typewriter" fontSize:30];
        endLabel.color = ccc3(141, 141, 235);
        endLabel.position = ccp(size.width*0.5, size.height*0.5);
        [self addChild:endLabel z:5];
        endLabel.visible = NO;
        
        
        countDown = 2;
        labelCountDown = [CCLabelTTF labelWithString:@"3" fontName:@"American Typewriter" fontSize:60];
        labelCountDown.color = ccc3(141, 141, 235);
        labelCountDown.position = ccp(size.width*0.5, size.height*0.5);
        [self addChild:labelCountDown z:5];
        labelCountDown.visible = NO;
        
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        
        [self setTouchEnabled:YES];
        
	}
	return self;
}

- (void) onEnterTransitionDidFinish {
    
    labelCountDown.visible = YES;
    
    [self schedule:@selector(countDownMethod) interval:1 repeat:2 delay:1];
    
}

- (void) countDownMethod {
    
    NSLog(@"CountDownMethod, counter is %d",countDown);
    if (countDown>0) {
        [labelCountDown setString:[NSString stringWithFormat:@"%d",countDown]];
        countDown--;
        return;
    }
    labelCountDown.visible = NO;
    
    switch (level) {
        case easy:
            [self schedule:@selector(move) interval:.8f];
            break;
        case medium:
            [self schedule:@selector(move) interval:.4f];
            break;
        case hard:
            [self schedule:@selector(move) interval:.2f];
            break;
        default:
            break;
    }

    refAccX = currAccX;
    refAccY = currAccY;
    refAccZ = currAccZ;
    
    
    
    
}

- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
    
//    NSLog(@"Acceleration: %f %f %f", acceleration.x, acceleration.y, acceleration.z);

    currAccX = acceleration.x;
    currAccY = acceleration.y;
    currAccZ = acceleration.z;
    
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (endLabel.visible) {
        [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
    }
}

- (void) move {
    
    float difX = currAccX-refAccX;
    float difY = currAccY-refAccY;
    float difZ = currAccZ-refAccZ;
    NSLog(@"Diferencias son %f %f %f (x, y, z)", difX,difY,difZ);
    if (currAccX-refAccX<-0.2) {
        direction = up;
    } else if (currAccX-refAccX>0.2) {
        direction = down;
    } else if (currAccY-refAccY>0.1) {
        direction = right;
    } else if (currAccY-refAccY<-0.1) {
        direction = left;
    }
    
//    refAccX = currAccX;
//    refAccY = currAccY;
    
    if (![player move:direction]) {
        [self unschedule:@selector(move)];
        endLabel.visible = YES;
        [self setAccelerometerEnabled:NO];
    };

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

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

#import "CCGL.h"

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

-(void) draw {
    
    CGPoint posFood = info.posFood;
    ccDrawSolidRect(ccp(posFood.x-5, posFood.y-5), ccp(posFood.x+5, posFood.y+5), ccc4f(0.92, 0.55, 0.55, 1));

}

// on "init" you need to initialize your instance
-(id) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		level = [Info sharedInfo].level;
        
        // ask director for the window size
		size = [[CCDirector sharedDirector] winSize];

        
        		
        player = [Snake node];
        [self addChild:player];
        
        //@TODO: Change the boundary configuration, (un)set it from the menu
        scene = [[ScenarioLimits alloc] initWithBoundary:YES];
        [self addChild:scene];
        
        info = [[GameInfo alloc] initWithLevel:level];
        
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
        
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"American Typewriter" fontSize:18];
//        scoreLabel.horizontalAlignment = kCCTextAlignmentRight;
        scoreLabel.anchorPoint = ccp(1, 0);
        scoreLabel.color = ccc3(232, 232, 235);
        scoreLabel.position = ccp(size.width*0.95, size.height*0.93);
        [self addChild:scoreLabel z:5];
        
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
}

- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
    currAccX = acceleration.x;
    currAccY = acceleration.y;
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (endLabel.visible) {
        [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
    }
}

- (void) move {
    
    float difX = currAccX-refAccX;
    float difY = currAccY-refAccY;

    int direction;
    
    // To avoid preferences on up/down directions. Makes the motion a bit more intuitive
    if (abs(difX)>abs(difY)*2) {
        if (difX<-0.2) {
            direction = up;
        } else if (difX>0.2) {
            direction = down;
        } else if (difY>0.1) {
            direction = right;
        } else if (difY<-0.1) {
            direction = left;
        } else {
            direction = same;
        }
    }else {
        if (difY>0.1) {
            direction = right;
        } else if (difY<-0.1) {
            direction = left;
        } else if (difX<-0.2) {
            direction = up;
        } else if (difX>0.2) {
            direction = down;
        } else  {
            direction = same;
        }
    }
    
    // End of the game (collision)
    if (![player move:direction] || [scene willCollide:player.head]) {
        [self unschedule:@selector(move)];
        endLabel.visible = YES;
    };
    
    CGPoint nextHead = player.head;
    if (player.head.x<limLeft*size.width) {
        nextHead = ccp(limRight*size.width-5, player.head.y);
    } else if (player.head.x>limRight*size.width) {
        nextHead = ccp(limLeft*size.width+5, player.head.y);
    } else if (player.head.y<limDown*size.height) {
        nextHead = ccp(player.head.x, limUp*size.height-5);
    } else if (player.head.y>limUp*size.height) {
        nextHead = ccp(player.head.x, limDown*size.height+5);
    }
    if (!CGPointEqualToPoint(nextHead, player.head)) {
        player.head = nextHead;
    }
    
    if ([player eat:info.posFood]) {
        [info eatFood];
        [scoreLabel setString:[NSString stringWithFormat:@"%d",info.gameScore]];
    }

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    NSLog(@"Deallocating %@",self);
    
    [info release];
    [scene release];
    
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

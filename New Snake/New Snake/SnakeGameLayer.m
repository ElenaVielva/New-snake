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

        limL = [Info sharedInfo].limL;
        limR = [Info sharedInfo].limR;
        limU = [Info sharedInfo].limU;
        limD = [Info sharedInfo].limD;
        
        player = [Snake node];
        [self addChild:player];
        
        scene = [[ScenarioLimits alloc] initWithBoundary:[Info sharedInfo].boundaries];
        [self addChild:scene];
        
        info = [[GameInfo alloc] initWithLevel:level Player:player];
        
        endLabel = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Telespania" fontSize:30];
        endLabel.color = ccc3(141, 141, 235);
        endLabel.position = ccp(size.width*0.5, size.height*0.5);
        [self addChild:endLabel z:5];
        endLabel.visible = NO;
        
        
        countDown = 2;
        labelCountDown = [CCLabelTTF labelWithString:@"3" fontName:@"Telespania" fontSize:60];
        labelCountDown.color = ccc3(141, 141, 235);
        labelCountDown.position = ccp(size.width*0.5, size.height*0.5);
        [self addChild:labelCountDown z:5];
        labelCountDown.visible = NO;
        
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Telespania" fontSize:18];
        scoreLabel.anchorPoint = ccp(1, 0);
        scoreLabel.color = ccc3(232, 232, 235);
        scoreLabel.position = ccp(size.width*0.95, size.height*0.93);
        [self addChild:scoreLabel z:5];
        
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        
        
        
	}
	return self;
}

- (void) onEnterTransitionDidFinish {
    labelCountDown.visible = YES;
    [self schedule:@selector(countDownMethod) interval:1 repeat:2 delay:1];
}

- (void) countDownMethod {
    
    if (countDown>0) {
        [labelCountDown setString:[NSString stringWithFormat:@"%d",countDown]];
        countDown--;
        return;
    }
    labelCountDown.visible = NO;
    
    switch (level) {
        case easy:
            [self schedule:@selector(move) interval:.6f];
            break;
        case medium:
            [self schedule:@selector(move) interval:.3f];
            break;
        case hard:
            [self schedule:@selector(move) interval:.1f];
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
    if (abs(difX)>abs(difY)*1.3) {
        if ((difX<-0.2)&&(player.dir!=up)) {
            direction = up;
        } else if ((difX>0.2)&&(player.dir!=down)) {
            direction = down;
        } else if ((difY>0.15)&&(player.dir!=right)) {
            direction = right;
        } else if ((difY<-0.15)&&(player.dir!=left)) {
            direction = left;
        } else {
            direction = same;
        }
    } else {
        if ((difY>0.15)&&(player.dir!=right)) {
            direction = right;
        } else if ((difY<-0.15)&&(player.dir!=left)) {
            direction = left;
        } else if ((difX<-0.2)&&(player.dir!=up)) {
            direction = up;
        } else if ((difX>0.2)&&(player.dir!=down)) {
            direction = down;
        } else  {
            direction = same;
        }
    }
    
    // End of the game (collision)
    if (![player move:direction] || [scene willCollide:player.head]) {
        [self unschedule:@selector(move)];
        [player die];
        endLabel.visible = YES;
        [[Info sharedInfo] updateScore:info.gameScore];
        [self setTouchEnabled:YES];
    };
    
    CGPoint nextHead = player.head;
    
    if (player.head.x<limL) {
        nextHead = ccp(limR-gridSize/2, player.head.y);
    } else if (player.head.x>limR) {
        nextHead = ccp(limL+gridSize/2, player.head.y);
    } else if (player.head.y<limD) {
        nextHead = ccp(player.head.x, limU-gridSize/2);
    } else if (player.head.y>limU) {
        nextHead = ccp(player.head.x, limD+gridSize/2);
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

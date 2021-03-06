//
//  HelloWorldLayer.m
//  New snake
//
//  Created by Elena Vielva on 15/09/13.
//  Copyright Elena Vielva 2013. All rights reserved.
//


// Import the interfaces
#import "MenuLayer.h"

#import "ChangeLevelLayer.h"
#import "ChangeLevelBoundaries.h"
#import "SnakeGameLayer.h"

#import "Info.h"

// HelloWorldLayer implementation
@implementation MenuLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
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
		
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"New Snake" fontName:@"Telespania" fontSize:60];
		label.position =  ccp( size.width /2 , size.height*0.6 );
		[self addChild: label];
		
		NSString *max = [NSString stringWithFormat:@"Max score: %d",[Info sharedInfo].score];
        CCLabelTTF *bestScore = [CCLabelTTF labelWithString:max fontName:@"Telespania" fontSize:20];
        bestScore.position = ccp(size.width*0.9, size.height*0.9);
        bestScore.anchorPoint = ccp(1, 0);
        [self addChild:bestScore];
        
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        [CCMenuItemFont setFontName:@"Telespania"];
		
		// to avoid a retain-cycle with the menuitem and blocks
		__block id copy_self = self;
		
		// Change level Menu Item using blocks
        NSString *nameLevel;
        switch ([Info sharedInfo].level) {
            case 0:
                nameLevel = @"Easy";
                break;
            case 1:
                nameLevel = @"Medium";
                break;
            case 2:
                nameLevel = @"Hard";
                break;
            default:
                break;
        }
		CCMenuItem *levelMenuItem = [CCMenuItemFont itemWithString:nameLevel block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[ChangeLevelLayer scene]];
		}];
		
        // Configure Menu Item using blocks
        NSString *bound;
        if ([Info sharedInfo].boundaries) {
            bound = @"Borders";
        }else {
            bound = @"No borders";
        }
		CCMenuItem *confMenuItem = [CCMenuItemFont itemWithString:bound block:^(id sender) {
			NSLog(@"Change boundaries");
            [[CCDirector sharedDirector] replaceScene:[ChangeLevelBoundaries scene]];
		}];
        
		// Play game Menu Item using blocks
		CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[SnakeGameLayer scene]];
		}];

		
		CCMenu *menu = [CCMenu menuWithItems:levelMenuItem, confMenuItem,playMenuItem, nil];
		
        [menu alignItemsInColumns:[NSNumber numberWithInt:2],[NSNumber numberWithInt:1], nil];
		[menu setPosition:ccp( size.width/2, size.height*0.3)];
		
		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
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

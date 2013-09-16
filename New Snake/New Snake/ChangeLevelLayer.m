//
//  ChangeLevelLayer.m
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "ChangeLevelLayer.h"
#import "Info.h"

#import "MenuLayer.h"

@implementation ChangeLevelLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChangeLevelLayer *layer = [ChangeLevelLayer node];
	
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
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Level" fontName:@"American Typewriter" fontSize:50];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height*0.75 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        [CCMenuItemFont setFontName:@"American Typewriter"];
		
		
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(backMenu)];
		
        levels[easy] = [CCMenuItemFont itemWithString:@"Easy" target:self selector:@selector(selectEasy)];
        levels[medium] = [CCMenuItemFont itemWithString:@"Medium" target:self selector:@selector(selectMedium)];
        levels[hard] = [CCMenuItemFont itemWithString:@"Hard" target:self selector:@selector(selectHard)];
        
		CCMenu *menu = [CCMenu menuWithItems:levels[easy], levels[medium], levels[hard], back, nil];
		
        [menu alignItemsInColumns:[NSNumber numberWithInt:3],[NSNumber numberWithInt:1], nil];
        
//		[menu alignItemsHorizontallyWithPadding:30];
		[menu setPosition:ccp( size.width/2, size.height*0.3)];
		
        switch ([Info sharedInfo].level) {
            case easy:
                [self selectEasy];
                break;
            case medium:
                [self selectMedium];
                break;
            case hard:
                [self selectHard];
                break;
            default:
                break;
        }
        
		// Add the menu to the layer
		[self addChild:menu];
        
	}
	return self;
}

-(void) selectEasy {
    [levels[currentSelected] setColor:ccWHITE];
    [levels[easy] setColor:ccc3(130, 224, 121)];
    currentSelected = easy;
}

-(void) selectMedium {
    [levels[currentSelected] setColor:ccWHITE];
    [levels[medium] setColor:ccc3(219, 224, 121)];
    currentSelected = medium;
}

-(void) selectHard {
    [levels[currentSelected] setColor:ccWHITE];
    [levels[hard] setColor:ccc3(224, 152, 121)];
    currentSelected=hard;
}

- (void) backMenu {
    [Info sharedInfo].level = currentSelected;
    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
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

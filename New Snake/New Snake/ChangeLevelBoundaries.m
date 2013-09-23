//
//  ChangeLevelBoundaries.m
//  New snake
//
//  Created by Elena Vielva on 23/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import "ChangeLevelBoundaries.h"
#import "MenuLayer.h"
#import "Info.h"

@implementation ChangeLevelBoundaries

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChangeLevelBoundaries *layer = [ChangeLevelBoundaries node];
	
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
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Scenario" fontName:@"Telespania" fontSize:50];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height*0.75 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        [CCMenuItemFont setFontName:@"Telespania"];
		
		
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(backMenu)];
		
        borders = [CCMenuItemFont itemWithString:@"Borders" target:self selector:@selector(selectBorders)];
        noBorders = [CCMenuItemFont itemWithString:@"No Borders" target:self selector:@selector(selectNoBorders)];
        
		CCMenu *menu = [CCMenu menuWithItems:borders, noBorders, back, nil];
		
        [menu alignItemsInRows:[NSNumber numberWithInt:3], nil];
		[menu setPosition:ccp(size.width/2, size.height*0.3)];
        
        boundaries = [Info sharedInfo].boundaries;
		
        if (boundaries) {
            [self selectBorders];
        }else {
            [self selectNoBorders];
        }

        
		// Add the menu to the layer
		[self addChild:menu];
        
	}
	return self;
}

-(void) selectBorders {
    boundaries = YES;
    [noBorders setString:@"No Borders"];
    [borders setString:@"* Borders *"];
}

-(void) selectNoBorders {
    boundaries = NO;
    [noBorders setString:@"* No Borders *"];
    [borders setString:@"Borders"];
}


- (void) backMenu {
    [Info sharedInfo].boundaries = boundaries;
    [[Info sharedInfo] saveState];
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

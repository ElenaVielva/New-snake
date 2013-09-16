//
//  IntroLayer.m
//  New snake
//
//  Created by Elena Vielva on 15/09/13.
//  Copyright Elena Vielva 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "MenuLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init {
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter {
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuLayer scene] ]];
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

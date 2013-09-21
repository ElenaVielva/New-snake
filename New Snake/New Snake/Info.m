//
//  Info.m
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import "Info.h"
#import "cocos2d.h"
#import "Snake.h"

static Info *shared;

@implementation Info

@synthesize level = _level;
@synthesize score = _score;

+(Info*) sharedInfo {
    if (shared) {
        return shared;
    }
    shared = [[Info alloc] init];
    return shared;
}

-(id) init {
    self = [super init];
    if (self) {
        _level = 0;
        _score = 0;
    }
    return self;
}


@end

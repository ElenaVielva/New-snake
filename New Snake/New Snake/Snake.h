//
//  Snake.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Snake : CCNode {
    int dir_;
    CGPoint head_;
    NSMutableArray *tail;
    
}

@property (nonatomic) int dir;
@property (nonatomic) CGPoint head;

-(BOOL) move:(int)direction;

@end

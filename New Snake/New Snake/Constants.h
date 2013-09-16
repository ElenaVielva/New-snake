//
//  Constants.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NUMLEVELS   3

@interface Constants : NSObject

typedef enum {
    easy,
    medium,
    hard
}levelDifficulties;

typedef enum {
    left,
    right,
    up,
    down
}directions;

@end

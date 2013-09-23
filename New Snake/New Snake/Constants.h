//
//  Constants.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NUMLEVELS   3

#define limLeft     0.05
#define limRight    0.95
#define limUp       0.92
#define limDown     0.05

// The margin must be a multiple of the gridSize
#define gridSize    10
#define marginH     20
#define marginV     30

@interface Constants : NSObject

typedef enum {
    easy,
    medium,
    hard
}levelDifficulties;

typedef enum {
    left,  //0
    right, //1
    up,    //2
    down,  //3
    same   //4
}directions;


@end

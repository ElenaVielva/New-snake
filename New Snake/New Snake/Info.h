//
//  Info.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject {
    int _level;
    int _score;
    
    BOOL _boundaries;
    
    float _limL;
    float _limR;
    float _limD;
    float _limU;
    
}


@property (nonatomic) int level;
@property (nonatomic) int score;
@property (nonatomic) float limL;
@property (nonatomic) float limR;
@property (nonatomic) float limD;
@property (nonatomic) float limU;
@property (nonatomic) BOOL boundaries;

+(Info*) sharedInfo;

@end

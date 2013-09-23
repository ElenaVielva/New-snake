//
//  Info.h
//  New snake
//
//  Created by Elena Vielva on 16/09/13.
//  Copyright (c) 2013 Elena Vielva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject {
    int level_;
    int score_;
    
    BOOL boundaries_;
    
    float limL_;
    float limR_;
    float limD_;
    float limU_;
    
    int numCols_;
    int numRows_;
    
}


@property (nonatomic) int level;
@property (nonatomic) int score;
@property (nonatomic) float limL;
@property (nonatomic) float limR;
@property (nonatomic) float limD;
@property (nonatomic) float limU;
@property (nonatomic) BOOL boundaries;
@property (nonatomic) int numCols;
@property (nonatomic) int numRows;

+(Info*) sharedInfo;
-(void) updateScore:(int)score;
-(void) saveState;

@end

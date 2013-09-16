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
}


@property (nonatomic) int level;

+(Info*) sharedInfo;

@end

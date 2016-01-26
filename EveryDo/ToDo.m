//
//  ToDo.m
//  EveryDo
//
//  Created by Chloe on 2016-01-26.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)descr andPriority:(int)priority {
    self = [super init];
    if (self) {
        _title = title;
        _descr = descr;
        _priorityNumber = priority;
    }
    return self;
}

@end

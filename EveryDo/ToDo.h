//
//  ToDo.h
//  EveryDo
//
//  Created by Chloe on 2016-01-26.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, assign) int priorityNumber;
@property (nonatomic) BOOL isCompleted;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)descr andPriority:(int)priority;

@end

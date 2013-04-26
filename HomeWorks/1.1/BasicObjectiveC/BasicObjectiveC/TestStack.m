//
//  TestStack.m
//  BasicObjectiveC
//
//  Created by 田澤 健二 on 2013/04/23.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TestStack.h"

@interface TestStack ()

@property(nonatomic,strong) NSMutableArray *list;

@end


@implementation TestStack



- (id)init
{
    self = [super init];
    if (self) {
        _list = [NSMutableArray array];
    }
    return self;
}



- (void)push:(id)object
{
    [_list insertObject:object atIndex:0];
}

- (id)pop
{
    if (_list || [self size] == 0) {
        nil;
    }
    return [_list objectAtIndex:0];
}

- (NSInteger)size
{
    return [_list count];
}

@end

//
//  TestQueue.h
//  BasicObjectiveC
//
//  Created by 田澤 健二 on 2013/04/23.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestQueue : NSObject

- (void)push:(id)object;

- (id)pop;

- (NSInteger)size;

@end

//
//  BlockingQueue.m
//  Producer Consumer Thread
//
//  Created by WOS on 21/08/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

#import "BlockingQueue.h"

@interface BlockingQueue()
@property (nonatomic, strong) NSMutableArray *queue;
@property (nonatomic, strong) NSCondition *lock;
@property (nonatomic, strong) dispatch_queue_t dispatchQueue;
@end


@implementation BlockingQueue

- (id)init
{
    self = [super init];
    if (self)
    {
        self.queue = [[NSMutableArray alloc] init];
        self.lock = [[NSCondition alloc] init];
        self.dispatchQueue = dispatch_queue_create("com.bhavin.producerconsumer.blockingqueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)enqueue:(id)object
{
    [_lock lock];
    [_queue addObject:object];
    [_lock signal];
    [_lock unlock];
}

- (id)dequeue
{
    __block id object;
    dispatch_sync(_dispatchQueue, ^{
        [_lock lock];
        
        
        while (_queue.count == 0)
        {
            [_lock wait];
        }
        object = [_queue objectAtIndex:0];
        [_queue removeObjectAtIndex:0];
        [_lock unlock];
    });
    
    return object;
}

- (NSUInteger)count
{
    return [_queue count];
}

- (void)dealloc
{
    self.dispatchQueue = nil;
    self.queue = nil;
    self.lock = nil;
}

@end

//
//  BlockingQueue.h
//  Producer Consumer Thread
//
//  Created by WOS on 21/08/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockingQueue : NSObject

/**
 * Enqueues an object to the queue.
 * @param object Object to enqueue
 */
- (void)enqueue:(id)object;

/**
 * Dequeues an object from the queue.  This method will block.
 */
- (id)dequeue;

- (NSUInteger)count;

@end

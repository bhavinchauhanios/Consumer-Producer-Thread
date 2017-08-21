# Consumer-Producer-Thread
Simple consumer producer thread implementation in Objective-C.

```
- (void)producerThread
{
    while (YES)
    {
        count = count + 1;
        [self enqueue:[NSString stringWithFormat:@"%lu",(unsigned long)count]];
        NSLog(@"Enqueue: %@",[NSString stringWithFormat:@"%lu",(unsigned long)count]);
        [NSThread sleepForTimeInterval:0.01];
    }
}

- (void)consumerThread
{
    while (YES)
    {
            NSString *strDequeueString = [self dequeue];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Dequeue: %@",[NSString stringWithFormat:@"%@",strDequeueString]);
            });
    }
}
```

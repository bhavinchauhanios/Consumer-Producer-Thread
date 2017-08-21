//
//  ViewController.m
//  Producer Consumer Thread
//
//  Created by WOS on 21/08/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSUInteger count;
}

@property (nonatomic, weak) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [[NSMutableArray alloc] init];
    self.lock = [[NSCondition alloc] init];
    self.dispatchQueue = dispatch_queue_create("com.bhavin.producerconsumer.blockingqueue", DISPATCH_QUEUE_SERIAL);
    
    [self performSelectorInBackground:@selector(producerThread) withObject:nil];
    [self performSelectorInBackground:@selector(consumerThread) withObject:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

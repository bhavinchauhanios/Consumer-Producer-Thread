//
//  ViewController.m
//  Producer Consumer Thread
//
//  Created by WOS on 21/08/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

#import "ViewController.h"
#import "BlockingQueue.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong) BlockingQueue *blockingQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blockingQueue = [[BlockingQueue alloc] init];
    
    [self performSelectorInBackground:@selector(producerThread) withObject:nil];
    [self performSelectorInBackground:@selector(consumerThread) withObject:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)producerThread
{
    while (YES)
    {
        NSLog(@"Enqueue...!");
        [_blockingQueue enqueue:[NSString stringWithFormat:@"%f", 0.01]];
        [NSThread sleepForTimeInterval:0.01];
    }
}

- (void)consumerThread
{
    while (YES)
    {

        NSString *s = [_blockingQueue dequeue];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *strDequeueString = [NSString stringWithFormat:@"%@",s];
            NSLog(@"Dequeue...!");
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

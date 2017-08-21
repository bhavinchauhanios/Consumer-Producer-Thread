//
//  ViewController.h
//  Producer Consumer Thread
//
//  Created by WOS on 21/08/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *queue;
@property (nonatomic, strong) NSCondition *lock;
@property (nonatomic, strong) dispatch_queue_t dispatchQueue;

@end


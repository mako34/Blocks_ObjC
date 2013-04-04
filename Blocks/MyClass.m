//
//  MyClass.m
//  Blocks
//
//  Created by Manuel on 4/04/13.
//  Copyright (c) 2013 Orchard. All rights reserved.
//

#import "MyClass.h"

@interface MyClass()

@property (nonatomic, copy)MyClassResponse responseBlock;

@end



@implementation MyClass

@synthesize myString1 = _myString1;

- (id)initWithParams:(NSString*)myString1
{
    self = [super init];
    
    if (self) {
        NSLog(@"initted");
        
        self.myString1 = myString1;
        
        NSLog(@"myString1 :: %@", self.myString1);
    }
    
    return self;
}




- (void)blockWithCallBack:(MyClassResponse)response
{
    NSLog(@"blockWithCallBack called");
    self.responseBlock = response;
    [self startTimer];
}

- (void)startTimer
{
    NSLog(@"startTimer");
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow: 1 ];
    [NSThread sleepUntilDate:future];
    
    self.responseBlock(YES);
}


@end

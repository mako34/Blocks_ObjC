//
//  MyClass.h
//  Blocks
//
//  Created by Manuel on 4/04/13.
//  Copyright (c) 2013 Orchard. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MyClassResponse) (BOOL myBool);


@interface MyClass : NSObject {
    
    NSString *_myString1;
}

@property (nonatomic, retain)NSString *myString1;





- (void)blockWithCallBack:(MyClassResponse)response;

- (id)initWithParams:(NSString*)myString1;


@end

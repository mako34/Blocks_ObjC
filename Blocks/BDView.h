//
//  BDView.h
//  Blocks
//
//  Created by Manuel on 4/04/13.
//  Copyright (c) 2013 Orchard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^drawingblock_t)(CGContextRef, CGRect);


@interface BDView : UIView

- (void)drawWithBlock:(drawingblock_t) blk;


@end

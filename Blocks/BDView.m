//
//  BDView.m
//  Blocks
//
//  Created by Manuel on 4/04/13.
//  Copyright (c) 2013 Orchard. All rights reserved.
//

#import "BDView.h"


@interface BDView ()

@property (nonatomic, copy) drawingblock_t drawingBlock;

@end



@implementation BDView

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

 
*/

- (void)drawWithBlock:(drawingblock_t)blk
{
    self.drawingBlock = blk;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    if (self.drawingBlock)
    {
        self.drawingBlock(UIGraphicsGetCurrentContext(), rect);
    }
}

- (void)dealloc
{
    self.drawingBlock = nil;
    [super dealloc];
}

@end

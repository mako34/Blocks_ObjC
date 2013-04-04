//
//  MainViewController.m
//  Blocks
//
//  Created by Manuel on 4/04/13.
//  Copyright (c) 2013 Orchard. All rights reserved.
//

#import "MainViewController.h"

#import "MyClass.h"

#import "BDView.h"





@interface MainViewController ()

@property (nonatomic, retain) NSMutableArray *points;

@end

@implementation MainViewController



typedef int (^BlockTypeThatTakesTwoIntsAndReturnsInt) (int, int);
//equivalent to int(^)(int, int)

typedef void(^VVBlockType)(void);
//equivalent to void(^) (void)


typedef double(^BinaryOpBlock_t)(double, double);

// assign name to value
enum operations {sumar = 0, multiplicar};

typedef int(^iiblock_t)(int);


- (void)loadView
{
    self.view = [[BDView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    
    [self simpleBlock];

    
    MyClass *myClassObject = [[[MyClass alloc]initWithParams:@"paramMyStringa"]autorelease];
    
    
    [myClassObject blockWithCallBack:^(BOOL myBool) {
        NSLog(@"tha block called from finished timer");
        [self myMainVCTimer];
    }];
    
    
    
    //
    self.points = [NSMutableArray array];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawRandomLine:)];
    [self.view addGestureRecognizer:tap];
    
 }


- (void)drawRandomLine:(UITapGestureRecognizer *)tgr
{
    NSLog(@"drawRandomLine:");
    BDView *view = (BDView *)self.view;
    CGPoint touchPoint = [tgr locationInView:self.view];
    [self.points addObject:[NSValue valueWithCGPoint:touchPoint]];
    [view drawWithBlock:^(CGContextRef ctx, CGRect rect) {
        CGContextSetLineWidth(ctx, 3.0);
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(ctx, [self.points[0] CGPointValue].x, [self.points[0] CGPointValue].y);
        for ( int i = 1; i < self.points.count; i++)
        {
            CGContextAddLineToPoint(ctx, [self.points[i] CGPointValue].x, [self.points[i] CGPointValue].y);
        }
        CGContextStrokePath(ctx);
    }];
    
}

- (void)simpleBlock
{
    
    int (^sum)(int, int) = ^(int a, int b) { return a + b; }; // point here is that we're doing this inside main()!
    double x = 5.1, y = 7.3;
 
    double s = sum(x, y); // block invoked. Note we're passing arguments (x,y) whose type matches the block's parameters. Return type matches assigned variable (s) as well

    
    NSLog(@"the sum of %f and %f is %f", x, y, s);
    
    
    // define and invoke our block all in one go.
    double s2 = ^(double x, double y) { return x + y; }(x, y); // we're applying the arguments directly to the block literal!
    NSLog(@"the sum of %f and %f is s2:: %f", x, y, s2);
    
    //hello example
    void (^hw)(void) = ^{NSLog(@"hello, world!"); };
    
    hw();
    
    // block literal could also be written as
    //^(void){ NSLog(@"hello, world 345!"); }; //como lo llamo?
    //ver abajo! para empaquetar en funcion q espera un blocke! 
    
    
    // call function with block as param
    
    void (^hw2)(void) = ^{NSLog(@"hello, world pass this block!"); };

    func(hw2);

    
    // call function with block as inline block
    
    func(^{NSLog(@"my inline Block message"); });
    
    
    
    //block defined in typedef
    VVBlockType blah(VVBlockType);
    
    // calling BinaryOpBlock_t
    
    BinaryOpBlock_t suma = operation_creator(sumar); // option '0' represents addition
    
    NSLog(@"sum of 5.5 and 1.3 is %f", suma(5.5, 1.3));
    
    NSLog(@"product of 3.3 and 1.0 is %f", operation_creator(multiplicar)(3.3, 1.0)); // cool, we've composed the function invocation and the block invocation!
    
    // call function with params: array, int, block
    int a[] = {10, 20, 30, 40, 50, 60};
    func2(a, 6, ^(int x) { return x * 2; });
    
    NSLog(@"\n");
    
    int n = 10; // n declared and assigned
    func2(a, 6, ^(int x) { return x - n; } ); // n used in the block!
    
    NSLog(@"end of test simple blocks");
    NSLog(@"\n \n \n");
 }


//function that have a block as a parameter
void func(void (^b) (void)) // we do need to use an identifier in the parameter list now, of course
{
    NSLog(@"going to invoke the passed in block now.");
    b();
}


BinaryOpBlock_t operation_creator(int op)
{
    if (op == sumar)
        return ^(double x, double y) { return x + y; }; // addition block
    if (op == multiplicar)
        return ^(double x, double y) { return x * y; }; // multiplication block
    // ... etc.
    return nil;
}


void func2(int arr[], int size, iiblock_t formula)
{
    for ( int i = 0; i < size; i++ )
    {
        arr[i] = formula(arr[i]);
        NSLog(@"tu arraya en :: %d , tienes:: %d", i, arr[i]);
    }
    
}

//style timer with dispatch
- (void)myMainVCTimer
{
    NSLog(@"myMainVCTimer");
    
    int64_t delayInSeconds = 1;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self doAfterTimer];
            });
    
    // nota q solo poniendo :: dispatch_after, me da un delay!!
 
 
}

- (void)doAfterTimer
{
    NSLog(@"doAfterTimer");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

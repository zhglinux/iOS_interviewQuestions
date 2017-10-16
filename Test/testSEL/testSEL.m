//
//  testSEL.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "testSEL.h"
#import <objc/objc-runtime.h>


//http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown

@implementation testSEL

- (void)testStart
{
    NSLog(@"testSEL---> ......");
    
    SEL  mtytest;
    mtytest = @selector(methodTypeTest);
    
    NSLog(@"sel is: %@", NSStringFromSelector(mtytest));
    
    [self performSelector:mtytest];//why waring? PerformSelector may cause a leak because its selector is unknown
    //--> delete warning , do call deleteWarning
    [self deleteWarning];
    
    
    [self performSelector:@selector(methodTypeTest)];
    
    [self performSelector:@selector(methodTypeTest:) withObject:@"test"];
    
}

- (void)deleteWarning_01
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" [self.ticketTarget performSelector: self.ticketAction withObject: self];
#pragma clang diagnostic pop
    
}


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

- (void)deleteWarning_02
{
    SEL  mtytest;
    mtytest = @selector(methodTypeTest);
    SuppressPerformSelectorLeakWarning(
                                       [self performSelector:mtytest withObject:self]
                                       );
    
    /* //如果需要返回值：
     id result;
     SuppressPerformSelectorLeakWarning(
     result = [_target performSelector:_action withObject:self]
     );
     */
}


- (void)deleteWarning
{
    if (!self) { return; }
    SEL selector = NSSelectorFromString(@"methodTypeTest");
    IMP imp = [self methodForSelector:selector];
    
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
    
    
    IMP imp2 = class_getMethodImplementation([self class], selector);
    void (*func2)(id, SEL) = (void *)imp2;
    func2(self, selector);
    
    /*
     代码解释
     
     这一堆代码在做的事情其实是，向 controller 请求那个方法对应的 C 函数指针。所有的NSObject都能响应methodForSelector:这个方法，不过也可以用 Objective-C runtime 里的class_getMethodImplementation（只在 protocol 的情况下有用，id<SomeProto>这样的）。这种函数指针叫做IMP，就是typedef过的函数指针（id (*IMP)(id, SEL, ...)[1]）。它跟方法签名(signature)比较像，虽然可能不是完全一样。
     
     得到IMP之后，还需要进行转换，转换后的函数指针包含 ARC 所需的那些细节（比如每个 OC 方法调用都有的两个隐藏参数self和_cmd）。这就是代码第 4 行干的事（右边的那个(void *)只是告诉编译器，不用报类型强转的 warning）。
     
     最后一步，调用函数指针[2]。
     */
}

- (void)methodTypeTest
{
    NSLog(@"methodTypeTest");
}


- (void)methodTypeTest:(NSString*)aPara
{
    NSLog(@"methodTypeTest :  aPara = %@", aPara);
}

/*
 更复杂的例子
 
 如果 selector 接收参数，或者有返回值，代码就需要改改：
 
 SEL selector = NSSelectorFromString(@"processRegion:ofView:");
 IMP imp = [_controller methodForSelector:selector];
 CGRect (*func)(id, SEL, CGRect, UIView *) = (void *)imp;
 CGRect result = _controller ?
 func(_controller, selector, someRect, someView) : CGRectZero;
 为什么会有这个 warning
 
 原因是这样的：我们在 ARC 下调一个方法，runtime 需要知道对于返回值该怎么办。返回值可能有各种类型：void，int，char，NSString *，id等等。ARC 一般是根据返回值的头文件来决定该怎么办的[3]，一共有以下 4 种情况[4]：
 
 直接忽略（如果是基本类型比如 void，int这样的）。
 把返回值先 retain，等到用不到的时候再 release（最常见的情况）。
 不 retain，等到用不到的时候直接 release（用于 init、copy 这一类的方法，或者标注ns_returns_retained的方法）。
 什么也不做，默认返回值在返回前后是始终有效的（一直到最近的 release pool 结束为止，用于标注ns_returns_autoreleased的方法）。
 而调performSelector:的时候，系统会默认返回值并不是基本类型，但也不会 retain、release，也就是默认采取第 4 种做法。所以如果那个方法本来应该属于前 3 种情况，都有可能会造成内存泄漏。
 
 对于返回void或者基本类型的方法，就目前而言你可以忽略这个 warning，但这样做不一定安全。我看过 Clang 在处理返回值这块儿的几次迭代演进。一旦开着 ARC，编译器会觉得从performSelector:返回的对象没理由不能 retain，不能 release。在编译器眼里，它就是个对象。所以，如果返回值是基本类型或者void，编译器还是存在会 retain、release 它的可能，然后直接导致 crash。
 
 带参数调用
 
 类似地，performSelector:withObject:也会报同一个 warning，因为不指明怎么处理参数也会有同样的问题。ARC 允许为方法参数标注consumed，如果你调的方法有这种标注，最终可能导致把消息发给僵尸对象然后 crash。要解决这个问题可以用桥接（bridged casting），但是最好最简单的方法还是我上面写的用IMP和函数指针的方法。不过给参数标 consumed 是比较少见的，所以这个问题也不容易发生。
 
 静态 selector
 
 有趣的是，下面这种静态声明的 selector 就不会出 warning：
 
 [_controller performSelector:@selector(someMethod)];
 原因是，这种情况下编译器就能在编译阶段得到关于这个 selector 的全部信息，不需要默认任何事情。
 */

@end

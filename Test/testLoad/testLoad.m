//
//  testLoad.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "testLoad.h"



/*
 + (void)initialize
 Description
 Initializes the class before it receives its first message.
 The runtime sends initialize to each class in a program just before the class, or any class that inherits from it, is sent its first message from within the program. The runtime sends the initialize message to classes in a thread-safe manner. Superclasses receive this message before their subclasses. The superclass implementation may be called multiple times if subclasses do not implement initialize—the runtime will call the inherited implementation—or if subclasses explicitly call [super initialize]. If you want to protect yourself from being run multiple times, you can structure your implementation along these lines:
 + (void)initialize {
 if (self == [ClassName self]) {
 // ... do the initialization ...
 }
 }
 Because initialize is called in a thread-safe manner and the order of initialize being called on different classes is not guaranteed, it’s important to do the minimum amount of work necessary in initialize methods. Specifically, any code that takes locks that might be required by other classes in their initialize methods is liable to lead to deadlocks. Therefore you should not rely on initialize for complex initialization, and should instead limit it to straightforward, class local initialization.
 initialize is invoked only once per class. If you want to perform independent initialization for the class and for categories of the class, you should implement load methods.
 Availability	iOS (2.0 and later)
 Declared In	NSObject.h
 Reference	NSObject Class Reference
 
 */


/*
 + (void)load
 Description
 Invoked whenever a class or category is added to the Objective-C runtime; implement this method to perform class-specific behavior upon loading.
 The load message is sent to classes and categories that are both dynamically loaded and statically linked, but only if the newly loaded class or category implements a method that can respond.
 The order of initialization is as follows:
     All initializers in any framework you link to.
     All +load methods in your image.
     All C++ static initializers and C/C++ __attribute__(constructor) functions in your image.
     All initializers in frameworks that link to you.
 In addition:
     A class’s +load method is called after all of its superclasses’ +load methods.
     A category +load method is called after the class’s own +load method.
 In a custom implementation of load you can therefore safely message other unrelated classes from the same image, but any load methods implemented by those classes may not have run yet.
 Availability	iOS (2.0 and later)
 Declared In	NSObject.h
 Reference	NSObject Class Reference
 */




@implementation testLoad

+ (void)initialize
{
    
    NSLog(@"%@ , %s", [self class], __FUNCTION__);
}

@end


@implementation sub_testLoad



//+ (void)initialize
//{
//    NSLog(@"%@ , %s", [self class], __FUNCTION__);
//}



//<1.> + (void)load 会在类或者类的分类添加到 Objective-c runtime 时调用，该调用发生在 application:willFinishLaunchingWithOptions: 调用之前调用。
//<2.> 父类的 +load 方法先于子类的 +load 方法调用，类本身的 +load 方法调用先于分类的 +load 方法调用。

+ (void)load
{
    NSLog(@"%@ , %s", [self class], __FUNCTION__);
}

@end



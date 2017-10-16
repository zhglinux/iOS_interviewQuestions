//
//  RTLoadViewController.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "RTLoadViewController.h"

//define people
@interface People : NSObject

@end

@implementation People

+ (void)initialize {
    NSLog(@"%s", __FUNCTION__);
}

@end


//define student

@interface Student : People

@end

@implementation Student

//2.2 如果该类是子类，且该子类中没有实现 + (void)initialize 消息，或者子类显示调用父类实现 [super initialize], 那么则会调用其父类的实现。也就是说，父类的 + (void)initialize 可能会被调用多次。

+ (void)initialize {
    
    NSLog(@"%s", __FUNCTION__);
}

@end

// category for student

@interface Student (Score)

@end

@implementation Student (Score)

+ (void)initialize {
    //3.分类的 +initialize 方法会覆盖原类中 +initialize 方法
    NSLog(@"%s", __FUNCTION__);
}
@end


@interface RTLoadViewController ()

@end

@implementation RTLoadViewController

+ (void)initialize
{
    NSLog(@"%@ , %s", [self class], __FUNCTION__);
}

//1.

//+ (void)load
//{
//    NSLog(@"%@ , %s", [self class], __FUNCTION__);
//}


- (void)testEntry
{
    //4.子类会调用父类的 + initialize 方法。
     Student *student = [[Student alloc] init];
     NSLog(@"=>%@, %@ , %s", student, [self class], __FUNCTION__);
 
    //2.1 对于 runtime 而言，+ initialize 方法在程序生命周期内只会调用一次。
     Student *student2 = [[Student alloc] init];
     NSLog(@"=>%@, %@ , %s", student2, [self class], __FUNCTION__);
}





/*
 
 
 从上面的说明可以看出:
 
1. + (void)initialize 消息是在该类接收到其第一个消息之前调用。关于这里的第一个消息需要特别说明一下，对于 NSObject 的 runtime 机制而言，其在调用 NSObject 的 + (void)load 消息不被视为第一个消息，但是，如果像普通函数调用一样直接调用 NSObject 的 + (void)load 消息，则会引起 + (void)initialize 的调用。反之，如果没有向 NSObject 发送第一个消息，+ (void)initialize 则不会被自动调用。
2.1 在应用程序的生命周期中，runtime 只会向每个类发送一次 + (void)initialize 消息， 2.2 如果该类是子类，且该子类中没有实现 + (void)initialize 消息，或者子类显示调用父类实现 [super initialize], 那么则会调用其父类的实现。也就是说，父类的 + (void)initialize 可能会被调用多次。
3. 如果类包含分类，且分类重写了initialize方法，那么则会调用分类的 initialize 实现，而原类的该方法实现不会被调用，这个机制同 NSObject 的其他方法(除 + (void)load 方法) 一样，即如果原类同该类的分类包含有相同的方法实现，那么原类的该方法被隐藏而无法被调用。
4. 父类的 initialize 方法先于子类的 initialize 方法调用。

 */




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

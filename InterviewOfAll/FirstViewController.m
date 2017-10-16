//
//  FirstViewController.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "FirstViewController.h"

#import "testSEL.h"
#import "testLoad.h"
#import "RTLoadViewController.h"
#import "UIButton+block.h"
#import "UIView+testCategory.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"--🔴------------------------------------------");
    
    [NSObject load];
        NSLog(@"--------2️⃣------------------------------------");
//    [sub_testLoad load];
    
    //2
    RTLoadViewController * upView = [[RTLoadViewController alloc] init];
    [upView testEntry];
    
    //3
    [self.view addSubview: [UIButton createBtnWithFrame:CGRectMake(0, 100, 370, 30) title:@"test" actionBlock:^(UIButton *button) {
         NSLog(@"--%s-", __FUNCTION__);
    }]];
    
    //4
    UIView *myView = [[UIView alloc] init];
    myView.firstView = [[UIView alloc] init];
    myView.firstView.tag = 12;
    NSLog(@"The view tag is %ld", myView.firstView.tag);
    
    NSLog(@"--🔴------------------------------------------");
    
    testSEL * tmp = [[testSEL alloc] init];
    [tmp testStart];
    
    NSLog(@"--🔴------------------------------------------");
    
    
    NSLog(@"--🔴------------------------------------------");
    
    
    NSLog(@"--🔴------------------------------------------");
    
    
    NSLog(@"--🔴------------------------------------------");
    
    
    NSLog(@"--🔴------------------------------------------");
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

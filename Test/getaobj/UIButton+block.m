//
//  UIButton+block.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/objc-runtime.h>

static NSString *keyOfMethod;
static NSString *keyOfBlock;

@implementation UIButton (block)

+ (void)load
{
    NSLog(@"-->%@, %s", [self class], __FUNCTION__ );
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock
{
    UIButton *button = [[UIButton alloc]init];
    button.frame = frame;
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject (button , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return button;
}


- (void)buttonClick:(UIButton *)button{
    
    //通过key获取被关联对象
    //objc_getAssociatedObject(id object, const void *key)
    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(button, &keyOfMethod);
    if(block1){
        block1(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyOfBlock);
    if(block2){
        block2(button);
    }
}

- (void)setActionBlock:(ActionBlock)actionBlock{
    objc_setAssociatedObject (self, &keyOfBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (ActionBlock)actionBlock{
    return objc_getAssociatedObject (self ,&keyOfBlock);
}

@end

//
//  UIButton_MY.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "UIButton_MY.h"
#import <objc/objc-runtime.h>

@implementation UIButton_MY

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//#pragma mark - 获取苹果私有的APi方法
- (void)getiOSPrivateAPi
{

    NSString *className = NSStringFromClass([UIView class]);

    const char  *cClassName = [className UTF8String];

    id theClass = objc_getClass(cClassName);

    unsigned int outCount;

        Method *m =  class_copyMethodList(theClass,&outCount);
        
        NSLog(@"%d",outCount);
        
        for (int i = 0; i<outCount; i++)
        {
            
            SEL a = method_getName(*(m+i));
            
            NSString *sn = NSStringFromSelector(a);
            
            NSLog(@"%@",sn);
        }
}

@end

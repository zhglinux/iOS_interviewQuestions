//
//  UIView+testCategory.m
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "UIView+testCategory.h"
#import <objc/objc-runtime.h>

@implementation UIView (testCategory)

-(void) setFirstView:(UIView *)firstView
{
    objc_setAssociatedObject(self, @selector(firstView), firstView, OBJC_ASSOCIATION_RETAIN);
}

-(UIView *) firstView
{
    return objc_getAssociatedObject(self, @selector(firstView));
}


@end

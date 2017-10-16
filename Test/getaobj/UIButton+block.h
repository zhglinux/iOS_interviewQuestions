//
//  UIButton+block.h
//  InterviewOfAll
//
//  Created by ST13891 on 2017/10/16.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *button);


@interface UIButton (block)


+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock;

@end

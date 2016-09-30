//
//  UITextField+BRTextField.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/26.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "UITextField+BRTextField.h"
#import <objc/message.h>

@implementation UITextField (BRTextField)

@dynamic placeholderColor;


+ (void)load
{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method setBRPlaceholder = class_getInstanceMethod(self, @selector(setBR_Placeholder:));
    
    method_exchangeImplementations(setPlaceholder, setBRPlaceholder);
}



- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}



- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UITextField *textField = [self valueForKey:@"placeholderLabel"];
    
    textField.textColor    = placeholderColor;
}



- (void)setBR_Placeholder:(NSString *)placeholder
{
    [self setBR_Placeholder:placeholder];

    self.placeholderColor = self.placeholderColor;
}


@end

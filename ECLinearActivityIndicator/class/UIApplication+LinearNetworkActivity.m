//
//  UIApplication+LinearNetworkActivity.m
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import "UIApplication+LinearNetworkActivity.h"
#import "ECLinearActivityIndicatorView.h"
#import "UIViewController+LinearNetworkActivity.h"
#import "ECMacro.h"

@interface UIApplication()

@property (nonatomic, strong) UIWindow *indicatorWindow;
@property (nonatomic, strong) ECLinearActivityIndicatorView *linearView;

@end

@implementation UIApplication (LinearNetworkActivity)

- (void)configureLinearNetworkActivityIndicatorIfNeeded {
    if (@available(iOS 11.0, *)) {
        // 判断是否为 iPhone X
        UIWindow *window = self.windows.firstObject;
        if (window.safeAreaInsets.top > 0.0) {
            [self _configureLinearNetworkActivityIndicator];
        }
    }
}

- (void)_configureLinearNetworkActivityIndicator {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Class class = [self class];
        SEL originalSelector = @selector(setNetworkActivityIndicatorVisible:);
        SEL swizzledSelector = @selector(ec_setNetworkActivityIndicatorVisible:);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
        EC_Objc_exchangeMethodAToB(originalSelector, swizzledSelector);
    });
    [UIViewController configureLinearNetworkActivityIndicator];
}

- (void)ec_setNetworkActivityIndicatorVisible:(BOOL)visible {
    // 先调用原方法
    [self ec_setNetworkActivityIndicatorVisible:visible];
    
    if (visible) {
        if (self.indicatorWindow == nil) {
            self.indicatorWindow = [[UIWindow alloc] initWithFrame:self.statusBarFrame];
            self.indicatorWindow.hidden = NO;
            self.indicatorWindow.windowLevel = UIWindowLevelStatusBar + 1;
            
            CGRect frame = CGRectMake(self.indicatorWindow.frame.size.width - 74, 6, 44, 4);
            self.linearView = [[ECLinearActivityIndicatorView alloc] initWithFrame: frame];
            self.linearView.hidesWhenStopped = NO;
            [self.linearView startAnimating];
            [self.indicatorWindow addSubview:self.linearView];
        }
    }

    if (!self.linearView) {
        return;
    }
    self.linearView.tintColor = (self.statusBarStyle == UIStatusBarStyleDefault) ? [UIColor blackColor] : [UIColor whiteColor];
    
    if (visible) {
        self.indicatorWindow.hidden = self.isStatusBarHidden;
        self.linearView.hidden = NO;
        self.linearView.alpha = 1;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.linearView.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.linearView.hidden = !self.isNetworkActivityIndicatorVisible;
                [self ecUpdateNewworkActivityIndicatorAppearance];
            }
        }];
    }
}

- (void)ecUpdateNewworkActivityIndicatorAppearance {
    self.indicatorWindow.hidden = !self.isNetworkActivityIndicatorVisible || self.isStatusBarHidden;
}

- (void)setIndicatorWindow:(UIWindow *)indicatorWindow {
    EC_Objc_setObj(@selector(indicatorWindow), indicatorWindow);
}

- (UIWindow *)indicatorWindow {
    NSLog(@"==%@: ", EC_Objc_getObj);
    return EC_Objc_getObj;
}

- (void)setLinearView:(ECLinearActivityIndicatorView *)linearView {
    EC_Objc_setObj(@selector(linearView), linearView);
}

- (ECLinearActivityIndicatorView *)linearView {
    return EC_Objc_getObj;
}

@end



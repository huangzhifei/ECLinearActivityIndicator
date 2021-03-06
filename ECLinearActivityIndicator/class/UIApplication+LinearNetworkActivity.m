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

@interface UIApplication ()

@property (nonatomic, strong) UIWindow *indicatorWindow;
@property (nonatomic, strong) ECLinearActivityIndicatorView *linearView;
@property (nonatomic, assign) NSInteger visibleCount;

@end

@implementation UIApplication (LinearNetworkActivity)

- (void)configureLinearNetworkActivityIndicatorIfNeeded {
    [self _configureLinearNetworkActivityIndicator];
}

- (void)_configureLinearNetworkActivityIndicator {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.visibleCount = 0;
        SEL originalSelector = @selector(setNetworkActivityIndicatorVisible:);
        SEL swizzledSelector = @selector(ec_setNetworkActivityIndicatorVisible:);
        EC_Objc_exchangeMethodAToB(originalSelector, swizzledSelector);
    });
    [UIViewController configureLinearNetworkActivityIndicator];
}

- (void)ec_setNetworkActivityIndicatorVisible:(BOOL)visible {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (visible) {
            self.visibleCount ++;
        } else if (!visible && self.visibleCount > 0) {
            self.visibleCount --;
        }
        BOOL show = self.visibleCount > 0 ? YES : NO;
        // 先调用原方法
        [self ec_setNetworkActivityIndicatorVisible:show];

        if (show) {
            if (@available(iOS 11.0, *)) {
                // 判断是否为 iPhone X，如果是就加载线型动画
                UIWindow *window = self.windows.firstObject;
                if (window.safeAreaInsets.top > 0.0) {
                    if (self.indicatorWindow == nil) {
                        self.indicatorWindow = [[UIWindow alloc] initWithFrame:self.statusBarFrame];
                        // 对于 UIWindows 只需要改变 zIndex 就行
                        self.indicatorWindow.windowLevel = UIWindowLevelStatusBar + 1;
                        
                        CGRect frame = CGRectMake(self.indicatorWindow.frame.size.width - 74, 6, 44, 4);
                        self.linearView = [[ECLinearActivityIndicatorView alloc] initWithFrame:frame];
                        self.linearView.hidesWhenStopped = NO;
                        [self.linearView startAnimating];
                        [self.indicatorWindow addSubview:self.linearView];
                    }
                }
            }
        }

        if (!self.linearView) {
            return;
        }
        self.linearView.tintColor = (self.statusBarStyle == UIStatusBarStyleDefault) ? [UIColor blackColor] : [UIColor whiteColor];

        if (show) {
            self.indicatorWindow.hidden = self.isStatusBarHidden;
            self.linearView.hidden = NO;
            self.linearView.alpha = 1;
        } else {
            [UIView animateWithDuration:0.5
                animations:^{
                    self.linearView.alpha = 0;
                }
                completion:^(BOOL finished) {
                    if (finished) {
                        self.linearView.hidden = !(self.visibleCount > 0);
                        [self ecUpdateNewworkActivityIndicatorAppearance];
                    }
                }];
        }
    });
}

- (void)ecUpdateNewworkActivityIndicatorAppearance {
    self.indicatorWindow.hidden = !(self.visibleCount > 0) || self.isStatusBarHidden;
}

#pragma mark - getter & setter

- (void)setVisibleCount:(NSInteger)visibleCount {
    EC_Objc_setObj(@selector(visibleCount), @(visibleCount));
}

- (NSInteger)visibleCount {
    return [EC_Objc_getObj integerValue];
}

- (void)setIndicatorWindow:(UIWindow *)indicatorWindow {
    EC_Objc_setObj(@selector(indicatorWindow), indicatorWindow);
}

- (UIWindow *)indicatorWindow {
    return EC_Objc_getObj;
}

- (void)setLinearView:(ECLinearActivityIndicatorView *)linearView {
    EC_Objc_setObj(@selector(linearView), linearView);
}

- (ECLinearActivityIndicatorView *)linearView {
    return EC_Objc_getObj;
}

@end



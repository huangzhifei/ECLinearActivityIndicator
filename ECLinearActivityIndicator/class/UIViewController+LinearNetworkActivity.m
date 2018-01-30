//
//  UIViewController+LinearNetworkActivity.m
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import "UIViewController+LinearNetworkActivity.h"
#import "UIApplication+LinearNetworkActivity.h"
#import "ECMacro.h"

@implementation UIViewController (LinearNetworkActivity)

+ (void)configureLinearNetworkActivityIndicator {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        EC_Objc_exchangeMethodAToB(@selector(setNeedsStatusBarAppearanceUpdate),
                                   @selector(ec_setNeedsStatusBarAppearanceUpdate));
    });
}

- (void)ec_setNeedsStatusBarAppearanceUpdate {
    [self ec_setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] ecUpdateNewworkActivityIndicatorAppearance];
}

@end

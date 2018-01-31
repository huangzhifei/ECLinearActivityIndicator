//
//  UIApplication+LinearNetworkActivity.h
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LinearNetworkActivity)

/// 不影响正常的系统菊花转子的使用，当是 iPhone X 的时候，就会自动添加线型网络加载动画
/// 里面自带计数功能，对于同时多个异步网络请求，不用担心在哪个异步回调里面去关闭加载动画了
/// 正常在开始请求时 setNetworkActivityIndicatorVisible 为 YES，结束时置为 NO
/// 更多的看 README.md
- (void)configureLinearNetworkActivityIndicatorIfNeeded;

- (void)ecUpdateNewworkActivityIndicatorAppearance;

@end

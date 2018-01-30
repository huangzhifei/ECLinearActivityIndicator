//
//  ECLinearActivityIndicatorView.h
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECLinearActivityIndicatorView : UIView

// 默认是 1.5s
@property (nonatomic, assign) CGFloat duration;

// 默认是 YES
@property (nonatomic, assign) BOOL hidesWhenStopped;

- (void)startAnimating;

- (void)stopAnimating;

- (BOOL)isAnimating;

@end

//
//  ViewController.m
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import "ViewController.h"
#import "ECLinearActivityIndicatorView.h"

@interface ViewController ()

@property (nonatomic, strong) ECLinearActivityIndicatorView *indicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat centerX = self.view.bounds.size.width * 0.5 - 30;
    self.indicatorView = [[ECLinearActivityIndicatorView alloc] initWithFrame:CGRectMake(centerX, 400, 60, 8)];
//    self.indicatorView.backgroundColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.indicatorView];
}

- (IBAction)startNetwork:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = ![UIApplication sharedApplication].isNetworkActivityIndicatorVisible;
}

- (IBAction)startAnimation:(id)sender {
    if (self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
    } else {
        [self.indicatorView startAnimating];
    }
}

@end

//
//  ViewController.m
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)startNetwork:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = ![UIApplication sharedApplication].isNetworkActivityIndicatorVisible;
}

@end

//
//  ViewController.m
//  Test_手势解锁
//
//  Created by admin on 15-1-15.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()<viewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestView *view = [[TestView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    
}

#pragma viewDelegate
-(void)endMoveView:(TestView *)view andPassword:(NSString *)password
{
    //TODO:
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.h
//  Test_手势解锁
//
//  Created by admin on 15-1-15.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, listType)
{
    helloword,
};

@interface ViewController : UIViewController

@property (nonatomic) listType typene;

@end


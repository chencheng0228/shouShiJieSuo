//
//  TestView.h
//  Test_手势解锁
//
//  Created by admin on 15-1-15.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestView;
@protocol viewDelegate <NSObject>
@optional

-(void)endMoveView:(TestView *)view andPassword:(NSString *)password;

@end

@interface TestView : UIView

@property (nonatomic,weak)id<viewDelegate>delegate;

@end

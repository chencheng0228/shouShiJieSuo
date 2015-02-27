//
//  TestView.m
//  Test_手势解锁
//
//  Created by admin on 15-1-15.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "TestView.h"

@interface TestView ()

@property(nonatomic,strong)NSMutableArray *buttons;

@property CGPoint currentPoint;
@end


@implementation TestView

-(NSMutableArray*)buttons
{
    if (_buttons==nil) {
        _buttons = [NSMutableArray array];
    }
       return _buttons;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}

//此方法在从xib文件加载的时候会调用
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int i=0; i<self.buttons.count; i++) {
        if (i==0) {
            UIButton *button = self.buttons[i];
            //起点哦............... ---------------- ==================
            CGContextMoveToPoint(ctx, button.center.x, button.center.y);
        }
        else{
            UIButton *button = self.buttons[i];
            CGContextAddLineToPoint(ctx, button.center.x, button.center.y);
        }
    }
    
    //当所有按钮的中点都连接好之后，再连接手指当前的位置
    //判断数组中是否有按钮，只有有按钮的时候才绘制
         if (self.buttons.count !=0) {
                 CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
             }
    CGContextSetLineWidth(ctx, 10);
    CGContextSetRGBStrokeColor(ctx, 20/255.0, 107/255.0, 153/255.0, 1);
    //线只有空心的
    CGContextStrokePath(ctx);
}



//在界面上创建9个按钮
 -(void)setup
 {
 //1.创建9个按钮
 for (int i=0; i<9; i++) {
         UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
         //2.设置按钮的状态背景
         [btn setBackgroundImage:[UIImage imageNamed:@"4.jpg"] forState:UIControlStateNormal];
         [btn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateSelected];
         //3.把按钮添加到视图中
         [self  addSubview:btn];
         //4.禁止按钮的点击事件
         btn.userInteractionEnabled=NO;
     }
}

//设置按钮的frame
 -(void)layoutSubviews
 {
     
 //需要先调用父类的方法  
 [super layoutSubviews];
 for (int i=0; i<self.subviews.count; i++) {
         //取出按钮
         UIButton *btn=self.subviews[i];

         //九宫格法计算每个按钮的frame
         CGFloat row = i/3;
         CGFloat loc = i%3;
         CGFloat btnW=74;
         CGFloat btnH=74;
         CGFloat padding=(self.frame.size.width-3*btnW)/4;
         CGFloat btnX=padding+(btnW+padding)*loc;
         CGFloat btnY=padding+(btnW+padding)*row;
         btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
     }
     }


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint startPoint = [self getCurrentPoint:touches];
    UIButton *btn = [self getCurrentBtnWithPoint:startPoint];
    if (btn&&btn.selected==NO) {
        btn.selected = YES;
        [self.buttons addObject:btn];
    }
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint startPoint = [self getCurrentPoint:touches];
    UIButton *btn = [self getCurrentBtnWithPoint:startPoint];
    if (btn&&btn.selected==NO) {
        btn.selected = YES;
        [self.buttons addObject:btn];
    }
    
    //记录当前点（不在按钮的范围内）
    self.currentPoint=startPoint;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint  poin = [touch locationInView:self];
    NSLog(@"%f===%f",poin.x,poin.y);
    
    
    if ([self.delegate respondsToSelector:@selector(endMoveView:andPassword:)]) {
        [self.delegate endMoveView:self andPassword:@"1234567"];
    }
    [self performSelector:@selector(doSomething) withObject:nil afterDelay:1];
    
}
-(void)doSomething
{
    [self.buttons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.buttons removeAllObjects];
    [self setNeedsDisplay];
    
    //清空当前点
    self.currentPoint=CGPointZero;
    NSLog(@"end===========end");
}

//对功能点进行封装
-(CGPoint)getCurrentPoint:(NSSet *)touches
{
     UITouch *touch=[touches anyObject];
     CGPoint point=[touch locationInView:touch.view];
     return point;
}


//通过point来获取对应的button
-(UIButton *)getCurrentBtnWithPoint:(CGPoint)point
 {
         for (UIButton *btn in self.subviews) {
                 if (CGRectContainsPoint(btn.frame, point)) {
                         return btn;
                     }
             
             }
         return Nil;
}
@end

//
//  LXAlertView.m
//  LXAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define kAlertWidth 250.0f
#define kAlertHeight 175.0f

#import "LXAlertView.h"
#import "LXPasswordView.h"


@interface LXAlertView ()<LXPasswordViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;//alertView背景颜色
@property (nonatomic, strong) UIView *overlayView;//蒙层颜色
@property (nonatomic, strong) LXPasswordView *passwordView;

@end

@implementation LXAlertView

- (id)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];

        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight)];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backgroundView];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight - 60)];
        label.text = @"请输入密码";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        [_backgroundView addSubview:label];
    
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kAlertWidth - 50, 0, 50, 50)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:button];
        
        _passwordView = [[LXPasswordView alloc]initWithFrame:CGRectMake(0, kAlertHeight - 60, kAlertWidth, 60)];
        _passwordView.delegate = self;
        [_backgroundView addSubview:_passwordView];
    }
    return self;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[UIView alloc]initWithFrame:[self appRootViewController].view.bounds];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.6f;
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _overlayView;
}

- (void)buttonAction {
    [self removeFromSuperview];
}

#pragma mark LXPasswordViewDelegate;
- (void)LXPasswordView:(LXPasswordView *)lxPasswordView result:(NSString *)result {
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(lxAlertView:object:)]) {
        [_delegate lxAlertView:self object:result];
    }
}

#pragma mark - show
- (void)show {
    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [self setStartState];
    UIViewController *topVC = [self appRootViewController];
    [topVC.view addSubview:self];
}

-(void)setStartState {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
}

-(void)setEndState {
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    //如果是模态.
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)removeFromSuperview {
    [_overlayView removeFromSuperview];
    _overlayView = nil;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setStartState];
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }
    
    [[self appRootViewController].view addSubview:self.overlayView];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setEndState];
    } completion:^(BOOL finished) {
        
    }];
    
    [super willMoveToSuperview:newSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

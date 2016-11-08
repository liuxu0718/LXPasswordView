//
//  ViewController.m
//  LXPasswordView
//
//  Created by liuxu on 2016/11/8.
//  Copyright © 2016年 liuxu. All rights reserved.
//

#import "ViewController.h"
#import "LXPasswordView.h"
#import "LXAlertView.h"

@interface ViewController ()<LXPasswordViewDelegate, LXAlertViewDelegate>

@property (nonatomic, strong) LXPasswordView *passwordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    _passwordView = [[LXPasswordView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    _passwordView.delegate = self;
//    _passwordView.isDisplay = YES;
    [self.view addSubview:_passwordView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    button.center = self.view.center;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"alert样式" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction {
    LXAlertView *alert = [[LXAlertView alloc]init];
    alert.delegate = self;
    [alert show];
}

- (void)lxAlertView:(LXAlertView *)alertView object:(NSString *)object {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:object message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)LXPasswordView:(LXPasswordView *)lxPasswordView result:(NSString *)result {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:result message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

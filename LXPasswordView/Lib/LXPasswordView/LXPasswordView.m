//
//  LXPasswordView.m
//  LXPasswordView
//
//  Created by liuxu on 2016/11/8.
//  Copyright © 2016年 liuxu. All rights reserved.
//

#import "LXPasswordView.h"

@interface LXPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation LXPasswordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _isDisplay = NO;
        
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField becomeFirstResponder];
        [_textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
        
        CGFloat labelWidth = (frame.size.width - 90) / 6;
        CGFloat labelHeight = 48;
        for (int i = 0; i < 6; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20 + (labelWidth + 10) * i, 0, labelWidth, labelHeight)];
            button.tag = 100 + i;
            button.backgroundColor = [UIColor whiteColor];
            button.layer.cornerRadius = 5;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:button];
#warning 演示demo使用 根据项目需求注释掉此段代码
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)buttonAction {
    [_textField becomeFirstResponder];
}

- (void)textFieldAction:(UITextField *)textField {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < textField.text.length; i++) {
        NSString *string = [NSString stringWithFormat:@"%c", [textField.text characterAtIndex:i]];
        [dataArray addObject:string];
    }
//    NSLog(@"%@", dataArray);
    
    for (UIButton *button in self.subviews) {
        if (button.tag >= 100) {
            if (button.tag - 99 <= dataArray.count) {
                if (_isDisplay) {
                    [button setTitle:dataArray[button.tag - 100] forState:UIControlStateNormal];
                } else {
                    [button setImage:[UIImage imageNamed:@"icon_black"] forState:UIControlStateNormal];
                }
            } else {
                if (_isDisplay) {
                    [button setTitle:@"" forState:UIControlStateNormal];
                } else {
                    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
    }
    
    if (textField.text.length == 6) {
        if ([_delegate respondsToSelector:@selector(LXPasswordView:result:)]) {
            [_delegate LXPasswordView:self result:_textField.text];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger contentLength = textField.text.length - range.length +string.length;
    return (contentLength <= 6);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

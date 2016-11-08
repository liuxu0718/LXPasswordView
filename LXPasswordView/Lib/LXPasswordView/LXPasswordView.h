//
//  LXPasswordView.h
//  LXPasswordView
//
//  Created by liuxu on 2016/11/8.
//  Copyright © 2016年 liuxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXPasswordView;

@protocol LXPasswordViewDelegate <NSObject>

- (void)LXPasswordView:(LXPasswordView *)lxPasswordView result:(NSString *)result;

@end

@interface LXPasswordView : UIView

//default NO. if YES display
@property (nonatomic, assign) BOOL isDisplay; //是否显式输入

@property (nonatomic, weak) id<LXPasswordViewDelegate> delegate;

@end

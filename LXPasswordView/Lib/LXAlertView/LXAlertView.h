//
//  LXAlertView.h
//  LXAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXAlertView;

@protocol LXAlertViewDelegate <NSObject>

- (void)lxAlertView:(LXAlertView *)alertView object:(NSString *)object;

@end

@interface LXAlertView : UIView

@property(nonatomic, weak) id<LXAlertViewDelegate> delegate;

///show
- (void)show;

@end

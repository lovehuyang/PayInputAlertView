//
//  PayInputAlertView.h
//  PayInputAlertView
//
//  Created by tzsoft on 2017/12/13.
//  Copyright © 2017年 HLY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger ,PayInputAlertView_Type){
    PayInputAlertView_Auto,// 自动验证
    PayInputAlertView_Hand,// 手动验证
};
@interface PayInputAlertView : UIView<UITextFieldDelegate>

/**
 创建弹框

 @param frame 坐标
 @param title 标题
 @param subTitle 副标题
 @param type 类型
 @param buttonArr 按钮数组
 @return 返回控件
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle type:(PayInputAlertView_Type)type buttonArr:(NSArray *)buttonArr;

/**
 手动验证的方法
 */
@property (nonatomic ,strong)void(^verifyPassWordHand)(NSString *password,UIButton *button);

/**
 自动验证的方法
 */
@property (nonatomic ,strong)void(^verifyPassWordAuto)(NSString *password);

@end

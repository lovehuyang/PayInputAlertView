# PayInputAlertView
先看两张效果图

![](https://github.com/lovehuyang/PayInputAlertView/blob/master/PayInputAlertView/Image/1.png)![](https://github.com/lovehuyang/PayInputAlertView/blob/master/PayInputAlertView/Image/2.png)

自定义支付密码输入框分为两种样式
```
typedef  NS_ENUM(NSInteger ,PayInputAlertView_Type){
    PayInputAlertView_Auto,// 自动验证
    PayInputAlertView_Hand,// 手动验证
};
```
* 弹框创建方法
```
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
```
* 两种弹框的回调方法
```
/**
 手动验证的方法
 */
@property (nonatomic ,strong)void(^verifyPassWordHand)(NSString *password,UIButton *button);

/**
 自动验证的方法
 */
@property (nonatomic ,strong)void(^verifyPassWordAuto)(NSString *password);
```

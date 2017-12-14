//
//  PayInputAlertView.m
//  PayInputAlertView
//
//  Created by tzsoft on 2017/12/13.
//  Copyright © 2017年 HLY. All rights reserved.
//

#import "PayInputAlertView.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define DEFAULTFONT(SIZE)  [UIFont systemFontOfSize:SIZE]
#define TextRedColor [UIColor redColor]
#define LineColor [UIColor lightGrayColor]
#define DefaultBGColor [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f]
#define  boxWidth  40          //密码框的宽度

@implementation PayInputAlertView
{
    PayInputAlertView_Type _type;// 弹框类型
    NSArray *_buttonArr;// 按钮数组
    //黑色半透明背景
    UIView *_viewBG;
    // 视图
    UIView *_view;
    
    // 接受密码输入的文本框，看不见
    UITextField *_TF;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle type:(PayInputAlertView_Type)type buttonArr:(NSArray *)buttonArr{
    if(self == [super initWithFrame:frame]) {
        _type = type;
        _buttonArr = [NSArray arrayWithArray:buttonArr];
        [self setupUIWithTitle:title WithSubTitle:subTitle];
    }
    return self;
}

-(void)setupUIWithTitle:(NSString *)title WithSubTitle:(NSString *)subTitle{
    
    // 蒙版
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    viewBG.backgroundColor = [UIColor blackColor];
    viewBG.alpha = 0.6;
    viewBG.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    [viewBG addGestureRecognizer:tap];
    _viewBG = viewBG;
    [self addSubview:_viewBG];
    
    // 输入密码View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 160 )];
    view.center = CGPointMake(viewBG.center.x, viewBG.frame.size.height/5*2);
    [view.layer setCornerRadius:3];
    [view.layer setMasksToBounds:YES];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    _view = view;
    [self addSubview:_view];
    
    // 标题
    UILabel *lable_title = [[UILabel alloc]init];
    lable_title.frame = CGRectMake(10, 20, view.frame.size.width-20, 15);
    lable_title.text = [NSString stringWithFormat:@"%@",title];
    lable_title.textAlignment=1;
    lable_title.font = DEFAULTFONT(15);
    lable_title.textColor = [UIColor darkGrayColor];
    [_view addSubview:lable_title];
    
    // 二级标题
    UILabel *lable_subTitle = [[UILabel alloc]init];
    lable_subTitle.frame = CGRectMake(10, lable_title.frame.origin.y+lable_title.frame.size.height+20, view.frame.size.width-20, 20);
    lable_subTitle.text = [NSString stringWithFormat:@"%@",subTitle];
    lable_subTitle.textAlignment=1;
    lable_subTitle.font = DEFAULTFONT(20);
    lable_subTitle.textColor = TextRedColor;
    [_view addSubview:lable_subTitle];
    if([[NSString stringWithFormat:@"%@",subTitle] isEqualToString:@""]) {
        lable_subTitle.frame = CGRectMake(10, lable_title.frame.origin.y+lable_title.frame.size.height, view.frame.size.width-20, 0);
    }
    
    // TF文本框
    _TF = [[UITextField alloc]init];
    _TF.frame = CGRectMake(0, 0, 0, 0);
    _TF.delegate = self;
    _TF.keyboardType=UIKeyboardTypeNumberPad;
    [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_view addSubview:_TF];
    
    //  假的输入框和假的密码点
    for (int i = 0; i < 6; i ++) {
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake((view.frame.size.width-boxWidth*6)/2 + boxWidth *i - i * 0.5, CGRectGetMaxY(lable_subTitle.frame)+20, boxWidth, boxWidth);
        tempView.backgroundColor = DefaultBGColor;
        tempView.layer.borderColor = [LineColor CGColor];
        [tempView.layer setBorderWidth:0.5];
        tempView.tag = 10 + i;
        [_view addSubview:tempView];
        
        UILabel *tempLab = [[UILabel alloc]init];
        tempLab.frame = CGRectMake((boxWidth-10)/2, (boxWidth-10)/2, 10, 10);
        [tempLab.layer setCornerRadius:5];
        [tempLab.layer setMasksToBounds:YES];
        tempLab.backgroundColor = [UIColor blackColor];
        [tempLab setHidden:YES];
        [tempView addSubview:tempLab];
    }

    if(_buttonArr.count>0 && _type == PayInputAlertView_Hand) {
        CGRect viewFrame = _view.frame;
        viewFrame.size.height +=30;
        _view.frame = viewFrame;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lable_subTitle.frame)+20 +15 + boxWidth, view.frame.size.width, 0.5)];
        line.backgroundColor = LineColor;
        [view addSubview:line];
        for(int i=0;i<_buttonArr.count;i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0+(view.frame.size.width/_buttonArr.count)*i, CGRectGetMaxY(line.frame), view.frame.size.width/_buttonArr.count, view.frame.size.height-CGRectGetMaxY(line.frame));
            [btn setTitleColor:[UIColor darkGrayColor] forState:0];
            btn.backgroundColor = [UIColor clearColor];
            btn.titleLabel.font = DEFAULTFONT(15);
            [btn setTitle:[_buttonArr objectAtIndex:i] forState:0];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + i;
            [view addSubview:btn];
            if(i == _buttonArr.count-1) {//选取最后一个设置按钮为确定-----红色
                [btn setTitleColor:[UIColor redColor] forState:0];
            } else {
                UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width/_buttonArr.count)*(i+1), CGRectGetMaxY(line.frame), 0.5, view.frame.size.height-CGRectGetMaxY(line.frame))];
                line1.backgroundColor = LineColor;
                [view addSubview:line1];
            }
            
        }
        
    }
    [self show];
}
#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn {
    // 手动验证
    self.verifyPassWordHand(_TF.text, btn);
    [self removeFromView];
}

#pragma mark - 文本框内容发生改变
- (void) textFieldDidChange:(UITextField*) sender {
    UITextField *_field = sender;
    
    for (int i = 0; i < 6; i ++) {
//        NSLog(@"下标：%d - 文字长度：%lu - 文本框内容：%@",i,_field.text.length,sender.text);
        UIView *tempView = (UIView *)[_view viewWithTag:10 + i];
        UILabel *tempLab = (UILabel *)[[tempView subviews] firstObject];
        if (i < _field.text.length) {
               tempLab.hidden = NO;
        }else{
            tempLab.hidden = YES;
        }
    }

    if(_type == PayInputAlertView_Auto) {//自动验证
        if (_field.text.length==6){
            // 延迟执行
            if (@available(iOS 10.0, *)) {
                [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    [self autoVerifyPassWord:_field.text];
                }];
            } else {

            }
        }
    } else {//非自动验证
        if(_field.text.length>6){
            //截取前6个字符
            _field.text = [_field.text substringToIndex:6];
        }
    }
}

// 自动验证
- (void)autoVerifyPassWord:(NSString *)passWord{
    [self removeFromView];
    self.verifyPassWordAuto(passWord);
}

- (void)show {
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [_TF becomeFirstResponder];
    _view.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    [UIView animateWithDuration:.5f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

    } completion:nil];
}

#pragma mark - 移除
- (void)removeFromView {
    [_TF resignFirstResponder];
    _view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:.5f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _view.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _view.alpha = 0;
        _viewBG.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

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
    // 标题
    UILabel *_lable_title;
    // 二级标题
    UILabel *_lable_subTitle;
    // 真正接受密码输入的框   看不见
    UITextField *_TF;
    // 可见的输入框
    UIView *_view_box1;
    UIView *_view_box2;
    UIView *_view_box3;
    UIView *_view_box4;
    UIView *_view_box5;
    UIView *_view_box6;
    // 密码点
    UILabel *_lable_point1;
    UILabel *_lable_point2;
    UILabel *_lable_point3;
    UILabel *_lable_point4;
    UILabel *_lable_point5;
    UILabel *_lable_point6;
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
    //蒙版
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    viewBG.backgroundColor = [UIColor blackColor];
    viewBG.alpha = 0.2;
    viewBG.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    [viewBG addGestureRecognizer:tap];
    _viewBG = viewBG;
    [self addSubview:_viewBG];
    //输入密码View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 160 )];
    view.center = CGPointMake(viewBG.center.x, viewBG.frame.size.height/5*2);
    [view.layer setCornerRadius:3];
    [view.layer setMasksToBounds:YES];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    _view = view;
    [self addSubview:_view];
    
    ///标题
    _lable_title = [[UILabel alloc]init];
    _lable_title.frame = CGRectMake(10, 20, view.frame.size.width-20, 15);
    _lable_title.text = [NSString stringWithFormat:@"%@",title];
    _lable_title.textAlignment=1;
    _lable_title.font = DEFAULTFONT(15);
    _lable_title.textColor = [UIColor darkGrayColor];
    [_view addSubview:_lable_title];
    
    ///二级标题
    _lable_subTitle = [[UILabel alloc]init];
    _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height+20, view.frame.size.width-20, 20);
    _lable_subTitle.text = [NSString stringWithFormat:@"%@",subTitle];
    _lable_subTitle.textAlignment=1;
    _lable_subTitle.font = DEFAULTFONT(20);
    _lable_subTitle.textColor = TextRedColor;
    [_view addSubview:_lable_subTitle];
    if([[NSString stringWithFormat:@"%@",subTitle] isEqualToString:@""]) {
        _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height, view.frame.size.width-20, 0);
    }
    ///  TF
    _TF = [[UITextField alloc]init];
    _TF.frame = CGRectMake(0, 0, 0, 0);
    _TF.delegate = self;
    _TF.keyboardType=UIKeyboardTypeNumberPad;
    [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_view addSubview:_TF];
    
    ///  假的输入框
    _view_box1 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2, CGRectGetMaxY(_lable_subTitle.frame)+20, boxWidth, boxWidth)];
    [_view_box1.layer setBorderWidth:0.5];
    _view_box1.backgroundColor = DefaultBGColor;
    _view_box1.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box1];
    
    _view_box2 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*1-0.5, _view_box1.frame.origin.y, boxWidth, boxWidth)];
    _view_box2.backgroundColor = DefaultBGColor;
    [_view_box2.layer setBorderWidth:0.5];
    _view_box2.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box2];
    
    _view_box3 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*2-1, _view_box1.frame.origin.y, boxWidth, boxWidth)];
    [_view_box3.layer setBorderWidth:0.5];
    _view_box3.backgroundColor = DefaultBGColor;
    _view_box3.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box3];
    
    _view_box4 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*3-1.5, _view_box1.frame.origin.y, boxWidth, boxWidth)];
    [_view_box4.layer setBorderWidth:0.5];
    _view_box4.backgroundColor = DefaultBGColor;
    _view_box4.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box4];
    
    _view_box5 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*4-2, _view_box1.frame.origin.y, boxWidth, boxWidth)];
    [_view_box5.layer setBorderWidth:0.5];
    _view_box5.backgroundColor = DefaultBGColor;
    _view_box5.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box5];
    
    _view_box6 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*5-2.5, _view_box1.frame.origin.y, boxWidth, boxWidth)];
    [_view_box6.layer setBorderWidth:0.5];
    _view_box6.backgroundColor = DefaultBGColor;
    _view_box6.layer.borderColor = [LineColor CGColor];
    [_view addSubview:_view_box6];
    
    
    ///   密码点
    _lable_point1 = [[UILabel alloc]init];
    _lable_point1.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point1.layer setCornerRadius:5];
    [_lable_point1.layer setMasksToBounds:YES];
    _lable_point1.backgroundColor = [UIColor blackColor];
    [_view_box1 addSubview:_lable_point1];
    
    _lable_point2 = [[UILabel alloc]init];
    _lable_point2.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point2.layer setCornerRadius:5];
    [_lable_point2.layer setMasksToBounds:YES];
    _lable_point2.backgroundColor = [UIColor blackColor];
    [_view_box2 addSubview:_lable_point2];
    
    
    _lable_point3 = [[UILabel alloc]init];
    _lable_point3.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point3.layer setCornerRadius:5];
    [_lable_point3.layer setMasksToBounds:YES];
    _lable_point3.backgroundColor = [UIColor blackColor];
    [_view_box3 addSubview:_lable_point3];
    
    _lable_point4 = [[UILabel alloc]init];
    _lable_point4.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point4.layer setCornerRadius:5];
    [_lable_point4.layer setMasksToBounds:YES];
    _lable_point4.backgroundColor = [UIColor blackColor];
    [_view_box4 addSubview:_lable_point4];
    
    _lable_point5 = [[UILabel alloc]init];
    _lable_point5.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point5.layer setCornerRadius:5];
    [_lable_point5.layer setMasksToBounds:YES];
    _lable_point5.backgroundColor = [UIColor blackColor];
    [_view_box5 addSubview:_lable_point5];
    
    _lable_point6 = [[UILabel alloc]init];
    _lable_point6.frame = CGRectMake((_view_box1.frame.size.width-10)/2, (_view_box1.frame.size.width-10)/2, 10, 10);
    [_lable_point6.layer setCornerRadius:5];
    [_lable_point6.layer setMasksToBounds:YES];
    _lable_point6.backgroundColor = [UIColor blackColor];
    [_view_box6 addSubview:_lable_point6];
    
    _lable_point1.hidden=YES;
    _lable_point2.hidden=YES;
    _lable_point3.hidden=YES;
    _lable_point4.hidden=YES;
    _lable_point5.hidden=YES;
    _lable_point6.hidden=YES;
    
    
    if(_buttonArr.count>0 && _type == PayInputAlertView_Hand) {
        CGRect viewFrame = _view.frame;
        viewFrame.size.height +=30;
        _view.frame = viewFrame;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_view_box1.frame)+15, view.frame.size.width, 0.5)];
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
    switch (_field.text.length) {
        case 0:{
            _lable_point1.hidden=YES;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 1:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 2:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 3:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 4:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 5:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=YES;
        }
            break;
        case 6:{
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=NO;
        }
            break;
            
        default:
            break;
    }
    if(_type == PayInputAlertView_Auto) {//自动验证
        if (_field.text.length==6){
            // 延迟执行
            if (@available(iOS 10.0, *)) {
                [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    [self autoVerifyPassWord:_field.text];
                }];
            } else {
                // Fallback on earlier versions
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

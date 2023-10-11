//
//  EGSIXCHATRegisterVC.m
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import "EGSIXCHATRegisterVC.h"
#import "EGSIXCHATProtocolVC.h"


@interface EGSIXCHATRegisterVC ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *eogcsaioxScrollView;

@property (weak, nonatomic) IBOutlet UILabel *eogcsaioxTypeLabel;

@property (weak, nonatomic) IBOutlet UIView *eogcsaioxAView;
@property (weak, nonatomic) IBOutlet UIView *eogcsaioxBView;
@property (weak, nonatomic) IBOutlet UIView *eogcsaioxCView;
@property (weak, nonatomic) IBOutlet UIView *eogcsaioxDView;

@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxPswTF;
@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxPsw2TF;

@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxSendcodeButton;

@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxOkButton;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxProtocolButton;

@property (weak, nonatomic) IBOutlet UILabel *eogcsaioxFlagLabel;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxLoginButton;

@end

@implementation EGSIXCHATRegisterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.subviews[0].alpha = 0.0;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.subviews[0].alpha = 1.0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    ViewRadius(_eogcsaioxAView, 25.0);
    ViewRadius(_eogcsaioxBView, 25.0);
    ViewRadius(_eogcsaioxCView, 25.0);
    ViewRadius(_eogcsaioxDView, 25.0);
    
    _eogcsaioxPhoneTF.delegate = self;
    _eogcsaioxCodeTF.delegate = self;
    _eogcsaioxPswTF.delegate = self;
    _eogcsaioxPsw2TF.delegate = self;
    [_eogcsaioxPhoneTF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    [_eogcsaioxCodeTF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    [_eogcsaioxPswTF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    [_eogcsaioxPsw2TF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    
    _eogcsaioxScrollView.delegate = self;
    [_eogcsaioxScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
}




- (IBAction)eogcsaioxOk:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self eogcsaioxIIsValid]) {
        return;
    }
    NSString *title = @"您确定要注册账号吗？";
    if (_eogcsaioxType == 1) {
        title = @"您确定要保存密码吗？";
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    WS(weakself)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself eogcsaioxOked];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)eogcsaioxOked {
    NSMutableDictionary *parmas = NSMutableDictionary.new;
    
    if (_eogcsaioxType == 0) { // 注册账号
        parmas[@"phone"] = _eogcsaioxPhoneTF.text;
        parmas[@"code"] = _eogcsaioxCodeTF.text;
        parmas[@"password"] = _eogcsaioxPswTF.text;
        parmas[@"password_re"] = _eogcsaioxPsw2TF.text;

//        [KLNetworkHandler requestWithUrl:LOGIN_REGISTER params:parmas showHUD:YES httpMedthod:KLNetWorkMethodPOST successBlock:^(id responseObj) {
//            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
//            [SVProgressHUD dismissWithDelay:1.0];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        } failBlock:^(NSError *error) {
//
//        }];
    }else { // 找回密码
        parmas[@"phone"] = _eogcsaioxPhoneTF.text;
        parmas[@"code"] = _eogcsaioxCodeTF.text;
        parmas[@"password"] = _eogcsaioxPswTF.text;
        parmas[@"password_re"] = _eogcsaioxPsw2TF.text;
        
//        [KLNetworkHandler requestWithUrl:LOGIN_FORGET_PSW params:parmas showHUD:YES httpMedthod:KLNetWorkMethodPOST successBlock:^(id responseObj) {
//            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//            [SVProgressHUD dismissWithDelay:1.0];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        } failBlock:^(NSError *error) {
//
//        }];
    }
}

- (IBAction)eogcsaioxSendcode:(UIButton *)sender {
    [self.view endEditing:YES];
    [RequestTools.main sendTheCode:_eogcsaioxPhoneTF.text type:1 button:_eogcsaioxSendcodeButton];
    _eogcsaioxCodeTF.text = @"";
}


- (IBAction)eogcsaioxProtocol:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    if (sender.selected) {
        EGSIXCHATProtocolVC *vc = EGSIXCHATProtocolVC.new;
        vc.eogcsaioxType = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)eogcsaioxLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)eogcsaioxIIsValid {
    if (_eogcsaioxPhoneTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_eogcsaioxPhoneTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (![_eogcsaioxPhoneTF.text checkPhoneNum]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误"];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (_eogcsaioxCodeTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_eogcsaioxCodeTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (_eogcsaioxPswTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_eogcsaioxPswTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (_eogcsaioxPsw2TF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_eogcsaioxPsw2TF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (![_eogcsaioxPswTF.text checkPassword] || ![_eogcsaioxPsw2TF.text checkPassword]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位数字、字母组合"];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (![_eogcsaioxPswTF.text isEqualToString:_eogcsaioxPsw2TF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两个密码不一致，请重新设置"];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (_eogcsaioxType == 0) {
        if (!_eogcsaioxProtocolButton.selected) {
            [SVProgressHUD showErrorWithStatus:@"请您阅读协议"];
            [SVProgressHUD dismissWithDelay:1.0];
            return YES;
        }
    }
    return NO;
}

- (void)eogcsaioxTextField:(UITextField *)textField {
    if (_eogcsaioxPhoneTF.text.length == 11 && _eogcsaioxCodeTF.text.length >= 4 &&
        [_eogcsaioxPswTF.text checkPassword] && [_eogcsaioxPsw2TF.text checkPassword]) {
        if (_eogcsaioxLoginButton.userInteractionEnabled) {
            return;
        }
        _eogcsaioxLoginButton.selected = YES;
        _eogcsaioxLoginButton.userInteractionEnabled = YES;
    }else {
        if (!_eogcsaioxLoginButton.userInteractionEnabled) {
            return;
        }
        _eogcsaioxLoginButton.selected = NO;
        _eogcsaioxLoginButton.userInteractionEnabled = NO;
    }
}



- (void)initView {
    if (_eogcsaioxType == 0) {
        _eogcsaioxTypeLabel.text = @"欢迎注册!";
        _eogcsaioxPswTF.placeholder = @"设置密码";
        _eogcsaioxPsw2TF.placeholder = @"确认密码";
        [_eogcsaioxOkButton setTitle:@"立即注册" forState:UIControlStateNormal];
        
        _eogcsaioxProtocolButton.hidden = NO;
        _eogcsaioxFlagLabel.hidden = NO;
        _eogcsaioxLoginButton.hidden = NO;
    }else {
        _eogcsaioxTypeLabel.text = @"忘记密码!";
        _eogcsaioxPswTF.placeholder = @"请输入新密码";
        _eogcsaioxPsw2TF.placeholder = @"请确认新密码";
        [_eogcsaioxOkButton setTitle:@"保存密码" forState:UIControlStateNormal];
        
        _eogcsaioxProtocolButton.hidden = YES;
        _eogcsaioxFlagLabel.hidden = YES;
        _eogcsaioxLoginButton.hidden = YES;
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger eogcsaioxLength = textField.text.length - range.length + string.length;
    if (_eogcsaioxPhoneTF == textField) {
        return (eogcsaioxLength <= 11);
    }
    if (_eogcsaioxCodeTF == textField) {
        return (eogcsaioxLength <= 6);
    }
    if (_eogcsaioxPswTF == textField || _eogcsaioxPsw2TF == textField) {
        return (eogcsaioxLength <= 16);
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:true];
}

- (void)close {
    [self.view endEditing:true];
}


@end

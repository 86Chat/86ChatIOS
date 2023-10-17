//
//  EGSIXCHATLoginVC.m
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import "EGSIXCHATLoginVC.h"
#import "EGSIXCHATRegisterVC.h"
#import "EGSIXCHATProtocolVC.h"


@interface EGSIXCHATLoginVC ()<UITextFieldDelegate, UIScrollViewDelegate>
{
    NSInteger _eogcsaioxType;
}
@property (weak, nonatomic) IBOutlet UIScrollView *eogcsaioxScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *eogcsaioxTypeView;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxPswdButton;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxCodeButton;
@property (weak, nonatomic) IBOutlet UIView *eogcsaioxLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eogcsaioxLineLeft;

@property (weak, nonatomic) IBOutlet UIView *eogcsaioxAView;
@property (weak, nonatomic) IBOutlet UIView *eogcsaioxBView;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxSendcodeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eogcsaioxSendcodeWidth;
@property (weak, nonatomic) IBOutlet UIImageView *eogcsaioxCodeView;

@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *eogcsaioxPasswordTF;

@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxProtocolButton;
@property (weak, nonatomic) IBOutlet UIButton *eogcsaioxLoginButton;

@end

@implementation EGSIXCHATLoginVC

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
    _eogcsaioxType = 0;
    _eogcsaioxSendcodeWidth.constant = 22.0;
    
    _eogcsaioxScrollView.delegate = self;
    [_eogcsaioxScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    _eogcsaioxSendcodeButton.hidden = YES;
//    _eogcsaioxLoginButton.userInteractionEnabled = NO;
    _eogcsaioxLoginButton.userInteractionEnabled = YES;
    WS(weakself)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.eogcsaioxLineLeft.constant = (WIDTH - 30.0) / 4.0 - 13.0;
    });
    ViewRadius(_eogcsaioxAView, 25.0);
    ViewRadius(_eogcsaioxBView, 25.0);
    
    _eogcsaioxAccountTF.delegate = self;
    _eogcsaioxPasswordTF.delegate = self;
    [_eogcsaioxAccountTF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    [_eogcsaioxPasswordTF addTarget:self action:@selector(eogcsaioxTextField:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *eogcsaioxCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eogcsaioxCloseBtn.frame = CGRectMake(0, 0, 60.0, 32.0);
    eogcsaioxCloseBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [eogcsaioxCloseBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [eogcsaioxCloseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [eogcsaioxCloseBtn addTarget:self action:@selector(eogcsaioxClose) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:eogcsaioxCloseBtn];
    
    [self preferredStatusBarStyle];
}
 
- (IBAction)eogcsaioxLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    _eogcsaioxAccountTF.text = @"13800000020";
    _eogcsaioxPasswordTF.text = @"123456";

    if ([self eogcsaioxIIsValid]) {
        return;
    }
//    WS(weakself)
    if (_eogcsaioxType == 0) { // 密码登录
        [KLNetworkHandler requestWithUrl:PUB_LOGIN params:@{@"account":_eogcsaioxAccountTF.text, @"password":_eogcsaioxPasswordTF.text} showHUD:YES httpMedthod:KLNetWorkMethodPOST successBlock:^(id responseObj) {
            
//            NSString *app_token = responseObj[@"data"][@"app_token"];
//            [weakself loginSuccess:app_token];
        }failBlock:^(NSError *error) {
        }];
    }else { // 验证码登录
//        [KLNetworkHandler requestWithUrl:LOGIN_CODE_LOGIN params:@{@"phone":_eogcsaioxAccountTF.text, @"code":_eogcsaioxPasswordTF.text} showHUD:YES httpMedthod:KLNetWorkMethodPOST successBlock:^(id responseObj) {
//
//            NSString *app_token = responseObj[@"data"][@"app_token"];
//            [weakself loginSuccess:app_token];

//        [EMClient.sharedClient loginWithUsername:@"" token:@""]; // app_token
        
        
//        } failBlock:^(NSError *error) {
//        }];
    }
}
/**
{
    code = 0;
    count = 0;
    data =     {
        authToken = "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbmZvIjoiUUVpQVhRaWFlcnhaaW5mUXpaSHdFYnVKVTRBU0N0NFJpT2NXVFNkcDM5RjdNbWNISWswZW5LYkgwREVIVkZhSE9rZWs1RDlBRkN2XC9MTk0xZlJ2YjFzQjBNS0NnR29CdTBiclRGWjBzQTRYbjFOTDgrTUpXZjByUGlPTDYzblJ3Z1lWS2sxd1VoR1RsXC9tbmlCeTFBVHY5M0M2c0ZqMWlzb1lEMFBHMkhCVVJ3ZlpqV1Y1bEZ4RVFpXC96RHhMRjVSWlJsSnhCUHNFSk5aMlpxc1l4RHp5MGJTbVwvTlRNK2R6bUJha29tamR2dVFBK1NRZXpGVVwvcERiWiszWTBrTjVhS0w5OXlHYWE1UnhLU1RDQlhCSW5yeHF3OUJrUFlneVJ1WUdNWERaeGZqbElBRVlGUHVCdzErVkVQUnpxcW1Xa0ptSlkzR3luMEJlcnlqb2hRY2tiY1JMUFhLMUxxVG05blFoNGIwT0VDb0t5S1locVRsanBTN1NZRW90UXlzZ1hCcXJDVjhDVDlvYjJoMWw0TXJJMExMVEVlMmJhZmc0RGZqOW5vZUQxWEpxSUpISlFFNDVkTzJ6Ykc1SFhndndlajBXQVVaRVNKUHJzXC96Ukc0bVVOVmNWYWxiYnd3bEF4czk1YzBsV29QK0dReUJrUnpsY05jcHJDM0V2eHFHZVQrd1BPVUNDOE9DQ3BLbXlDYWVVdnlHTDJ6TXhzcXZyUTBGQnZzYWdMQTVid1JyUEpEWTVJRWhpbUJLbTd0Q08wIiwidGVybWluYWwiOiJ3ZWIiLCJhdWQiOiIiLCJleHAiOjE3MDAwMzg4NjksImlhdCI6MTY5NzQ0Njg2OSwiaXNzIjoiIiwianRpIjoiZDhmZWZkZTBkNWNjYWMwYmJjZDMyMmIyNjRhNDk4YzMiLCJuYmYiOjE2OTc0NDY4NjksInN1YiI6IiJ9.H5AFDGTH6ohGq-9j4XzNnn4Qhd5oIcprGKw2yHF3GYU";
        sessionId = ae0f80281057d24cd6bc98d0d4e6ed43;
        userInfo =         {
            account = 13800000020;
            avatar = "http://api.866chat.com/avatar/\U5415\U5e03/80/20";
            "delete_time" = 0;
            displayName = "\U5415\U5e03";
            email = "lvbu@qq.com";
            id = 20;
            "is_auth" = 0;
            "last_login_ip" = "171.223.193.72";
            "last_login_time" = 1697446687;
            motto = "<null>";
            "name_py" = lvbu;
            qrUrl = "http://api.866chat.com/scan/u/mAwRb6KOMnpk";
            realname = "\U5415\U5e03";
            remark = "";
            role = 0;
            setting = "<null>";
            sex = 2;
            status = 1;
            "user_id" = 20;
        };
    };
    msg = "\U767b\U5f55\U6210\U529f\Uff01";
    page = 1;
}
 */
- (void)loginSuccess:(NSString *)app_token {
    if (app_token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:app_token forKey:@"APP_TOKEN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [UserData.main getUserData:^(BOOL isSuccess) {
    }];
//    [NSNotificationCenter.defaultCenter postNotificationName:kMY_COLLECTION_COUNT object:@{@"LoginSuccess":@(5)}];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IS_LOGIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

// 发送验证码
- (IBAction)eogcsaioxSendCode:(UIButton *)sender {
    [self.view endEditing:YES];
    _eogcsaioxPasswordTF.text = @"";
    [RequestTools.main sendTheCode:_eogcsaioxAccountTF.text type:3 button:_eogcsaioxSendcodeButton];
}

- (IBAction)LoginWay:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_eogcsaioxType == sender.tag) {
        return;
    }
    _eogcsaioxType = sender.tag;
    if (_eogcsaioxType == 0) {
        _eogcsaioxPswdButton.selected = YES;
        _eogcsaioxCodeButton.selected = NO;
        _eogcsaioxSendcodeButton.hidden = YES;
        _eogcsaioxCodeView.image = IMAGENAME(@"eogcsaioxPsw");
        [_eogcsaioxPasswordTF setSecureTextEntry:YES];
        _eogcsaioxPasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
        _eogcsaioxPasswordTF.placeholder = @"请输入密码";
        _eogcsaioxLineLeft.constant = (WIDTH - 30.0) / 4.0 - 13.0;
        _eogcsaioxTypeView.image = IMAGENAME(@"eogcsaiox0");
        _eogcsaioxSendcodeWidth.constant = 22.0;
        _eogcsaioxPswdButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0];
        _eogcsaioxCodeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];
    }else {
        _eogcsaioxPswdButton.selected = NO;
        _eogcsaioxCodeButton.selected = YES;
        _eogcsaioxSendcodeButton.hidden = NO;
        _eogcsaioxCodeView.image = IMAGENAME(@"eogcsaioxCode");
        [_eogcsaioxPasswordTF setSecureTextEntry:NO];
        _eogcsaioxPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
        _eogcsaioxPasswordTF.placeholder = @"请输入验证码";
        _eogcsaioxLineLeft.constant = (WIDTH - 30.0) / 4.0 * 3.0 - 13.0;
        _eogcsaioxTypeView.image = IMAGENAME(@"eogcsaiox1");
        _eogcsaioxSendcodeWidth.constant = 100.0;
        _eogcsaioxPswdButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];
        _eogcsaioxCodeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0];
    }
    _eogcsaioxPasswordTF.text = @"";
}

- (IBAction)eogcsaioxProtocol:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
}

- (IBAction)eogcsaioxProtocolDetails:(UIButton *)sender {
    [self.view endEditing:YES];
    EGSIXCHATProtocolVC *vc = EGSIXCHATProtocolVC.new;
    vc.eogcsaioxType = sender.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)eogcsaioxRegisterForget:(UIButton *)sender {
    [self.view endEditing:YES];
    EGSIXCHATRegisterVC *vc = EGSIXCHATRegisterVC.new;
    vc.eogcsaioxType = sender.tag;
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)eogcsaioxIIsValid {
    if (_eogcsaioxAccountTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_eogcsaioxAccountTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (![_eogcsaioxAccountTF.text checkPhoneNum]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误"];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    if (_eogcsaioxType == 0) {
//        if (![_eogcsaioxPasswordTF.text checkPassword]) {
//            [SVProgressHUD showErrorWithStatus:@"请输入6-16位数字、字母组合"];
//            [SVProgressHUD dismissWithDelay:1.0];
//            return YES;
//        }
    }else {
        if (_eogcsaioxPasswordTF.text.length < 4) {
            [SVProgressHUD showErrorWithStatus:_eogcsaioxPasswordTF.placeholder];
            [SVProgressHUD dismissWithDelay:1.0];
            return YES;
        }
    }
    if (!_eogcsaioxProtocolButton.selected) {
        [SVProgressHUD showErrorWithStatus:@"请您阅读协议"];
        [SVProgressHUD dismissWithDelay:1.0];
        return YES;
    }
    return NO;
}

- (void)eogcsaioxTextField:(UITextField *)textField {
    BOOL pswd = (_eogcsaioxType == 0 ? _eogcsaioxPasswordTF.text.length >= 6 : _eogcsaioxPasswordTF.text.length >= 4);
    if (_eogcsaioxAccountTF.text.length == 11 && pswd) {
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger eogcsaioxLength = textField.text.length - range.length + string.length;
    if (_eogcsaioxAccountTF == textField) {
        return (eogcsaioxLength <= 11);
    }
    if (_eogcsaioxPasswordTF == textField) {
        if (_eogcsaioxType == 0) {
            return (eogcsaioxLength <= 16);
        }
        return (eogcsaioxLength <= 6);
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

- (void)eogcsaioxClose {
    [self.view endEditing:true];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)close {
    [self.view endEditing:true];
}

@end

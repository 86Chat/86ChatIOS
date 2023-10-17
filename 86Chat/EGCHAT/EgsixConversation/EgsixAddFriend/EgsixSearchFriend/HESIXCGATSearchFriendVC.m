//
//  HESIXCGATSearchFriendVC.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "HESIXCGATSearchFriendVC.h"

@interface HESIXCGATSearchFriendVC ()

@property (weak, nonatomic) IBOutlet UIView *oxgcseoaiBgView;

@property (weak, nonatomic) IBOutlet UITextField *oxgcseoaiTitleTF;

@property (weak, nonatomic) IBOutlet UIButton *oxgcseoaiSearchButton;

@end

@implementation HESIXCGATSearchFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索朋友";
    
    ViewRadius(_oxgcseoaiBgView, 15.0)
    ViewRadius(_oxgcseoaiSearchButton, 15.0)
}

- (IBAction)oxgcseoaiSearch:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_oxgcseoaiTitleTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_oxgcseoaiTitleTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    EMError *aError = [EMClient.sharedClient.contactManager addContact:_oxgcseoaiTitleTF.text message:@"请求添加您为好友"];
    if (aError == nil) { // 添加好友成功
        [SVProgressHUD showSuccessWithStatus:@"已为您提交申请..."];
        [SVProgressHUD dismissWithDelay:1.0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else {
        [SVProgressHUD showErrorWithStatus:aError.errorDescription];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

//
//  RequestTools.m
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import "RequestTools.h"

@implementation RequestTools

+ (instancetype)main {
    static dispatch_once_t once;
    static RequestTools *instance;
    dispatch_once(&once, ^{
        instance = [[RequestTools alloc] init];
    });
    return instance;
}


- (void)sendTheCode:(NSString *)phone type:(NSInteger)type button:(UIButton *)btn {
    if (phone.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (![phone checkPhoneNum]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (phone.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式有误"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
//    WS(weakself)
//    CaptchaValidationPopView *validationPopView = [[CaptchaValidationPopView alloc] init];
//    [validationPopView setValidationBlock:^(NSString * _Nonnull token) {
//        [KLNetworkHandler requestWithUrl:LOGIN_SEND_CODE params:@{@"phone":phone, @"type":@(type), @"code":token} showHUD:YES httpMedthod:KLNetWorkMethodPOST successBlock:^(id responseObj) {
//            [weakself handleTimer:btn];
//        } failBlock:^(NSError *error) {
//        }];
//    }];
//    [validationPopView show];
}

- (void)updateApp {
//    WS(weakself);
//    [KLNetworkHandler requestWithUrl:LOGIN_CONFIG params:@{} showHUD:NO httpMedthod:KLNetWorkMethodGET successBlock:^(id responseObj) {
//        NSString *versionNum = responseObj[@"data"][@"ios_version"];
//        NSString *ios_app_download = responseObj[@"data"][@"ios_app_download"];
//        NSInteger is_open = [responseObj[@"data"][@"is_open"] integerValue];
//
//        if (is_open == 0) { // 0-关闭，1-开启
//            return;
//        }
//        if ([versionNum isEqualToString:@"1.0.14"]) {
//            return;
//        }
//        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"发现有新版本，立即去更新？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            if (ios_app_download != nil || ios_app_download.length > 0) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ios_app_download] options:@{} completionHandler:^(BOOL success) {
//                    [weakself exit];
//                }];
//            }
//        }];
//        [alertController addAction:cancelAction];
//        [ShareAppDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//    } failBlock:^(NSError *error) {
//    }];
}
- (void)exit {
    UIWindow *window = ShareAppDelegate.window;
    [UIView animateWithDuration:0.35 animations:^{
        window.alpha = 0.0;
        window.frame = CGRectMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)/2,1,1);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}






/**
 *  验证码倒计时
 */
- (void)handleTimer:(UIButton*)sender {
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                [sender setTitleColor:RGBA(0xff4845) forState:UIControlStateNormal];
                sender.backgroundColor = [UIColor clearColor];
                sender.userInteractionEnabled = YES;
            });
        }else {
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [sender setTitleColor:RGBA(0x222222) forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor clearColor];
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}

@end

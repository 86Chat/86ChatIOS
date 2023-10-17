//
//  HESIXCGATAddFriendVC.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "HESIXCGATAddFriendVC.h"

#import "HESIXCGATSearchFriendVC.h"
#import "HESIXCGATQrcodeVC.h"



@interface HESIXCGATAddFriendVC ()

@end

@implementation HESIXCGATAddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
}

- (IBAction)oxgcseoaiAct:(UIButton *)sender {
    if (sender.tag == 0) { // 搜索朋友
        HESIXCGATSearchFriendVC *vc = HESIXCGATSearchFriendVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) { // 手机联系人
        
    }else if (sender.tag == 2) { // 扫描二维码
//        #if __is_target_environment(simulator) // 当前设备为模拟器
//                [SVProgressHUD showErrorWithStatus:@"该设备不支持打开相机扫描二维码"];
//                [SVProgressHUD dismissWithDelay:1.0];
//            return;
//        #else // 当前设备为真机
                HESIXCGATQrcodeVC *vc = HESIXCGATQrcodeVC.new;
                [self.navigationController pushViewController:vc animated:NO];
//        #endif
    }else if (sender.tag == 3) { // 邀请好友
        
    }
}


@end

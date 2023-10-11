//
//  EGSIXCHATProtocolVC.m
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import "EGSIXCHATProtocolVC.h"

@interface EGSIXCHATProtocolVC ()



@end

@implementation EGSIXCHATProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_eogcsaioxType == 0) {
        self.navigationItem.title = @"用户协议";
    }else if (_eogcsaioxType == 1) {
        self.navigationItem.title = @"隐私政策";
    }else if (_eogcsaioxType == 2) {
        self.navigationItem.title = @"快速注册用户协议";
    }
    
    
    
}

@end

//
//  STIXCHGAEContactsVC.m
//  86Chat
//
//  Created by Rubyuer on 10/12/23.
//

#import "STIXCHGAEContactsVC.h"

#import "MessageAddPopView.h"

#import "HESIXCGATAddFriendVC.h"


@interface STIXCHGAEContactsVC ()

@end

@implementation STIXCHGAEContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self leftTitle:@"86CHAT" len:2]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self itemImage:@"oxgcseoaiAddM" action:@selector(oxgcseoaiAdd)]];
    
    
    
    
}

- (void)oxgcseoaiAdd {
    MessageAddPopView *popView = [[MessageAddPopView alloc] init];
    WS(weakself)
    [popView setTypeBlock:^(NSInteger index) {
        if (index == 0) { // 添加好友
            HESIXCGATAddFriendVC *vc = HESIXCGATAddFriendVC.new;
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else if (index == 1) { // 创建群聊
            
        }else { // 扫一扫
            
        }
    }];
    [popView show];
}


@end

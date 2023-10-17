//
//  HESIXCGATConversationVC.m
//  86Chat
//
//  Created by Rubyuer on 10/11/23.
//

#import "HESIXCGATConversationVC.h"
#import "ConversationHeaderView.h"

#import "MessageAddPopView.h"

#import "HESIXCGATAddFriendVC.h"
#import "HESIXCGATChooseContactVC.h"


@interface HESIXCGATConversationVC ()<EaseConversationsViewControllerDelegate, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ConversationHeaderView *headerView;

@end

@implementation HESIXCGATConversationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.canRefresh = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self leftTitle:@"86CHAT" len:2]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self itemImage:@"oxgcseoaiAddM" action:@selector(oxgcseoaiAdd)]];
    
    self.delegate = self;
    
//    self.tableView.estimatedSectionHeaderHeight = 115.0;
//    self.tableView.tableHeaderView = self.headerView;
    
    NSLog(@"currentUsername==%@",EMClient.sharedClient.currentUsername);
    
}
- (void)oxgcseoaiAdd {
    
//    // 创建消息
//    EMTextMessageBody* textBody = [[EMTextMessageBody alloc] initWithText:@"Hello 一亿元"];
//    EMChatMessage *message = [[EMChatMessage alloc] initWithConversationID:@""
//                                                                  from:@"test1"
//                                                                    to:@"AAC"
//                                                                  body:textBody
//                                                                   ext:@{}];
//    // 发送消息
//    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMChatMessage *message, EMError *error) {
//        NSLog(@"error = %@",error.errorDescription);
//    }];
//
//
//    return;
//    [_oxgcseoaiSearchTF resignFirstResponder];
    
    MessageAddPopView *popView = [[MessageAddPopView alloc] init];
    WS(weakself)
    [popView setTypeBlock:^(NSInteger index) {
        if (index == 0) { // 添加好友
            HESIXCGATAddFriendVC *vc = HESIXCGATAddFriendVC.new;
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else if (index == 1) { // 创建群聊
            HESIXCGATChooseContactVC *vc = HESIXCGATChooseContactVC.new;
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else { // 扫一扫
            
        }
    }];
    [popView show];
}




- (void)easeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EaseConversationModel *model = self.dataAry[indexPath.row];
    
    EaseChatViewModel *aModel = EaseChatViewModel.new;
    aModel.avatarStyle = Circular;
    
    NSLog(@"easeId == %@",model.easeId);
    EaseChatViewController *vc = [EaseChatViewController initWithConversationId:model.easeId conversationType:model.type chatViewModel:aModel];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  115.0;
}




- (ConversationHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ConversationHeaderView alloc] init];
        _headerView.oxgcseoaiSearchTF.delegate = self;
        _headerView.oxgcseoaiSearchTF.returnKeyType = UIReturnKeySearch;
    }
    return _headerView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_headerView.oxgcseoaiSearchTF resignFirstResponder];
    if (textField.text.length > 0) {
        
    }else {
        
    }
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_headerView.oxgcseoaiSearchTF resignFirstResponder];
}

@end

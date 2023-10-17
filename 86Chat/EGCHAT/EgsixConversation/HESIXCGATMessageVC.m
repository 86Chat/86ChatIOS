//
//  HESIXCGATMessageVC.m
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import "HESIXCGATMessageVC.h"
#import "HESIXCGATMessageTVCell.h"

#import "MessageAddPopView.h"

#import "HESIXCGATAddFriendVC.h"


@interface HESIXCGATMessageVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIView *oxgcseoaiSearchView;
@property (weak, nonatomic) IBOutlet UITextField *oxgcseoaiSearchTF;

@property (weak, nonatomic) IBOutlet UITableView *oxgcseoaiTableView;
@property (nonatomic, strong) NSMutableArray<EMConversation *> *dataArray;

@end

@implementation HESIXCGATMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self leftTitle:@"86CHAT" len:2]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self itemImage:@"oxgcseoaiAddM" action:@selector(oxgcseoaiAdd)]];
    
//    NSLog(@"getContacts==%@",[EMClient.sharedClient.contactManager getContacts]);
    
    ViewRadius(_oxgcseoaiSearchView, 15.0)
    
    _oxgcseoaiSearchTF.delegate = self;
    _oxgcseoaiSearchTF.returnKeyType = UIReturnKeySearch;
    
    
    [self initUI];
    [self refreshData];
}

- (void)oxgcseoaiAdd {
    
//    for (NSString *user in @[@"test2", @"AAB", @"AAC", @"AAD", @"AAE", @"AAF", @"AAG"]) {
//        // 同意好友申请。
//        [[EMClient sharedClient].contactManager approveFriendRequestFromUser:user completion:^(NSString *aUsername, EMError *aError) {
//            if (!aError) {
//                NSLog(@"同意加好友申请成功");
//            } else {
//                NSLog(@"同意加好友申请失败的原因 --- %@", aError.errorDescription);
//            }
//        }];
//    }
    
    
    
    
//    // 创建消息
//    EMTextMessageBody* textBody = [[EMTextMessageBody alloc] initWithText:@"hello ruby"];
//    EMChatMessage *message = [[EMChatMessage alloc] initWithConversationID:@"test1"
//                                                                  from:@"test1"
//                                                                    to:@"AAB"
//                                                                  body:textBody
//                                                                   ext:@{}];
//    // 发送消息
//    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMChatMessage *message, EMError *error) {
//        NSLog(@"error = %@",error.errorDescription);
//    }];

    
    return;
    [_oxgcseoaiSearchTF resignFirstResponder];
    
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

- (void)refreshData {
    [self.dataArray removeAllObjects];
    [self refreshEndStatus:self.oxgcseoaiTableView];
    
//    _dataArray = [EMClient.sharedClient.chatManager getAllConversations:YES].mutableCopy;
//    WS(weakself)
//    [EMClient.sharedClient.contactManager getContactsFromServerWithCompletion:^(NSArray<NSString *> * _Nullable aList, EMError *aError_Nullable) {
//        NSLog(@"aList===%@",aList);
//        [EMClient.sharedClient.userInfoManager fetchUserInfoById:aList completion:^(NSDictionary * _Nullable aUserDatas, EMError * _Nullable aError) {
//            NSLog(@"aUserDatas==%@",aUserDatas);
//            NSLog(@"aab==%@",aUserDatas[@"aab"]);
//        }];
//    }];
    
    for (EMConversation *conversation in [EMClient.sharedClient.chatManager getAllConversations:YES]) {
//        ConversationModel *model = [ConversationModel mj_objectWithKeyValues:conversation.mj_JSONObject];

        [EMClient.sharedClient.userInfoManager fetchUserInfoById:@[conversation.conversationId] completion:^(NSDictionary * _Nullable aUserDatas, EMError * _Nullable aError) {
            NSLog(@"aUserDatas===%@",aUserDatas);
        }];
    }
    
    
    
    
    
    
    [_oxgcseoaiTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
//    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HESIXCGATMessageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HESIXCGATMessageTVCell" forIndexPath:indexPath];
    
//    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        WS(weakself);
//        // 先删数据 再删UI
//        [weakself.dataArray removeObjectAtIndex:indexPath.section];
//        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark -- init UI

- (void)initUI {
    _oxgcseoaiTableView.delegate = self;
    _oxgcseoaiTableView.dataSource = self;
    _oxgcseoaiTableView.rowHeight = 65.0;
    [_oxgcseoaiTableView registerNib:[UINib nibWithNibName:@"HESIXCGATMessageTVCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HESIXCGATMessageTVCell"];
    
    WS(weakself);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refreshData];
    }];
    [header customInitHeader];
    _oxgcseoaiTableView.mj_header = header;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_oxgcseoaiSearchTF resignFirstResponder];
    if (textField.text.length > 0) {
        
    }else {
        
    }
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_oxgcseoaiSearchTF resignFirstResponder];
}


- (NSMutableArray<EMConversation *> *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.new;
    }return _dataArray;
}

@end

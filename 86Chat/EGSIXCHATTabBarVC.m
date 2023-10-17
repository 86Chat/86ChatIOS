//
//  EGSIXCHATTabBarVC.m
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import "EGSIXCHATTabBarVC.h"
#import "EGSIXCHATLoginVC.h"

#import "HESIXCGATMessageVC.h"
#import "HESIXCGATConversationVC.h"
#import "STIXCHGAEContactsVC.h"


@interface EGSIXCHATTabBarVC ()<UITabBarControllerDelegate>
{
    NSInteger ecgsoixSelect;
}

@end

@implementation EGSIXCHATTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ecgsoixSelect = 0;
    self.delegate = self;
    
    EaseConversationViewModel *model = EaseConversationViewModel.new;
    model.avatarType = Circular;
    model.avatarSize = CGSizeMake(50.0, 50.0);
    model.nameLabelColor = RGBA(0x222222);
    model.nameLabelFont = PINGFANG_M(14.0)
    model.detailLabelColor = RGBA(0x9D9D9D);
    model.detailLabelFont = PINGFANG_M(11.0)
    model.badgeLabelPosition = EMAvatarTopRight;
    model.canRefresh = YES;
//    // 头像样式
//    @property (nonatomic) EaseAvatarStyle avatarType;
//
//    // 默认头像
//    @property (nonatomic, strong) UIImage *defaultAvatarImage;
//
//    // 头像尺寸
//    @property (nonatomic) CGSize avatarSize;
//
//    // 头像位置
//    @property (nonatomic) UIEdgeInsets avatarEdgeInsets;
//
//    // 会话置顶背景色
//    @property (nonatomic, strong) UIColor *topBgColor;
//
//    // 昵称字体
//    @property (nonatomic, strong) UIFont *nameLabelFont;
//
//    // 昵称颜色
//    @property (nonatomic, strong) UIColor *nameLabelColor;
//
//    // 昵称位置
//    @property (nonatomic) UIEdgeInsets nameLabelEdgeInsets;
//
//    // 详情字体
//    @property (nonatomic, strong) UIFont *detailLabelFont;
//
//    // 详情字色
//    @property (nonatomic, strong) UIColor *detailLabelColor;
//
//    // 详情位置
//    @property (nonatomic) UIEdgeInsets detailLabelEdgeInsets;
//
//    // 时间字体
//    @property (nonatomic, strong) UIFont *timeLabelFont;
//
//    // 时间字色
//    @property (nonatomic, strong) UIColor *timeLabelColor;
//
//    // 时间位置
//    @property (nonatomic) UIEdgeInsets timeLabelEdgeInsets;
//
//    // 未读数显示风格
//    @property (nonatomic) EMUnReadCountViewPosition badgeLabelPosition;
//
//    // 未读数字体
//    @property (nonatomic, strong) UIFont *badgeLabelFont;
//
//    // 未读数字色
//    @property (nonatomic, strong) UIColor *badgeLabelTitleColor;
//
//    // 未读数背景色
//    @property (nonatomic, strong) UIColor *badgeLabelBgColor;
//
//    // 未读数角标高度
//    @property (nonatomic) CGFloat badgeLabelHeight;
//
//    // 未读数中心位置偏移
//    @property (nonatomic) CGVector badgeLabelCenterVector;
//
//    // 未读数显示上限, 超过上限后会显示 xx+
//    @property (nonatomic) int badgeMaxNum;
    HESIXCGATConversationVC *conversationVC = [[HESIXCGATConversationVC alloc] initWithModel:model];
    
    EaseContactsViewModel *modelB = EaseContactsViewModel.new;
    modelB.bgView.backgroundColor = UIColor.whiteColor; // 配置界面为白色
    
    STIXCHGAEContactsVC *contactsVC = [[STIXCHGAEContactsVC alloc] initWithModel:modelB];
    
    NSArray *ecgsoixVcs = @[conversationVC,
                            contactsVC,
                            HESIXCGATMessageVC.new,
                            HESIXCGATMessageVC.new];
    
    NSMutableArray *ecgsoixNvcs = NSMutableArray.new;
    for (NSInteger i = 0; i < ecgsoixVcs.count; i ++) {
        UINavigationController *ecgsoixNavi = [[UINavigationController alloc] initWithRootViewController:ecgsoixVcs[i]];
        ecgsoixNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[IMAGENAME(UNString(@"EGSIX%ldA", i)) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[IMAGENAME(UNString(@"EGSIX%ldAA", i)) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [ecgsoixNvcs addObject:ecgsoixNavi];
    }
    self.viewControllers = ecgsoixNvcs;
    
    // 选中/非选中的字体颜色
    self.tabBar.tintColor = UIColor.blackColor;
    self.tabBar.unselectedItemTintColor = RGBA(0x555555);
    // tabbar背景颜色       成对出现
    self.tabBar.barTintColor = UIColor.whiteColor;
    self.tabBar.backgroundColor = UIColor.whiteColor;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex <= 2 || ISLOGIN) {
        return;
    }
    tabBarController.selectedIndex = ecgsoixSelect;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:EGSIXCHATLoginVC.new];
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    ecgsoixSelect = tabBarController.selectedIndex;
    return YES;
}

@end

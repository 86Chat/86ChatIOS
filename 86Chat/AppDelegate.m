//
//  AppDelegate.m
//  86Chat
//
//  Created by Rubyuer on 9/27/23.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "EGSIXCHATTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)main {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupNaviTabbar];
    
    [self setupIQKeyboardManager];
    
// appkey 替换成你在环信即时通讯 IM 管理后台注册应用中的 App Key
    EMOptions *options = [EMOptions optionsWithAppkey:HX_APPKEY];
    // apnsCertName是证书名称，可以先传 nil，等后期配置 APNs 推送时在传入证书名称
    options.apnsCertName = nil;
    options.isAutoLogin = YES;
    [EMClient.sharedClient initializeSDKWithOptions:options];
    
//    [EMClient.sharedClient logout:YES completion:^(EMError * _Nullable aError) {
        
//        EMError *error = [EMClient.sharedClient loginWithUsername:@"test1" password:@"123456"];
//        if (error != nil) {
//            NSLog(@"%@",error.errorDescription);
//        }
//    }];
//        if (error != nil) {
//            NSLog(@"%@",error.errorDescription);
//        }
    
    

    [self enterRootViewController];
    return YES;
}


/**
 * navi  tabber  setup
 */
- (void)setupNaviTabbar {
    [UINavigationBar.appearance setTintColor:UIColor.blackColor];
    [UINavigationBar.appearance setBarTintColor:UIColor.whiteColor];
    [UINavigationBar.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.blackColor}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UITabBar appearance].backgroundColor = UIColor.whiteColor;
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        UINavigationBarAppearance *navBar = [[UINavigationBarAppearance alloc] init];
        navBar.backgroundColor = UIColor.whiteColor;
        navBar.shadowColor = UIColor.clearColor;
        [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.blackColor}];
        UINavigationBar.appearance.standardAppearance = navBar;
        UINavigationBar.appearance.scrollEdgeAppearance = navBar;
    }
}

#pragma mark - 根控制器
- (void)enterRootViewController {
//    if ([BundleVersion isEqualToString:BUNDLE_VERSION]) {
        self.window.rootViewController = EGSIXCHATTabBarVC.new;
        [self.window makeKeyAndVisible];
//    }else {
//        [[NSUserDefaults standardUserDefaults] setValue:BUNDLE_VERSION forKey:kCurrentVersion];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        JKFeatureViewController *jkFvc = [[JKFeatureViewController alloc] init];
//        [jkFvc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
//           *imageArray = @[@"GuideA", @"GuideAA", @"GuideAAA"];
//            *showPageCount = NO;
//            *showSkip = YES;
//        }];
//        self.window.rootViewController = nil;
//        self.window.rootViewController = jkFvc;
//    }
}

/**
 * 启动键盘管理器
 */
- (void)setupIQKeyboardManager {
    IQKeyboardManager *mananer = [IQKeyboardManager sharedManager];
    mananer.enable = YES;
    mananer.shouldResignOnTouchOutside = YES;
    mananer.enableAutoToolbar = NO;
    [mananer resignFirstResponder];
}








// 获取当前显示的 UIViewController
- (UIViewController *)getCurrentViewController {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findCurrentShowingViewControllerFrom:vc];
}
- (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc {
    // 递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) {
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    }else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    return currentShowingVC;
}

@end

/**

 
 
 */

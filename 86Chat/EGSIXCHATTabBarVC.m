//
//  EGSIXCHATTabBarVC.m
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import "EGSIXCHATTabBarVC.h"
#import "EGSIXCHATLoginVC.h"

#import "HESIXCGATMessageVC.h"



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
    
    
    NSArray *ecgsoixVcs = @[HESIXCGATMessageVC.new,
                            HESIXCGATMessageVC.new,
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

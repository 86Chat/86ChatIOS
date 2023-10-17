//
//  EGSIXCHATMainVC.m
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import "EGSIXCHATMainVC.h"
#import "EGSIXCHATLoginVC.h"


@interface EGSIXCHATMainVC ()

@end

@implementation EGSIXCHATMainVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.shadowImage = UIImage.new;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loginVC {
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:EGSIXCHATLoginVC.new];
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)setStatusBarColorType:(StatusBarColor)colorType {
    if (colorType == StatusBarColorWhite) { // 白色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else if (colorType == StatusBarColorBlock) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (UIButton *)itemImage:(NSString *)img action:(SEL)action {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30.0, 30.0);
    rightButton.backgroundColor = UIColor.clearColor;
    [rightButton setImage:IMAGENAME(img) forState:UIControlStateNormal];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    rightButton.adjustsImageWhenHighlighted = NO;
    return rightButton;
}

- (UIButton *)itemTitle:(NSString *)title action:(SEL)action {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0, 30.0);
    rightButton.backgroundColor = UIColor.clearColor;
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return rightButton;
}

- (UILabel *)leftTitle:(NSString *)title len:(NSInteger)len {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 32.0)];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:22.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = UIColor.blackColor;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];
    [attr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(0, len)];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:24.0] range:NSMakeRange(0, len)];
    titleLabel.attributedText = attr;
    return titleLabel;
}

- (UILabel *)centerTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 32.0)];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.text = title;
    return titleLabel;
}


- (void)refreshEndStatus:(UIScrollView *)scrollView {
    if (scrollView.mj_header.isRefreshing) {
        [scrollView.mj_header endRefreshing];
    }
    if (scrollView.mj_footer.isRefreshing) {
        [scrollView.mj_footer endRefreshing];
    }
}


- (void)cornerView:(UIView *)view round:(CGFloat)round rectCorners:(UIRectCorner)rectCorners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(round, round)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = [maskPath CGPath];
    view.layer.mask = maskLayer;
}

@end

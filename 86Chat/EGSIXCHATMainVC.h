//
//  EGSIXCHATMainVC.h
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, StatusBarColor) {
    StatusBarColorWhite     = 0, // Never pre-load controller.
    StatusBarColorBlock = 1, // Pre-load the controller next to the current.
};

@interface EGSIXCHATMainVC : UIViewController

- (void)loginVC;

- (void)setStatusBarColorType:(StatusBarColor)colorType;


- (void)cornerView:(UIView *)view round:(CGFloat)round rectCorners:(UIRectCorner)rectCorners;

- (UIButton *)itemImage:(NSString *)img action:(SEL)action;
- (UILabel *)leftTitle:(NSString *)title len:(NSInteger)len;
- (UILabel *)centerTitle:(NSString *)title;
- (UIButton *)itemTitle:(NSString *)title action:(SEL)action;


- (void)refreshEndStatus:(UIScrollView *)scrollView;



@end

NS_ASSUME_NONNULL_END

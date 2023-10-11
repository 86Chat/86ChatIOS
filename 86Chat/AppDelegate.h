//
//  AppDelegate.h
//  86Chat
//
//  Created by Rubyuer on 9/27/23.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)main;

@property (strong, nonatomic) UIWindow * window;

- (void)enterRootViewController;

- (UIViewController *)getCurrentViewController;



@end

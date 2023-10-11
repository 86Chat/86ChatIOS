//
//  EGSIXDefine.h
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#ifndef EGSIXDefine_h
#define EGSIXDefine_h


#define ShareAppDelegate  ([UIApplication sharedApplication].delegate)

#define kCurrentVersion     @"CurrentVersion"
#define BundleVersion [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentVersion]
//获取当前版本号
#define BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//#define TabBarHeight (IS_IPAD ? (IS_NOTCHED_SCREEN ? 65 : (IOS_VERSION >= 12.0 ? 50 : 49)) : (IS_LANDSCAPE ? PreferredValueForVisualDevice(49, 32) : 49) + SafeAreaInsetsConstantForDeviceWithNotch.bottom)
#define TabBarHeight ([UIApplication.sharedApplication statusBarFrame].size.height)

// 弱引用self
#define WS(weakself)  __weak __typeof(&*self) weakself = self;

#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define NavigationHeight (HEIGHT >= 812.0 ? 88.0 : 64.0)
#define WIDTH_SCALE(width)  (width/375.0*WIDTH)

#define RGBA(RGB)  [UIColor colorWithRed:((CGFloat)((RGB & 0xFF0000)>>16))/255.0 green:((CGFloat)((RGB & 0xFF00)>>8))/255.0 blue:((CGFloat)(RGB & 0xFF))/255.0 alpha:1]

#define MAINCOLOR  RGBA(0xFFAE22)

#define   ISLOGIN     [[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGIN"]
#define   ISREVIEW     [[NSUserDefaults standardUserDefaults] boolForKey:kAppStatus]

#define kPageSize  10

#define IMAGENAME(x) [UIImage imageNamed:x]
#define URL(url) [NSURL URLWithString:url]

#define UNString(x, y) [NSString stringWithFormat:x, y]

#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

#define ShadowView(View, Radius, ShadowColor)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:NO];\
[View.layer setShadowColor:[ShadowColor CGColor]];\
[View.layer setShadowOpacity:0.3];\
[View.layer setShadowRadius:2.0];\
[View.layer setShadowOffset:CGSizeMake(1.0, 1.0)]


// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
});\




#endif /* EGSIXDefine_h */

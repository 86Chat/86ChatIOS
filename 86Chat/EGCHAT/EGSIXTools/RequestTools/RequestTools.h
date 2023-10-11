//
//  RequestTools.h
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestTools : NSObject

+ (instancetype)main;

/**
 * 发送验证码  phone   type 1-注册验证码，2-修改密码，3-验证码登录
 */
- (void)sendTheCode:(NSString *)phone type:(NSInteger)type button:(UIButton *)btn;

- (void)updateApp;

@end

NS_ASSUME_NONNULL_END

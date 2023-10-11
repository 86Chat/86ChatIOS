//
//  UserDataModel.h
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDataModel : NSObject

@property (nonatomic, copy)   NSString *bsc_private_key;

/// 0- 未设置, 1-已设置
@property (nonatomic, assign)   NSInteger pay_password;

#pragma mark -------------------以下是自增的字段-------------------

@property (nonatomic, assign) NSInteger count; // 藏品数量



@end


typedef void(^GetUserDataBlock)(BOOL isSuccess);

@interface UserData : NSObject

+ (instancetype)main;


/**
 用户信息
 */
@property (nonatomic, strong) UserDataModel *userDataModel;

/**
 写入个人信息
 */
+ (void)writeUserInfo:(id)dic;

/**
 修改个人信息
 @param value 个人信息数值
 @param key 个人信息的Key
 */
+ (void)reWriteUserInfo:(id)value ForKey:(NSString *)key;

/**
 清除与用户信息
 */
+ (void)cleanUserInfo;

/**
 获取用户信息数据
 */
- (void)getUserData:(GetUserDataBlock)block;
- (void)normalUserData:(GetUserDataBlock)block;




@end

NS_ASSUME_NONNULL_END

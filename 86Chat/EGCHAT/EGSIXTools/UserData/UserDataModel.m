//
//  UserDataModel.m
//  86Chat
//
//  Created by Rubyuer on 10/8/23.
//

#import "UserDataModel.h"

@implementation UserDataModel

@end


@implementation UserData

+ (instancetype)main {
    static dispatch_once_t once;
    static UserData *instance;
    dispatch_once(&once, ^{
        instance = [[UserData alloc] init];
    });
    return instance;
}


/**
 写入个人信息
 */
+ (void)writeUserInfo:(id)dic {
    if (dic == nil) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_data"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UserData.main.userDataModel = [UserDataModel mj_objectWithKeyValues:dic];
}
/**
 修改个人信息
 @param value 个人信息数值
 @param key 个人信息的Key
 */
+ (void)reWriteUserInfo:(id)value ForKey:(NSString *)key {
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_data"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:obj error:nil];
//    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict setValue:value forKey:key];
    [UserData writeUserInfo:dict];
    [UserData main].userDataModel = [UserDataModel mj_objectWithKeyValues:dict];
}

// 自定义写入我的藏品数量
+ (void)reWriteCollectionInfo:(NSDictionary *)resultDic {
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_data"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:NSDictionary.class fromData:obj error:nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [dict setValue:resultDic[@"count"] forKey:@"count"];
    [dict setValue:resultDic[@"sale_count"] forKey:@"sale_count"];
    [dict setValue:resultDic[@"sold_count"] forKey:@"sold_count"];
    [dict setValue:resultDic[@"manghe_count"] forKey:@"manghe_count"];
    [UserData writeUserInfo:dict];
    [UserData main].userDataModel = [UserDataModel mj_objectWithKeyValues:dict];
}
/**
 清除与用户信息
 */
+ (void)cleanUserInfo {
    //清除单例
    [UserData main].userDataModel = [[UserDataModel alloc] init];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -- setting and getting

- (UserDataModel *)userDataModel {
    if (!_userDataModel) {
        NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_data"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:NSDictionary.class fromData:obj error:nil];
//        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        _userDataModel = [UserDataModel mj_objectWithKeyValues:dic];
    }return _userDataModel;
}


/**
 获取用户信息数据
 */
- (void)getUserData:(GetUserDataBlock)block {
//    WS(weakself)
//    [KLNetworkHandler requestWithUrl:USER_USERINFO params:@{} showHUD:NO httpMedthod:KLNetWorkMethodGET successBlock:^(id responseObj) {
//        NSDictionary *dataDic = responseObj[@"data"];
//        if (dataDic == nil || dataDic.count == 0) {
//            if (block) {
//                block(NO);
//            }
//            return ;
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [UserData writeUserInfo:dataDic];
//            [weakself getCollectionsNumId:0 success:^(NSInteger count, NSInteger manghe_count, NSInteger sale_count, NSInteger sold_count) {
//            }];
//            [UserData.main getAccountData:^(BOOL isSuccess) {
//            }];
//            if (block) {
//                block(YES);
//            }
//        });
//    } failBlock:^(NSError *error) {
//        if (block) {
//            block(NO);
//        }
//    }];
}
- (void)normalUserData:(GetUserDataBlock)block {
//    [KLNetworkHandler requestWithUrl:USER_USERINFO params:@{} showHUD:NO httpMedthod:KLNetWorkMethodGET successBlock:^(id responseObj) {
//        NSDictionary *dataDic = responseObj[@"data"];
//        if (dataDic == nil || dataDic.count == 0) {
//            if (block) {
//                block(NO);
//            }
//            return ;
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [UserData reWriteUserInfo:dataDic[@"priority_count"] ForKey:@"priority_count"];
//            if (block) {
//                block(YES);
//            }
//        });
//    } failBlock:^(NSError *error) {
//        if (block) {
//            block(NO);
//        }
//    }];
}


@end

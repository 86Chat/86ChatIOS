//
//  APIMacro.h
//  86Chat
//
//  Created by Rubyuer on 9/28/23.
//

#ifndef APIMacro_h
#define APIMacro_h

#define kBaseServerUrl     @"BaseServerUrl"
#define kAppStatus     @"AppStatus"
#define kVersionSuccess     @"VersionSuccess"

//#define DEFAULT_URL @"test.uni-meta.com.cn"  // 默认测试环境
#define DEFAULT_URL @"eapi.uni-meta.com.cn"  //


#define SERVER_URL  [NSString stringWithFormat:@"https://%@/api", [[NSUserDefaults standardUserDefaults] valueForKey:kBaseServerUrl]]


#define PATH(_path)    [NSString stringWithFormat:_path, SERVER_URL]

 
#pragma mark - 完整的接口地址 ------------ ------------ ------------ ------------

/**
 * 获取版本域名
 */
#define INDEX_VERSION   PATH(@"%@/index/version")







#endif /* APIMacro_h */

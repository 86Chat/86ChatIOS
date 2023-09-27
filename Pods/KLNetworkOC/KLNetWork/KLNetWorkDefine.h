//
//  KLNetWorkDefine.h
//  Demo
//
//  Created by 雷珂阳 on 2018/1/2.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

#ifndef KLNetWorkDefine_h
#define KLNetWorkDefine_h

// 默认网络错误信息文本
#define KL_ERROR_IMFORMATION @"网络出现错误，请检查网络连接"
// 网络错误Log打印
#define KL_ERROR [NSError errorWithDomain:@"com.chenchaobang.KLNetworking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:KL_ERROR_IMFORMATION}]
// 缓存路径
#define DIRECTORYPATH [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"] stringByAppendingString:@"/KLNetWorking/"];
// 最大缓存大小（目前接口暂未做缓存）
#define MAX_CACHE_SIZE (10 * 1024 * 1024)
/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, KLNetworkStatus) {
    /**
     *  未知网络
     */
    KLNetworkStatusUnknown             = 1 << 0,
    /**
     *  无法连接
     */
    KLNetworkStatusNotReachable        = 1 << 2,
    /**
     *  网络正常
     */
    KLNetworkStatusNormal              = 1 << 3
};
/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, KLRequestType) {
    /**
     *  GET方式来进行请求
     */
    KLNetWorkMethodGET     = 1 << 0,
    /**
     *  POST方式来进行请求
     */
    KLNetWorkMethodPOST    = 1 << 1,
    /**
     *  PATCH方式来进行请求
     */
    KLNetWorkMethodPATCH   = 1 << 2,
    /**
     *  DELETE方式来进行请求
     */
    KLNetWorkMethodDELETE  = 1 << 3,
    /**
     *  PUT方式来进行请求
     */
    KLNetWorkMethodPUT     = 1 << 4
};

/**
 *  数据串行方式
 */
typedef NS_ENUM(NSInteger, KLSerializerType) {
    /**
     *  HTTP方式来进行请求或响应
     */
    KLHTTPSerializer = 1 << 0,
    /**
     *  JSON方式来进行请求或响应
     */
    KLJSONSerializer = 1 << 1
};

/**
 *  请求任务
 */
typedef NSURLSessionTask KLURLSessionTask;
/**
 *  成功回调
 *
 *  @param responseObj 成功后返回的数据
 */
typedef void(^KLResponseSuccessBlock)(id responseObj);
/**
 *  失败回调
 *
 *  @param error 失败后返回的错误信息
 */
typedef void(^KLResponseFailBlock)(NSError *error);
/**
 *  进度
 *
 *  @param bytesRead   已下载或者上传进度的大小
 *  @param totalBytes  总下载或者上传进度的大小
 */
typedef void(^KLNetWorkingProgress)(int64_t bytesRead,
                                    int64_t totalBytes);


#endif /* KLNetWorkDefine_h */

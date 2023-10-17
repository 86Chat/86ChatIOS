//
//  KLNetworkHandler.m
//  Demo
//
//  Created by 雷珂阳 on 2018/1/2.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

#import "KLNetworkHandler.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "DSToast.h"
#import "SVProgressHUD.h"

// 默认超时时间
#define TL_REQUEST_TIMEOUT 30.0

#pragma mark - 网络请求配置类
@interface KLNetworkManager ()

@end

@implementation KLNetworkManager
/**
 初始化单例
 */
+ (instancetype)sharedManager
{
    static KLNetworkManager *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[KLNetworkManager alloc] init];
        
        handler.isVerifyHttps = NO;
        handler.requestTimeout = TL_REQUEST_TIMEOUT;
        handler.isAllowInvalid = NO;
        handler.isDomainName = NO;
    });
    return handler;
}

@end

#pragma mark - 网络请求发起

static NSMutableArray      *requestTasks;
static NSMutableDictionary *headers;
static KLNetworkStatus     networkStatus;

@implementation KLNetworkHandler

#pragma 任务管理
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}
/**
 *  配置请求头
 *
 *  @param httpHeaders 请求头参数
 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeaders {
    headers = httpHeaders.mutableCopy;
}
/**
 *  取消所有请求
 */
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(KLURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[KLURLSessionTask class]]) {
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}
/**
 *  根据url取消请求
 *
 *  @param url 请求url
 */
+ (void)cancelRequestWithURL:(NSString *)url {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(KLURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[KLURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma SESSION管理设置
+ (AFHTTPSessionManager *)manager {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  默认请求和返回的数据类型
     */
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    // 将token加到http头里
    if ([KLNetworkManager sharedManager].baseToken.length) {
        [manager.requestSerializer setValue:[KLNetworkManager sharedManager].baseToken forHTTPHeaderField:@"token"];
    }
    /**
     *  取出NULL值
     */
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    /**
     *  如果不设置支持类型，可能会出现如下错误：
     *
     连接出错 Error Domain=com.alamofire.error.serialization.response Code=-1016
     "Request failed: unacceptable content-type: text/html" UserInfo=
     {com.alamofire.serialization.response.error.response=<NSHTTPURLResponse: 0x7f93fad1c4b0>
     { URL: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx }
     { status code: 200, headers { .....}
     ......
     22222c22 626f6172 64696422 3a226e65 77735f73 68656875 69375f62 6273222c 22707469 6d65223a 22323031 362d3033 2d303320 31313a30 323a3435 227d5d7d>,
     NSLocalizedDescription=Request failed: unacceptable content-type: text/html}
     */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    manager.requestSerializer.timeoutInterval = [KLNetworkManager sharedManager].requestTimeout;
    manager.requestSerializer.timeoutInterval = TL_REQUEST_TIMEOUT;
    
    [self detectNetworkStaus];
    if ([self totalCacheSize] > MAX_CACHE_SIZE) [self clearCaches];
    return manager;
}

+ (void)updateRequestSerializerType:(KLSerializerType)requestType responseSerializer:(KLSerializerType)responseType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (requestType) {
        switch (requestType) {
            case KLHTTPSerializer: {
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
            }
            case KLJSONSerializer: {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
    if (responseType) {
        switch (responseType) {
            case KLHTTPSerializer: {
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            }
            case KLJSONSerializer: {
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - 重写系统customSecurityPolicy方法
+ (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书,证书的路径
    NSString *cerPath = [KLNetworkManager sharedManager].cerPath;
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = [KLNetworkManager sharedManager].isAllowInvalid;
    
    //validatesDomainName 是否需要验证域名，默认为NO；
    securityPolicy.validatesDomainName = [KLNetworkManager sharedManager].isDomainName;
    securityPolicy.pinnedCertificates  = (NSSet *)@[certData];
    
    return securityPolicy;
}

#pragma 请求业务GET,POST
+ (KLURLSessionTask *)requestWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             showHUD:(BOOL)showHUD
                         httpMedthod:(KLRequestType)httpMethod
                        successBlock:(KLResponseSuccessBlock)successBlock
                           failBlock:(KLResponseFailBlock)failBlock {
    
    // 是否显示HUD提示器
    if (showHUD == YES) {
        [SVProgressHUD show];
    }
    NSLog(@"\nurl==%@\nparams==%@",url, params);
    
    AFHTTPSessionManager *sessionManager = [self manager];
    KLURLSessionTask *sessionTask;
    
    
    NSMutableDictionary *httpHeader = NSMutableDictionary.new;
    [httpHeader setValue:@"apifox/1.0.0 (https://www.apifox.cn)" forKey:@"User-Agent"];
    
    [self configHttpHeaders:httpHeader];
    
    // 请求前先判断是否有网络
    if (networkStatus == KLNetworkStatusNotReachable ||  networkStatus == KLNetworkStatusUnknown) {
        // 隐藏请求HUD
        [SVProgressHUD dismiss];
        [[DSToast toastWithText:@"无网络"] show];
        failBlock ? failBlock(KL_ERROR) : nil;
        return nil;
    }
    // get会话请求
    if (httpMethod == KLNetWorkMethodGET) {

        sessionTask = [sessionManager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 隐藏请求HUD
            [SVProgressHUD dismiss];
            // 判断请求接口是否成功（api_code = 0）
            if ([responseObject[@"code"] integerValue] == 0) {
                successBlock ? successBlock(responseObject) : nil;
            }else {
                failBlock ? failBlock(nil) : nil;
                [[DSToast toastWithText:responseObject[@"msg"]] show];
            }
            NSLog(@"\nresponseObject====%@",responseObject);
            // 移除当前请求
            [[self allTasks] removeObject:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 隐藏请求HUD
            [SVProgressHUD dismiss];
            // 移除当前请求
            [[self allTasks] removeObject:task];
            [task cancel];
        }];
    }
    // post会话请求
    else if (httpMethod == KLNetWorkMethodPOST){
        
        sessionTask = [sessionManager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 隐藏请求HUD
            [SVProgressHUD dismiss];
            // 判断请求接口是否成功（api_code = 0）
            if ([responseObject[@"code"] integerValue] == 0) {
                successBlock ? successBlock(responseObject) : nil;
            }else{
                failBlock ? failBlock(nil) : nil;
                [[DSToast toastWithText:responseObject[@"msg"]] show];
            }
            NSLog(@"\nresponseObject====%@",responseObject);
            // 移除当前请求
            [[self allTasks] removeObject:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 隐藏请求HUD
            [SVProgressHUD dismiss];
            // 移除当前请求
            [[self allTasks] removeObject:task];
            [task cancel];
        }];
    }
    
    // 将当前请求加入请求数组中
    if (sessionTask) {
        [requestTasks addObject:sessionTask];
    }
    return sessionTask;
}

#pragma 图片，文件上传下载方法
/**
 *  多图片上传接口
 *
 *    @param images       图片对象集合
 *    @param videos       视频对象集合
 *    @param url              请求路径
 *    @param params           拼接参数
 *    @param progressBlock    上传进度
 *    @param successBlock     成功回调
 *    @param failBlock        失败回调
 *
 *  @return 返回的对象中可取消请求
 */
+ (KLURLSessionTask *)uploadWithImages:(NSArray<UIImage *> *)images
                                 video:(NSArray <NSURL *>*)videos
                                   url:(NSString *)url
                                params:(NSDictionary *)params
                               showHUD:(BOOL)showHUD
                         progressBlock:(KLNetWorkingProgress)progressBlock
                          successBlock:(KLResponseSuccessBlock)successBlock
                             failBlock:(KLResponseFailBlock)failBlock {
    
    AFHTTPSessionManager *manager = [self manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    // 头部设置 - 开始
        NSMutableDictionary *httpHeader = NSMutableDictionary.new;
        [httpHeader setValue:@"apifox/1.0.0 (https://www.apifox.cn)" forKey:@"User-Agent"];
        
        NSInteger timestamp = (NSInteger)[[NSDate date] timeIntervalSince1970];
        [httpHeader setValue:[NSString stringWithFormat:@"%ld",timestamp] forKey:@"timestamp"];
//        [httpHeader setValue:[self accessToken:url timestamp:timestamp] forKey:@"access-token"];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"APP_TOKEN"];
        if (token != nil && token.length > 0) {
            [httpHeader setValue:token forKey:@"token"];
        }
        [self configHttpHeaders:httpHeader];
    // 头部设置 - 结束
    
    // 请求前先判断是否有网络
    if (networkStatus == KLNetworkStatusNotReachable ||  networkStatus == KLNetworkStatusUnknown) {
        // 隐藏请求HUD
        [SVProgressHUD dismiss];
        [DSToast toastWithText:@"无网络"];
        failBlock ? failBlock(KL_ERROR) : nil;
        return nil;
    }
    
    KLURLSessionTask *session = [manager POST:url parameters:params headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 判断是否有图片数据
        if (images.count == 0 && videos.count == 0) {
            NSLog(@"资源文件为空");
        }
        
        for (UIImage *img in images) {
            NSData *data = UIImageJPEGRepresentation(img, 0.3);
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/jpeg"];
        }
        for (NSURL *url in videos) {
            NSData *videoData = [NSData dataWithContentsOfURL:url];
            [formData appendPartWithFileData:videoData name:@"file" fileName:@"video.mp4" mimeType:@"video/mp4"];
        }
        // 循环添加数据 - KL自带的上传方式
//        for (id _Nullable uploadFile in imageArray) {
//            if ([uploadFile isKindOfClass:[KLUploadParam class]]) {
//
//                KLUploadParam *uploadParam = (KLUploadParam *)uploadFile;
//                [formData appendPartWithFileData:uploadParam.data name:uploadParam.paramKey
//                                        fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
//            }else{
//                NSLog(@"文件数组不是TLUploadParam对象，请检查文件数组类型");
//                return;
//            }
//        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        if (showHUD) {
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        // 判断请求接口是否成功（api_code = 0）
        if ([responseObject[@"code"] integerValue] == 0) {
            successBlock ? successBlock(responseObject) : nil;
        }else{
            failBlock ? failBlock(nil) : nil;
            [[DSToast toastWithText:responseObject[@"msg"]] show];
        }
        NSLog(@"\nurl==%@\nparams==%@\nresponseObject==%@",url, params, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock ? failBlock(error) : nil;
        
        [SVProgressHUD dismiss];
        [[self allTasks] removeObject:task];
    }];
    
    [session resume];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

+ (KLURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                                showHUD:(BOOL)showHUD
                          progressBlock:(KLNetWorkingProgress)progressBlock
                           successBlock:(KLResponseSuccessBlock)successBlock
                              failBlock:(KLResponseFailBlock)failBlock {
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    KLURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
        if (showHUD) {
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"上传中"];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        [SVProgressHUD dismiss];
        
        successBlock ? successBlock(responseObject) : nil;
        
        failBlock && error ? failBlock(error) : nil;
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
#pragma mark - 网络状态的检测
+ (void)detectNetworkStaus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            networkStatus = KLNetworkStatusNotReachable;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            networkStatus = KLNetworkStatusUnknown;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi){
            networkStatus = KLNetworkStatusNormal;
        }
    }];
}

#pragma 缓存处理
+ (void)cacheResponseObject:(id)responseObject
                    request:(NSURLRequest *)request
                     params:(NSDictionary *)params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = DIRECTORYPATH;
        
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }
        
        NSString *originString = [NSString stringWithFormat:@"%@+%@",request.URL.absoluteString,params];
        
        NSString *path = [directoryPath stringByAppendingPathComponent:[self md5:originString]];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        if (data && error == nil) {
            [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        }
    }
}

+ (NSString *)md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

+ (id)getCacheResponseWithURL:(NSString *)url
                       params:(NSDictionary *)params {
    id cacheData = nil;
    
    if (url) {
        NSString *directoryPath = DIRECTORYPATH;
        
        NSString *originString = [NSString stringWithFormat:@"%@+%@",url,params];
        
        NSString *path = [directoryPath stringByAppendingPathComponent:[self md5:originString]];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
    }
    return cacheData;
}

+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = DIRECTORYPATH;
    
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total;
}

+ (void)clearCaches {
    NSString *directoryPath = DIRECTORYPATH;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    }
}

@end


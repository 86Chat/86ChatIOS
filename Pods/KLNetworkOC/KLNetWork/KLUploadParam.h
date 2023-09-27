//
//  KLUploadParam.h
//  Demo
//
//  Created by 雷珂阳 on 2018/1/2.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KLUploadParam : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *paramKey;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;
/**
 *  如果是图片，则上传的图片压缩比例（0 - 1）浮点型
 */
@property (nonatomic, assign) CGFloat quality;

@end


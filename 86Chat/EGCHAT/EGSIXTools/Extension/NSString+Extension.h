//
//  NSString+Extension.h
//  UNI Z META
//
//  Created by Rubyuer on 8/31/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

- (NSString *)md5;



- (BOOL)checkPhoneNum;
- (BOOL)checkPassword;

/**
 *  身份证号全校验
 */
//- (BOOL)verifyIDCardNumber;

@end

NS_ASSUME_NONNULL_END

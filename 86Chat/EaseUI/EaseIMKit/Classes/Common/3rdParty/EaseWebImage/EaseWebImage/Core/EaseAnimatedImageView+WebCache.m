/*
 * This file is part of the EaseWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "EaseAnimatedImageView+WebCache.h"

#if Ease_UIKIT || Ease_MAC

#import "UIView+EaseWebCache.h"
#import "EaseAnimatedImage.h"

@implementation EaseAnimatedImageView (WebCache)

- (void)Ease_setImageWithURL:(nullable NSURL *)url {
    [self Ease_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(EaseWebImageOptions)options {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(EaseWebImageOptions)options context:(nullable EaseWebImageContext *)context {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:options context:context progress:nil completed:nil];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url completed:(nullable EaseExternalCompletionBlock)completedBlock {
    [self Ease_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable EaseExternalCompletionBlock)completedBlock {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(EaseWebImageOptions)options completed:(nullable EaseExternalCompletionBlock)completedBlock {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(EaseWebImageOptions)options progress:(nullable EaseImageLoaderProgressBlock)progressBlock completed:(nullable EaseExternalCompletionBlock)completedBlock {
    [self Ease_setImageWithURL:url placeholderImage:placeholder options:options context:nil progress:progressBlock completed:completedBlock];
}

- (void)Ease_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(EaseWebImageOptions)options
                   context:(nullable EaseWebImageContext *)context
                  progress:(nullable EaseImageLoaderProgressBlock)progressBlock
                 completed:(nullable EaseExternalCompletionBlock)completedBlock {
    Class animatedImageClass = [EaseAnimatedImage class];
    EaseWebImageMutableContext *mutableContext;
    if (context) {
        mutableContext = [context mutableCopy];
    } else {
        mutableContext = [NSMutableDictionary dictionary];
    }
    mutableContext[EaseWebImageContextAnimatedImageClass] = animatedImageClass;
    [self ease_internalSetImageWithURL:url
                    placeholderImage:placeholder
                             options:options
                             context:mutableContext
                       setImageBlock:nil
                            progress:progressBlock
                           completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, EaseImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                               if (completedBlock) {
                                   completedBlock(image, error, cacheType, imageURL);
                               }
                           }];
}

@end

#endif

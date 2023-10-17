//
//  HESIXCGATQrcodeVC.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "HESIXCGATQrcodeVC.h"
#import "QiCodePreviewView.h"
#import "QiCodeManager.h"


@interface HESIXCGATQrcodeVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) QiCodePreviewView *previewView;
@property (nonatomic, strong) QiCodeManager *codeManager;

@end

@implementation HESIXCGATQrcodeVC

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
////    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
////    self.navigationController.navigationBar.subviews[0].alpha = 0.0;
//    [self startScanning];
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
////    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
////    self.navigationController.navigationBar.subviews[0].alpha = 1.0;
//    [_codeManager stopScanning];
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.subviews[0].alpha = 0.0;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self startScanning];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.subviews[0].alpha = 1.0;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    [_codeManager stopScanning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [self centerTitle:@"扫一扫"];
    UIButton *btn = [self itemTitle:@"相册" action:@selector(photo:)];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self itemImage:@"eogcsaioxArrowLW" action:@selector(back)]];
    
    _previewView = [[QiCodePreviewView alloc] initWithFrame:self.view.bounds];
    _previewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_previewView];
    
    WS(weakself)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.codeManager = [[QiCodeManager alloc] initWithPreviewView:weakself.previewView completion:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself startScanning];
                });
            }];
        });
    });
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action functions

- (void)photo:(id)sender {
    [_codeManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
//        [weakSelf performSegueWithIdentifier:@"showCodeGeneration" sender:code];
        NSLog(@"code==1==%@\n",code);
    }];
}


#pragma mark - Private functions

- (void)startScanning {
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
        NSLog(@"code==2==%@",code);
    } autoStop:YES];
}




- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

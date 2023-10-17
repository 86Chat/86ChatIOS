//
//  HESIXCGATSearchFriendVC.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "HESIXCGATSearchFriendVC.h"

@interface HESIXCGATSearchFriendVC ()

@property (weak, nonatomic) IBOutlet UIView *oxgcseoaiBgView;

@property (weak, nonatomic) IBOutlet UITextField *oxgcseoaiTitleTF;

@property (weak, nonatomic) IBOutlet UIButton *oxgcseoaiSearchButton;

@end

@implementation HESIXCGATSearchFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索朋友";
    
    ViewRadius(_oxgcseoaiBgView, 15.0)
    ViewRadius(_oxgcseoaiSearchButton, 15.0)
}

- (IBAction)oxgcseoaiSearch:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_oxgcseoaiTitleTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:_oxgcseoaiTitleTF.placeholder];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

//
//  HESIXCGATAddGroupVC.m
//  86Chat
//
//  Created by Rubyuer on 10/13/23.
//

#import "HESIXCGATAddGroupVC.h"
#import "HESIXCGATAddGroupCVCell.h"

@interface HESIXCGATAddGroupVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *oxgcseoaiCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *oxgcseoaiLayout;

@property (weak, nonatomic) IBOutlet UIImageView *oxgcseoaiGroupView;

@property (weak, nonatomic) IBOutlet UIView *oxgcseoaiTitleView;
@property (weak, nonatomic) IBOutlet UITextField *oxgcseoaiTitleTF;


@property (strong, nonatomic) UIImagePickerController *pickerController;

@end

@implementation HESIXCGATAddGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新建群聊";
    UIButton *item = [self itemTitle:@"确定" action:@selector(oxgcseoaiOk)];
    [item setTitleColor:RGBA(0xFFAE22) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
    
    ViewRadius(_oxgcseoaiTitleView, 15.0);
    ViewRadius(_oxgcseoaiGroupView, 20.0);
    
//    _oxgcseoaiTitleTF.placeholder = [NSString stringWithFormat:@"%@、%@",_oxgcseoais.firstObject.userId, _oxgcseoais[1].userId];
    
    _oxgcseoaiLayout.sectionInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0);
    _oxgcseoaiLayout.itemSize = CGSizeMake(60.0, 60.0);
    _oxgcseoaiLayout.minimumInteritemSpacing = 0.0;
    _oxgcseoaiLayout.minimumLineSpacing = 10.0;
    _oxgcseoaiCollectionView.delegate = self;
    _oxgcseoaiCollectionView.dataSource = self;
    [_oxgcseoaiCollectionView registerNib:[UINib nibWithNibName:@"HESIXCGATAddGroupCVCell" bundle:nil] forCellWithReuseIdentifier:@"HESIXCGATAddGroupCVCell"];
}

- (void)oxgcseoaiOk {
    if (_oxgcseoaiTitleTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写群名称"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"您确定要创建群聊吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    WS(weakself)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakself createGroup];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)createGroup {
//    NSMutableArray *userIds = NSMutableArray.new;
//    for (NSInteger i = 0; i < self.oxgcseoais.count; i ++) {
//        if (i == 0) {
//            continue;
//        }
//        [userIds addObject:self.oxgcseoais[i].userId];
//    }


}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.oxgcseoais.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HESIXCGATAddGroupCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HESIXCGATAddGroupCVCell" forIndexPath:indexPath];
//    cell.userInfo = self.oxgcseoais[indexPath.row];
    return cell;
}



- (void)uploadImage:(UIImage *)icon_img {
//    WS(weakself)
//    [KLNetworkHandler uploadWithImages:@[icon_img] video:@[] url:UPLOAD_UPLOADFILE params:@{} showHUD:YES progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
//
//    } successBlock:^(id responseObj) {
//        NSString *path = responseObj[@"data"][@"path"];
//        if (path.length <= 0) {
//            return;
//        }
//        [weakself editUserInfo:path nick_name:@""];
//    } failBlock:^(NSError *error) {
//
//    }];
}

- (IBAction)oxgcseoaiGroupicon:(UIButton *)sender {
    [self.view endEditing:YES];
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

- (UIImagePickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerController.delegate = self;
    }
    return _pickerController;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *icon_image = info[UIImagePickerControllerOriginalImage];
    WS(weakself)
    dispatch_async(dispatch_get_main_queue(), ^{
        weakself.oxgcseoaiGroupView.image = icon_image;
        [weakself uploadImage:icon_image];
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

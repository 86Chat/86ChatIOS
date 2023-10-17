//
//  HESIXCGATChooseContactVC.m
//  86Chat
//
//  Created by Rubyuer on 10/13/23.
//

#import "HESIXCGATChooseContactVC.h"
#import "HESIXCGATContactInfoCVCell.h"
#import "HESIXCGATContactIconCVCell.h"

#import "HESIXCGATAddGroupVC.h"

@interface HESIXCGATChooseContactVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconCollectionHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *iconCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *iconLayout;
@property(nonatomic, strong) NSMutableArray<EMUserInfo *> *iconArray;

@property (weak, nonatomic) IBOutlet UICollectionView *oxgcseoaiCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *oxgcseoaiLayout;
@property(nonatomic, strong) NSMutableArray<EMUserInfo *> *oxgcseoais;

@property (weak, nonatomic) IBOutlet UIButton *oxgcseoaiOkButton;

@end

@implementation HESIXCGATChooseContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择联系人";
    self.view.backgroundColor = RGBA(0xF6F6F6);
    
    ViewRadius(_oxgcseoaiOkButton, 16.0);
    
    [self requestData];
    _iconCollectionHeight.constant = 0.0;
    _iconLayout.sectionInset = UIEdgeInsetsMake(0.0, 17.5, 0.0, 17.5);
    _iconLayout.itemSize = CGSizeMake(40.0, 40.0);
    _iconLayout.minimumInteritemSpacing = 0.0;
    _iconLayout.minimumLineSpacing = 20.0;
    _iconCollectionView.delegate = self;
    _iconCollectionView.dataSource = self;
    [_iconCollectionView registerNib:[UINib nibWithNibName:@"HESIXCGATContactIconCVCell" bundle:nil] forCellWithReuseIdentifier:@"HESIXCGATContactIconCVCell"];
    
    _oxgcseoaiLayout.sectionInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
    _oxgcseoaiLayout.itemSize = CGSizeMake(WIDTH, 56.0);
    _oxgcseoaiLayout.minimumInteritemSpacing = 0.0;
    _oxgcseoaiLayout.minimumLineSpacing = 0.0;
    _oxgcseoaiCollectionView.delegate = self;
    _oxgcseoaiCollectionView.dataSource = self;
    [_oxgcseoaiCollectionView registerNib:[UINib nibWithNibName:@"HESIXCGATContactInfoCVCell" bundle:nil] forCellWithReuseIdentifier:@"HESIXCGATContactInfoCVCell"];
}

- (void)requestData {
    [self.oxgcseoais removeAllObjects];
    
    NSArray *aList = [EMClient.sharedClient.contactManager getContacts];
    WS(weakself)
    [EMClient.sharedClient.userInfoManager fetchUserInfoById:aList completion:^(NSDictionary * _Nullable aUserDatas, EMError * _Nullable aError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSString *user in aList) {
                EMUserInfo *userInfo = aUserDatas[user];
                [weakself.oxgcseoais addObject:userInfo];
            }
            [weakself.oxgcseoaiCollectionView reloadData];
        });
    }];
}

- (IBAction)oxgcseoaiOk:(UIButton *)sender {
    if (_iconArray.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择好友"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if (_iconArray.count < 2) {
        [SVProgressHUD showErrorWithStatus:@"群聊的成员不能小于2个"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    HESIXCGATAddGroupVC *vc = HESIXCGATAddGroupVC.new;
    vc.oxgcseoais = _iconArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _iconCollectionView) {
        return self.iconArray.count;
    }else {
        return self.oxgcseoais.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _iconCollectionView) {
        HESIXCGATContactIconCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HESIXCGATContactIconCVCell" forIndexPath:indexPath];
        [cell.oxgcseoaiIconView sd_setImageWithURL:URL(_iconArray[indexPath.row].avatarUrl) placeholderImage:IMAGENAME(@"eogcsaioxIcon")];
        return cell;
    }
    HESIXCGATContactInfoCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HESIXCGATContactInfoCVCell" forIndexPath:indexPath];
    cell.userInfo = self.oxgcseoais[indexPath.row];
    
    cell.oxgcseoaiSelectButton.tag = indexPath.row;
    [cell.oxgcseoaiSelectButton addTarget:self action:@selector(oxgcseoaiSelect:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _iconCollectionView) {
        return;
    }
    
    
}

- (void)oxgcseoaiSelect:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    EMUserInfo *userInfo = self.oxgcseoais[sender.tag];
    userInfo.ext = (sender.selected ? @"1" : @"0");
    
    if (sender.selected) {
        [self.iconArray addObject:userInfo];
    }else {
        [self.iconArray removeObject:userInfo];
    }
    [_iconCollectionView reloadData];
    _iconCollectionHeight.constant = 70.0 * MIN(self.iconArray.count, 1);
    [_oxgcseoaiOkButton setTitle:UNString(@"确定(%ld)", self.iconArray.count) forState:UIControlStateNormal];
}


- (NSMutableArray<EMUserInfo *> *)iconArray {
    if (!_iconArray) {
        _iconArray = NSMutableArray.new;
    }return _iconArray;
}
- (NSMutableArray<EMUserInfo *> *)oxgcseoais {
    if (!_oxgcseoais) {
        _oxgcseoais = NSMutableArray.new;
    }return _oxgcseoais;
}
@end

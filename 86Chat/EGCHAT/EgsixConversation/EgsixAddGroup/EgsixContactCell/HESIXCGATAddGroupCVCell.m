//
//  HESIXCGATAddGroupCVCell.m
//  86Chat
//
//  Created by Rubyuer on 10/13/23.
//

#import "HESIXCGATAddGroupCVCell.h"

@interface HESIXCGATAddGroupCVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *oxgcseoaiIconView;
@property (weak, nonatomic) IBOutlet UILabel *oxgcseoaiNameLabel;


@end
@implementation HESIXCGATAddGroupCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(_oxgcseoaiIconView, 20.0);
}

- (void)setUserInfo:(EMUserInfo *)userInfo {
    _userInfo = userInfo;
    
    [_oxgcseoaiIconView sd_setImageWithURL:URL(_userInfo.avatarUrl) placeholderImage:IMAGENAME(@"eogcsaioxIcon")];
    _oxgcseoaiNameLabel.text = _userInfo.userId;
}

@end

//
//  HESIXCGATMessageTVCell.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "HESIXCGATMessageTVCell.h"

@interface HESIXCGATMessageTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *oxgcseoaiIconView;
@property (weak, nonatomic) IBOutlet UILabel *oxgcseoaiNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oxgcseoaiDescLabel;

@property (weak, nonatomic) IBOutlet UILabel *oxgcseoaiNumLabel;

@end

@implementation HESIXCGATMessageTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    ViewRadius(_oxgcseoaiNumLabel, 8.0)
    ViewRadius(_oxgcseoaiIconView, 25.0)
}

- (void)setModel:(EMConversation *)model {
    _model = model;
    
//    _oxgcseoaiIconView sd_setImageWithURL:URL(_model.a)
    
}

@end

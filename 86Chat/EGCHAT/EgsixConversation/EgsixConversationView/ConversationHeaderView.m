//
//  ConversationHeaderView.m
//  86Chat
//
//  Created by Rubyuer on 10/12/23.
//

#import "ConversationHeaderView.h"

@interface ConversationHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *oxgcseoaiBgView;

@end

@implementation ConversationHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ConversationHeaderView" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, WIDTH, 115.0);

        ViewRadius(_oxgcseoaiBgView, 16.0);
    }
    return self;
}


@end

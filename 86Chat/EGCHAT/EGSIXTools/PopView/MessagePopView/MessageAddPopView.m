//
//  MessageAddPopView.m
//  86Chat
//
//  Created by Rubyuer on 10/10/23.
//

#import "MessageAddPopView.h"

@interface MessageAddPopView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation MessageAddPopView

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MessageAddPopView" owner:self options:nil] lastObject];
        self.frame = ShareAppDelegate.window.frame;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    }
    return self;
}

- (void)show {
    [ShareAppDelegate.window addSubview:self];
}

- (IBAction)act:(UIButton *)sender {
    if (_typeBlock) {
        _typeBlock(sender.tag);
    }
    [self removeFromSuperview];
}

- (void)close {
    [self removeFromSuperview];
}

@end

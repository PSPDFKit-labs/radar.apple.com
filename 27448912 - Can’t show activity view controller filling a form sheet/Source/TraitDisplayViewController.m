#import "TraitDisplayViewController.h"

@interface TraitDisplayViewController ()

@property (nonatomic, readonly) UILabel *traitLabel;

@end

@implementation TraitDisplayViewController

@synthesize traitLabel = _traitLabel;

- (UILabel *)traitLabel {
    if (_traitLabel) return _traitLabel;

    _traitLabel = [[UILabel alloc] init];
    _traitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _traitLabel.backgroundColor = [UIColor whiteColor];

    return _traitLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.traitLabel];
    [self.traitLabel.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:20].active = YES;
    [self.traitLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self updateTraitLabelTextWithTraitCollection:self.traitCollection];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self updateTraitLabelTextWithTraitCollection:newCollection];
    }];
}

- (void)updateTraitLabelTextWithTraitCollection:(UITraitCollection *)traitCollection {
    self.traitLabel.text = [NSString stringWithFormat:@"%@ width × %@ height", shortDecriptionFromSizeClass(traitCollection.horizontalSizeClass), shortDecriptionFromSizeClass(traitCollection.verticalSizeClass)];
}

static NSString *shortDecriptionFromSizeClass(UIUserInterfaceSizeClass sizeClass) {
    switch (sizeClass) {
        case UIUserInterfaceSizeClassUnspecified: return @"?";
        case UIUserInterfaceSizeClassCompact: return @"Compact";
        case UIUserInterfaceSizeClassRegular: return @"Regular";
    }
}

@end

//
//  ViewController.m
//  RippleEffectView
//
//  Created by Ju on 16/9/7.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "ViewController.h"
#import "JuCell.h"
#import "RippleView.h"


#define Edge 10

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) RippleView *ripple;

@property (assign, nonatomic) BOOL firstLoad;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstLoad = true;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
        
    self.collectionView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    NSLog(@"......");
//    return UIStatusBarStyleLightContent;
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.ripple restartLayersAnimation];
}

#pragma mark - Collection View DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 1 : 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JuCell *cell = (JuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Ju" forIndexPath:indexPath];
    [cell layoutIfNeeded];
    
    cell.imageView.layer.cornerRadius = CGRectGetHeight(cell.imageView.bounds) / 2;
    cell.imageView.clipsToBounds = true;
    
    
    if (indexPath.row == 0 && self.firstLoad) {
        self.firstLoad = false;
        
        
//        CGPoint center = [collectionView convertPoint:cell.imageView.center toView:collectionView];
        
        CGPoint center = CGPointMake(cell.imageView.center.x, cell.imageView.center.y);
        self.ripple = [[RippleView alloc] initWithFrame:cell.frame];
        [self.ripple showAnimationWithCenterPoint: center
                                        fromValue:50
                                          toValue:CGRectGetWidth(collectionView.bounds) / 3];
        [cell.colorView insertSubview:self.ripple belowSubview:cell.imageView];
    }
    return cell;
}

#pragma mark - Layout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds),
                          CGRectGetHeight(collectionView.bounds) / 1.5);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds) - 2 * Edge, (CGRectGetWidth(collectionView.bounds) - 2 * Edge) * 2 / 3);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section != 0) {
        return UIEdgeInsetsMake(2 * Edge, Edge, Edge, Edge);
    }
    
//    return UIEdgeInsetsMake(5 * Edge, 0, Edge, 0);

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Edge;
}

@end

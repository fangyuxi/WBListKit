//
//  JKLayout.h
//  UICollectionView-separator
//
//  Created by Jaanus Kase on 12.04.14.
//  Copyright (c) 2014 Jaanus Kase. All rights reserved.
//

#import <UIKit/UIKit.h>



FOUNDATION_EXPORT NSString *const SeparatorViewKind;



@protocol JKSeparatorLayoutDelegate <NSObject>

/// Index path above which the separator should be shown, or nil if no separator is present.
- (NSIndexPath *)indexPathForSeparator;

@end



@interface JKSeparatorLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) IBOutlet id<JKSeparatorLayoutDelegate> separatorLayoutDelegate;

@end

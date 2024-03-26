//
//  RepliesCollectionViewCell.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "DynamicListPlatterCell.hpp"
#import "RepliesItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface RepliesCollectionViewCell : DynamicListPlatterCell
- (void)updateItemModel:(RepliesItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END

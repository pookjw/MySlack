//
//  ThreadsCollectionViewCell.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/25/24.
//

#import "DynamicListPlatterCell.hpp"
#import "ThreadsItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface ThreadsCollectionViewCell : DynamicListPlatterCell
- (void)updateItemModel:(ThreadsItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END

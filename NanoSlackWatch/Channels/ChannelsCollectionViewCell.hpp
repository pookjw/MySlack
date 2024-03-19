//
//  ChannelsCollectionViewCell.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "DynamicListPlatterCell.hpp"
#import "ChannelsItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface ChannelsCollectionViewCell : DynamicListPlatterCell
- (void)updateItemModel:(ChannelsItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END

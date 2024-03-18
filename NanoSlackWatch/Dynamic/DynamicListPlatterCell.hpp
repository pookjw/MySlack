//
//  DynamicListPlatterCell.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "DynamicView.hpp"

NS_ASSUME_NONNULL_BEGIN

@interface DynamicListPlatterCell : DynamicView
@property(nonatomic, getter=isSelected) BOOL selected;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;
- (void)prepareForReuse;
@end

NS_ASSUME_NONNULL_END

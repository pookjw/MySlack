//
//  ChannelsSectionModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/19/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ChannelsSectionModelType) {
    ChannelsSectionModelTypeChannels,
    ChannelsSectionModelTypeGroups,
    ChannelsSectionModelTypeIms,
    ChannelsSectionModelTypeMims,
    ChannelsSectionModelTypePrivates
};

__attribute__((objc_direct_members))
@interface ChannelsSectionModel : NSObject
@property (assign, readonly, nonatomic) ChannelsSectionModelType type;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(ChannelsSectionModelType)type;
@end

NS_ASSUME_NONNULL_END

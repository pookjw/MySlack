//
//  ChannelsItemModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/19/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ChannelsItemModelType) {
    ChannelsItemModelTypeChannel
};

// NSDictionary *
extern NSString * const ChannelsItemModelChannelKey NS_SWIFT_NAME(ChannelsItemModel.channelKey);

__attribute__((objc_direct_members))
@interface ChannelsItemModel : NSObject
@property (assign, readonly, nonatomic) ChannelsItemModelType type;
@property (copy) NSDictionary<NSString *, id> * _Nullable userInfo;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(ChannelsItemModelType)type;
@end

NS_ASSUME_NONNULL_END

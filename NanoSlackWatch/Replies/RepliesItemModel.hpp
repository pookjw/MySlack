//
//  RepliesItemModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RepliesItemModelType) {
    RepliesItemModelTypeOriginalMessage,
    RepliesItemModelTypeReply
};

// NSDictionary *
extern NSString * const RepliesItemModelMessageKey NS_SWIFT_NAME(RepliesItemModel.messageKey);

__attribute__((objc_direct_members))
@interface RepliesItemModel : NSObject
@property (assign, readonly, nonatomic) RepliesItemModelType type;
@property (copy) NSDictionary<NSString *, id> * _Nullable userInfo;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(RepliesItemModelType)type;
@end

NS_ASSUME_NONNULL_END

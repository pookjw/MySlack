//
//  ThreadsItemModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/24/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ThreadsItemModelType) {
    ThreadsItemModelTypeMessage
};

// NSDictionary *
extern NSString * const ThreadsItemModelMessageKey NS_SWIFT_NAME(ThreadsItemModel.messageKey);

__attribute__((objc_direct_members))
@interface ThreadsItemModel : NSObject
@property (assign, readonly, nonatomic) ThreadsItemModelType type;
@property (copy) NSDictionary<NSString *, id> * _Nullable userInfo;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(ThreadsItemModelType)type;
@end

NS_ASSUME_NONNULL_END

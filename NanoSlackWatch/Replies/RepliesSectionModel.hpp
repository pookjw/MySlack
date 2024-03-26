//
//  RepliesSectionModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RepliesSectionModelType) {
    RepliesSectionModelTypeOriginalMessage,
    RepliesSectionModelTypeReplies
};

__attribute__((objc_direct_members))
@interface RepliesSectionModel : NSObject
@property (assign, readonly, nonatomic) RepliesSectionModelType type;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(RepliesSectionModelType)type;
@end

NS_ASSUME_NONNULL_END

//
//  RepliesViewController.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "DynamicViewController.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface RepliesViewController : DynamicViewController
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithChannelID:(NSString *)channelID threadID:(NSString *)threadID;
@end

NS_ASSUME_NONNULL_END

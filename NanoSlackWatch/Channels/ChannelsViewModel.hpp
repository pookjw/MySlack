//
//  ChannelsViewModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import <Foundation/Foundation.h>
#import "ChannelsSectionModel.hpp"
#import "ChannelsItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface ChannelsViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id)dataSource;
- (void)loadDataSourceWithCompletionHandler:(void (^ _Nullable)())completionaHandler;
@end

NS_ASSUME_NONNULL_END

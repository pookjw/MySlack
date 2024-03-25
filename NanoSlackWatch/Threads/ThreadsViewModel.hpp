//
//  ThreadsViewModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/24/24.
//

#import <Foundation/Foundation.h>
#import "ThreadsItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface ThreadsViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithChannelID:(NSString *)channelID dataSource:(id)dataSource;
- (void)loadDataSourceWithCompletionHandler:(void (^ _Nullable)(NSError * _Nullable error))completionaHandler;
- (void)itemModelAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^ _Nullable)(ThreadsItemModel * _Nullable itemModel))completionHandler;
@end

NS_ASSUME_NONNULL_END

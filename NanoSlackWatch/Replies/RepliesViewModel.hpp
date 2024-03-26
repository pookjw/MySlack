//
//  RepliesViewModel.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import <Foundation/Foundation.h>
#import "RepliesSectionModel.hpp"
#import "RepliesItemModel.hpp"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface RepliesViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id)dataSource;
- (void)loadDataSourceWithChannelID:(NSString *)channelID threadID:(NSString *)threadID completionHandler:(void (^ _Nullable)(NSError * _Nullable error))completionaHandler;
@end

NS_ASSUME_NONNULL_END

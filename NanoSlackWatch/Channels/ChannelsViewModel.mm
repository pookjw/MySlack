//
//  ChannelsViewModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import "ChannelsViewModel.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
@import SlackCore;

__attribute__((objc_direct_members))
@interface ChannelsViewModel ()
@property (retain, readonly, nonatomic) id dataSource;
@property (retain, nonatomic, readonly) dispatch_queue_t queue;
@end

@implementation ChannelsViewModel

- (instancetype)initWithDataSource:(id)dataSource {
    if (self = [super init]) {
        _dataSource = [dataSource retain];
        
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, QOS_MIN_RELATIVE_PRIORITY);
        _queue = dispatch_queue_create("ChannelsViewModel", attr);
    }
    
    return self;
}

- (void)dealloc {
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithCompletionHandler:(void (^)(NSError * _Nullable error))completionaHandler {
    auto queue = self.queue;
    id dataSource = self.dataSource;
    
    dispatch_async(queue, ^{
        SlackCore::SlackAPIService::getSharedInstance().getConversationsListDictionary(^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                completionaHandler(error);
                return;
            }
            
            dispatch_async(queue, ^{
                id snapshot = [objc_lookUpClass("NSDiffableDataSourceSnapshot") new];
                
                auto channels = [NSMutableArray<ChannelsItemModel *> array];
                auto groups = [NSMutableArray array];
                auto ims = [NSMutableArray array];
                auto mpims = [NSMutableArray array];
                auto privates = [NSMutableArray array];
                
                for (NSDictionary *channel in dictionary[@"channels"]) {
                    ChannelsItemModel *itemModel = [[ChannelsItemModel alloc] initWithType:ChannelsItemModelTypeChannel];
                    itemModel.userInfo = @{ChannelsItemModelChannelKey: channel};
                    
                    BOOL is_channel = static_cast<NSNumber *>(channel[@"is_channel"]).boolValue;
                    
                    if (is_channel) {
                        [channels addObject:itemModel];
                        [itemModel release];
                        continue;
                    }
                    
                    BOOL is_group = static_cast<NSNumber *>(channel[@"is_group"]).boolValue;
                    
                    if (is_group) {
                        [groups addObject:itemModel];
                        [itemModel release];
                        continue;
                    }
                    
                    BOOL is_im = static_cast<NSNumber *>(channel[@"is_im"]).boolValue;
                    
                    if (is_im) {
                        [ims addObject:itemModel];
                        [itemModel release];
                        continue;
                    }
                    
                    BOOL is_mpim = static_cast<NSNumber *>(channel[@"is_mpim"]).boolValue;
                    
                    if (is_mpim) {
                        [mpims addObject:itemModel];
                        [itemModel release];
                        continue;
                    }
                    
                    BOOL is_private = static_cast<NSNumber *>(channel[@"is_private"]).boolValue;
                    
                    if (is_private) {
                        [privates addObject:itemModel];
                        [itemModel release];
                        continue;
                    }
                    
                    [itemModel release];
                }
                
                //
                
                if (channels.count > 0) {
                    ChannelsSectionModel *channelsSectionModel = [[ChannelsSectionModel alloc] initWithType:ChannelsSectionModelTypeChannels];
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[channelsSectionModel]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), channels, channelsSectionModel);
                    
                    [channelsSectionModel release];
                }
                
                if (groups.count > 0) {
                    ChannelsSectionModel *groupsSectionModel = [[ChannelsSectionModel alloc] initWithType:ChannelsSectionModelTypeGroups];
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[groupsSectionModel]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), groups, groupsSectionModel);
                    
                    [groupsSectionModel release];
                }
                
                if (ims.count > 0) {
                    ChannelsSectionModel *imsSectionModel = [[ChannelsSectionModel alloc] initWithType:ChannelsSectionModelTypeIms];
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[imsSectionModel]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), ims, imsSectionModel);
                    
                    [imsSectionModel release];
                }
                
                if (mpims.count > 0) {
                    ChannelsSectionModel *mpimsSectionModel = [[ChannelsSectionModel alloc] initWithType:ChannelsSectionModelTypeMims];
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[mpimsSectionModel]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), mpims, mpimsSectionModel);
                    
                    [mpimsSectionModel release];
                }
                
                if (privates.count > 0) {
                    ChannelsSectionModel *privatesSectionModel = [[ChannelsSectionModel alloc] initWithType:ChannelsSectionModelTypeMims];
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[privatesSectionModel]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), privates, privatesSectionModel);
                    
                    [privatesSectionModel release];
                }
                
                //
                
                reinterpret_cast<void (*)(id, SEL, id, BOOL, id)>(objc_msgSend)(dataSource, sel_registerName("applySnapshot:animatingDifferences:completion:"), snapshot, YES, ^{
                    completionaHandler(nil);
                });
                [snapshot release];
            });
        });
    });
}

- (void)itemModelAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^)(ChannelsItemModel * _Nullable))completionHandler {
    id dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        ChannelsItemModel * _Nullable itemModel = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(dataSource, sel_registerName("itemIdentifierForIndexPath:"), indexPath);
        completionHandler(itemModel);
    });
}

@end

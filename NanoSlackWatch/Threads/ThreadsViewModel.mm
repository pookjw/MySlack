//
//  ThreadsViewModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/24/24.
//

#import "ThreadsViewModel.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
@import SlackCore;

__attribute__((objc_direct_members))
@interface ThreadsViewModel ()
@property (retain, readonly, nonatomic) id dataSource;
@property (retain, nonatomic, readonly) dispatch_queue_t queue;
@end

@implementation ThreadsViewModel

- (instancetype)initWithDataSource:(id)dataSource {
    if (self = [super init]) {
        _dataSource = [dataSource retain];
        
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, QOS_MIN_RELATIVE_PRIORITY);
        _queue = dispatch_queue_create("ThreadsViewModel", attr);
    }
    
    return self;
}

- (void)dealloc {
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithChannelID:(NSString *)channelID completionHandler:(void (^)(NSError * _Nullable))completionaHandler {
    auto queue = self.queue;
    id dataSource = self.dataSource;
    
    dispatch_async(queue, ^{
        SlackCore::SlackAPIService::getSharedInstance().getConversationsHistoryDictionary(swift::String::init(channelID), ^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                completionaHandler(error);
                return;
            }
            
            dispatch_async(queue, ^{
                id snapshot = [objc_lookUpClass("NSDiffableDataSourceSnapshot") new];
                
                //
                
                NSArray *messages = dictionary[@"messages"];
                
                if (messages.count > 0) {
                    auto itemModels = [[NSMutableArray<ThreadsItemModel *> alloc] initWithCapacity:messages.count];
                    
                    for (NSDictionary *message in messages) {
                        ThreadsItemModel *itemModel = [[ThreadsItemModel alloc] initWithType:ThreadsItemModelTypeMessage];
                        itemModel.userInfo = @{
                            ThreadsItemModelMessageKey: message
                        };
                        [itemModels addObject:itemModel];
                        [itemModel release];
                    }
                    
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[@0]);
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), itemModels, @0);
                    
                    [itemModels release];
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

- (void)itemModelAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^)(ThreadsItemModel * _Nullable))completionHandler {
    id dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        ThreadsItemModel * _Nullable itemModel = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(dataSource, sel_registerName("itemIdentifierForIndexPath:"), indexPath);
        completionHandler(itemModel);
    });
}

@end

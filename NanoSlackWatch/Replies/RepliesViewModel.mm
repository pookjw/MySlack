//
//  RepliesViewModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "RepliesViewModel.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
@import SlackCore;

__attribute__((objc_direct_members))
@interface RepliesViewModel ()
@property (retain, readonly, nonatomic) id dataSource;
@property (retain, nonatomic, readonly) dispatch_queue_t queue;
@end

@implementation RepliesViewModel

- (instancetype)initWithDataSource:(id)dataSource {
    if (self = [super init]) {
        _dataSource = [dataSource retain];
        
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, QOS_MIN_RELATIVE_PRIORITY);
        _queue = dispatch_queue_create("RepliesViewModel", attr);
    }
    
    return self;
}

- (void)dealloc {
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithChannelID:(NSString *)channelID threadID:(NSString *)threadID completionHandler:(void (^)(NSError * _Nullable))completionaHandler {
    auto queue = self.queue;
    id dataSource = self.dataSource;
    
    dispatch_async(queue, ^{
        SlackCore::SlackAPIService::getSharedInstance().getConversationsRepliesDictionary(swift::String::init(channelID), swift::String::init(threadID), ^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                completionaHandler(error);
                return;
            }
            
            dispatch_async(queue, ^{
                id snapshot = [objc_lookUpClass("NSDiffableDataSourceSnapshot") new];
                
                NSArray *messages = dictionary[@"messages"];
                NSDictionary *originalMessage = messages[0];
                
                //
                
                RepliesSectionModel *originalMessageSectionModel = [[RepliesSectionModel alloc] initWithType:RepliesSectionModelTypeOriginalMessage];
                reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[originalMessageSectionModel]);
                
                RepliesItemModel *originalMessageItemModel = [[RepliesItemModel alloc] initWithType:RepliesItemModelTypeOriginalMessage];
                originalMessageItemModel.userInfo = @{RepliesItemModelMessageKey: originalMessage};
                reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), @[originalMessageItemModel], originalMessageSectionModel);
                
                [originalMessageSectionModel release];
                [originalMessageItemModel release];
                
                //
                
                NSUInteger replyCount = static_cast<NSNumber *>(originalMessage[@"reply_count"]).unsignedIntegerValue;
                if (replyCount > 0) {
                    RepliesSectionModel *repliesSectionModel = [[RepliesSectionModel alloc] initWithType:RepliesSectionModelTypeReplies];
                    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[repliesSectionModel]);
                    
                    auto replyItemModels = [[NSMutableArray<RepliesItemModel *> alloc] initWithCapacity:replyCount];
                    
                    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, replyCount)];
                    
                    [messages enumerateObjectsAtIndexes:indexes options:0 usingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        RepliesItemModel *replyItemModel = [[RepliesItemModel alloc] initWithType:RepliesItemModelTypeReply];
                        replyItemModel.userInfo = @{RepliesItemModelMessageKey: obj};
                        [replyItemModels addObject:replyItemModel];
                        [replyItemModel release];
                    }];
                    
                    reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), replyItemModels, repliesSectionModel);
                    
                    [repliesSectionModel release];
                    [replyItemModels release];
                }
                
                reinterpret_cast<void (*)(id, SEL, id, BOOL, id)>(objc_msgSend)(dataSource, sel_registerName("applySnapshot:animatingDifferences:completion:"), snapshot, YES, ^{
                    completionaHandler(nil);
                });
                [snapshot release];
            });
        });
    });
}

@end

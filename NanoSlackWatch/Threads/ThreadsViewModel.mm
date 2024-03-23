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
@property (copy, readonly, nonatomic) NSString *channelID;
@property (retain, readonly, nonatomic) id dataSource;
@property (retain, nonatomic, readonly) dispatch_queue_t queue;
@end

@implementation ThreadsViewModel

- (instancetype)initWithChannelID:(NSString *)channelID dataSource:(id)dataSource {
    if (self = [super init]) {
        _channelID = [channelID copy];
        _dataSource = [dataSource retain];
        
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, QOS_MIN_RELATIVE_PRIORITY);
        _queue = dispatch_queue_create("ThreadsViewModel", attr);
    }
    
    return self;
}

- (void)dealloc {
    [_channelID release];
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithCompletionHandler:(void (^)(NSError * _Nullable))completionaHandler {
    auto queue = self.queue;
    NSString *channelID = self.channelID;
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
                
                
                
                //
                
                reinterpret_cast<void (*)(id, SEL, id, BOOL, id)>(objc_msgSend)(dataSource, sel_registerName("applySnapshot:animatingDifferences:completion:"), snapshot, YES, ^{
                    completionaHandler(nil);
                });
                [snapshot release];
            });
        });
    });
}

@end

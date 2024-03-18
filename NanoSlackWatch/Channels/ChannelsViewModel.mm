//
//  ChannelsViewModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import "ChannelsViewModel.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

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

- (void)loadDataSourceWithCompletionHandler:(void (^)())completionaHandler {
    id dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        id snapshot = [objc_lookUpClass("NSDiffableDataSourceSnapshot") new];
        
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(snapshot, sel_registerName("appendSectionsWithIdentifiers:"), @[@0]);
        
        reinterpret_cast<void (*)(id, SEL, id, id)>(objc_msgSend)(snapshot, sel_registerName("appendItemsWithIdentifiers:intoSectionWithIdentifier:"), @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10], @0);
        
        reinterpret_cast<void (*)(id, SEL, id, BOOL, id)>(objc_msgSend)(dataSource, sel_registerName("applySnapshot:animatingDifferences:completion:"), snapshot, YES, completionaHandler);
        [snapshot release];
    });
}

@end

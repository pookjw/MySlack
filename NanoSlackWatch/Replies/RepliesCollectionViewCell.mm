//
//  RepliesCollectionViewCell.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "RepliesCollectionViewCell.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "NanoSlackWatch-Swift.h"

__attribute__((objc_direct_members))
@interface RepliesCollectionViewCell ()
@property (class, assign, readonly, nonatomic) void *context;
@property (retain, readonly, nonatomic) id hostingController;
@end

@implementation RepliesCollectionViewCell

+ (void *)context {
    static void *context = &context;
    return context;
}

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[RepliesCollectionViewCell dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_RepliesCollectionViewCell", 0);
        
        class_addIvar(_isa, "_hostingController", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    NanoSlackWatch::RepliesCollectionViewCellView::updateHostingController(self.hostingController, nil);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        id view = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self.hostingController, sel_registerName("view"));
        reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(view, sel_registerName("setAutoresizingMask:"), (1 << 1) | (1 << 4));
        reinterpret_cast<void (*)(id, SEL, CGRect)>(objc_msgSend)(view, sel_registerName("setFrame:"), self.bounds);
        [self addSubview:view];
    }
    
    return self;
}

- (void)dealloc {
    id _hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&_hostingController));
    [_hostingController removeObserver:self forKeyPath:@"preferredContentSize" context:RepliesCollectionViewCell.context];
    [_hostingController release];
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == RepliesCollectionViewCell.context) {
        [self invalidateIntrinsicContentSize];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (id)preferredLayoutAttributesFittingAttributes:(id)layoutAttributes {
    id result = [layoutAttributes copy]; // PUICListCollectionViewLayoutAttributes *
    
    CGSize oldSize = reinterpret_cast<CGSize (*)(id, SEL)>(objc_msgSend)(result, sel_registerName("size"));
    
    id hostingController = self.hostingController;
    id hostingView = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(hostingController, sel_registerName("view"));
    
    CGSize newSize = reinterpret_cast<CGSize (*)(id, SEL, CGSize, float, float)>(objc_msgSend)(hostingView, sel_registerName("systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:"), CGSizeMake(oldSize.width, CGFLOAT_MAX), 1000.f, 50.f);
    
    reinterpret_cast<void (*)(id, SEL, CGSize)>(objc_msgSend)(result, sel_registerName("setSize:"), newSize);
    
    return [result autorelease];
}

- (id)hostingController __attribute__((objc_direct)) {
    id hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&hostingController));
    
    if (hostingController) return hostingController;
    
    hostingController = NanoSlackWatch::ThreadsCollectionViewCellView::makeHostingController();
    
    [hostingController addObserver:self forKeyPath:@"preferredContentSize" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:RepliesCollectionViewCell.context];
    
    object_setInstanceVariable(self, "_hostingController", [hostingController retain]);
    
    return hostingController;
}

- (void)updateItemModel:(RepliesItemModel *)itemModel {
    NanoSlackWatch::RepliesCollectionViewCellView::updateHostingController(self.hostingController, itemModel);
}

@end

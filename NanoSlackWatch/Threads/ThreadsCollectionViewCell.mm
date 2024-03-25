//
//  ThreadsCollectionViewCell.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/25/24.
//

#import "ThreadsCollectionViewCell.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "NanoSlackWatch-Swift.h"

__attribute__((objc_direct_members))
@interface ThreadsCollectionViewCell ()
@property (retain, readonly, nonatomic) id hostingController;
@end

@implementation ThreadsCollectionViewCell

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ThreadsCollectionViewCell dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ThreadsCollectionViewCell", 0);
        
        class_addIvar(_isa, "_hostingController", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
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

- (void)prepareForReuse {
    [super prepareForReuse];
    NanoSlackWatch::ThreadsCollectionViewCellView::updateHostingController(self.hostingController, nil);
}

- (void)dealloc {
    id _hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&_hostingController));
    [_hostingController release];
    
    [super dealloc];
}

- (id)preferredLayoutAttributesFittingAttributes:(id)layoutAttributes {
    id result = [layoutAttributes copy]; // PUICListCollectionViewLayoutAttributes *
    
    CGSize oldSize = reinterpret_cast<CGSize (*)(id, SEL)>(objc_msgSend)(result, sel_registerName("size"));
    
    id hostingController = self.hostingController;
    id hostingView = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(hostingController, sel_registerName("view"));
    
    CGSize newSize = reinterpret_cast<CGSize (*)(id, SEL, CGSize, float, float)>(objc_msgSend)(hostingView, sel_registerName("systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:"), CGSizeMake(oldSize.width, CGFLOAT_MAX), 1000.f, 50.f);
    
    reinterpret_cast<void (*)(id, SEL, CGSize)>(objc_msgSend)(result, sel_registerName("setSize:"), newSize);
    
    NSLog(@"%@ %@", NSStringFromCGSize(oldSize), NSStringFromCGSize(newSize));
    
    return [result autorelease];
}

- (id)hostingController __attribute__((objc_direct)) {
    id hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&hostingController));
    
    if (hostingController) return hostingController;
    
    hostingController = NanoSlackWatch::ThreadsCollectionViewCellView::makeHostingController();
    
    object_setInstanceVariable(self, "_hostingController", [hostingController retain]);
    
    return hostingController;
}

- (void)updateItemModel:(ThreadsItemModel *)itemModel {
    NanoSlackWatch::ThreadsCollectionViewCellView::updateHostingController(self.hostingController, itemModel);
}

@end

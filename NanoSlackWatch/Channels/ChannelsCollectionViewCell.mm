//
//  ChannelsCollectionViewCell.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "ChannelsCollectionViewCell.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "NanoSlackWatch-Swift.h"

@interface ChannelsCollectionViewCell ()
@property (retain, readonly, nonatomic) id hostingController;
@end

@implementation ChannelsCollectionViewCell

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ChannelsCollectionViewCell dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ChannelsCollectionViewCell", 0);
        
        class_addIvar(_isa, "_hostingController", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP hostingController = class_getMethodImplementation(implIsa, @selector(hostingController));
    class_addMethod(isa, @selector(hostingController), hostingController, NULL);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        id view = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self.hostingController, sel_registerName("view"));
        reinterpret_cast<void (*)(id, SEL, CGRect)>(objc_msgSend)(view, sel_registerName("setFrame:"), self.bounds);
        [self addSubview:view];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    NanoSlackWatch::ChannelsCollectionViewCellView::updateHostingController(self.hostingController, nil);
}

- (void)dealloc {
    id _hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&_hostingController));
    [_hostingController release];
    
    [super dealloc];
}

- (id)hostingController {
    id hostingController;
    object_getInstanceVariable(self, "_hostingController", reinterpret_cast<void **>(&hostingController));
    
    if (hostingController) return hostingController;
    
    hostingController = NanoSlackWatch::ChannelsCollectionViewCellView::makeHostingController();
    
    object_setInstanceVariable(self, "_hostingController", [hostingController retain]);
    
    return hostingController;
}

- (void)updateItemModel:(ChannelsItemModel *)itemModel {
    NanoSlackWatch::ChannelsCollectionViewCellView::updateHostingController(self.hostingController, itemModel);
}

@end

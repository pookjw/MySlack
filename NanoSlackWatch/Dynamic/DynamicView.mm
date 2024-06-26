//
//  DynamicView.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "DynamicView.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

OBJC_EXPORT id objc_msgSendSuper2(void);

@implementation DynamicView

+ (Class)dynamicIsa {
    return objc_lookUpClass("UIView");
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    IMP initWithFrame = class_getMethodImplementation(implIsa, @selector(initWithFrame:));
    assert(class_addMethod(isa, @selector(initWithFrame:), initWithFrame, NULL));
    
    IMP dealloc = class_getMethodImplementation(implIsa, @selector(dealloc));
    assert(class_addMethod(isa, @selector(dealloc), dealloc, NULL));
    
    IMP backgroundColor = class_getMethodImplementation(implIsa, @selector(backgroundColor));
    assert(class_addMethod(isa, @selector(backgroundColor), backgroundColor, NULL));
    
    IMP setBackgroundColor = class_getMethodImplementation(implIsa, @selector(setBackgroundColor:));
    assert(class_addMethod(isa, @selector(setBackgroundColor:), setBackgroundColor, NULL));
    
    IMP description = class_getMethodImplementation(implIsa, @selector(description));
    assert(class_addMethod(isa, @selector(description), description, NULL));
    
    IMP frame = class_getMethodImplementation(implIsa, @selector(frame));
    assert(class_addMethod(isa, @selector(frame), frame, NULL));
    
    IMP setFrame = class_getMethodImplementation(implIsa, @selector(setFrame:));
    assert(class_addMethod(isa, @selector(setFrame:), setFrame, NULL));
    
    IMP bounds = class_getMethodImplementation(implIsa, @selector(bounds));
    assert(class_addMethod(isa, @selector(bounds), bounds, NULL));
    
    IMP setBounds = class_getMethodImplementation(implIsa, @selector(setBounds:));
    assert(class_addMethod(isa, @selector(setBounds:), setBounds, NULL));
    
    IMP translatesAutoresizingMaskIntoConstraints = class_getMethodImplementation(implIsa, @selector(translatesAutoresizingMaskIntoConstraints));
    assert(class_addMethod(isa, @selector(translatesAutoresizingMaskIntoConstraints), translatesAutoresizingMaskIntoConstraints, NULL));
    
    IMP setTranslatesAutoresizingMaskIntoConstraints = class_getMethodImplementation(implIsa, @selector(setTranslatesAutoresizingMaskIntoConstraints:));
    assert(class_addMethod(isa, @selector(setTranslatesAutoresizingMaskIntoConstraints:), setTranslatesAutoresizingMaskIntoConstraints, NULL));
    
    IMP autoresizingMask = class_getMethodImplementation(implIsa, @selector(autoresizingMask));
    assert(class_addMethod(isa, @selector(autoresizingMask), autoresizingMask, NULL));
    
    IMP setAutoresizingMask = class_getMethodImplementation(implIsa, @selector(setAutoresizingMask:));
    assert(class_addMethod(isa, @selector(setAutoresizingMask:), setAutoresizingMask, NULL));
    
    IMP addSubview = class_getMethodImplementation(implIsa, @selector(addSubview:));
    assert(class_addMethod(isa, @selector(addSubview:), addSubview, NULL));
    
    IMP observeValueForKeyPath_ofObject_change_context = class_getMethodImplementation(implIsa, @selector(observeValueForKeyPath:ofObject:change:context:));
    assert(class_addMethod(isa, @selector(observeValueForKeyPath:ofObject:change:context:), observeValueForKeyPath_ofObject_change_context, NULL));
    
    IMP layoutIfNeeded = class_getMethodImplementation(implIsa, @selector(layoutIfNeeded));
    assert(class_addMethod(isa, @selector(layoutIfNeeded), layoutIfNeeded, NULL));
    
    IMP invalidateIntrinsicContentSize = class_getMethodImplementation(implIsa, @selector(invalidateIntrinsicContentSize));
    assert(class_addMethod(isa, @selector(invalidateIntrinsicContentSize), invalidateIntrinsicContentSize, NULL));
    
    IMP setNeedsLayout = class_getMethodImplementation(implIsa, @selector(setNeedsLayout));
    assert(class_addMethod(isa, @selector(setNeedsLayout), setNeedsLayout, NULL));
    
    IMP _wheelChangedWithEvent = class_getMethodImplementation(implIsa, @selector(_wheelChangedWithEvent:));
    assert(class_addMethod(isa, @selector(_wheelChangedWithEvent:), _wheelChangedWithEvent, NULL));
}

- (instancetype)initWithFrame:(CGRect)frame {
    objc_super superInfo = { self, [self class] };
    self = reinterpret_cast<id (*)(objc_super *, SEL, CGRect)>(objc_msgSendSuper2)(&superInfo, _cmd, frame);
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}
#pragma clang diagnostic pop

- (UIColor *)backgroundColor {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<id (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, id)>(objc_msgSendSuper2)(&superInfo, _cmd, backgroundColor);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s: %p; frame = %@>", class_getName([self class]), reinterpret_cast<void *>(self), NSStringFromCGRect(self.frame)];
}

- (CGRect)frame {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<CGRect (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setFrame:(CGRect)frame {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, CGRect)>(objc_msgSendSuper2)(&superInfo, _cmd, frame);
}

- (CGRect)bounds {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<CGRect (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setBounds:(CGRect)bounds {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, CGRect)>(objc_msgSendSuper2)(&superInfo, _cmd, bounds);
}

- (BOOL)translatesAutoresizingMaskIntoConstraints {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<BOOL (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)translatesAutoresizingMaskIntoConstraints {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, BOOL)>(objc_msgSendSuper2)(&superInfo, _cmd, translatesAutoresizingMaskIntoConstraints);
}

- (NSUInteger)autoresizingMask {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<NSUInteger (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setAutoresizingMask:(NSUInteger)autoresizingMask {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, NSUInteger)>(objc_msgSendSuper2)(&superInfo, _cmd, autoresizingMask);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, id, id, id, void *)>(objc_msgSendSuper2)(&superInfo, _cmd, keyPath, object, change, context);
}

- (void)addSubview:(id)subview {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, id)>(objc_msgSendSuper2)(&superInfo, _cmd, subview);
}

- (void)layoutIfNeeded {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)invalidateIntrinsicContentSize {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setNeedsLayout {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)_wheelChangedWithEvent:(id)event {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

@end

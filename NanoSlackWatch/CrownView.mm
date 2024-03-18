//
//  CrownView.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "CrownView.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

@interface CrownView ()
@property (retain, readonly, nonatomic) id label;
@property (retain, readonly, nonatomic) id crownInputSequencer;
@end

@implementation CrownView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [CrownView.dynamicIsa allocWithZone:zone];
}

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_CrownView", 0);
        
        class_addProtocol(_isa, NSProtocolFromString(@"PUICCrownInputSequencerDelegate"));
        class_addProtocol(_isa, NSProtocolFromString(@"PUICCrownInputSequencerDetentsDataSource"));
        class_addIvar(_isa, "_label", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_crownInputSequencer", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP label = class_getMethodImplementation(implIsa, @selector(label));
    class_addMethod(isa, @selector(label), label, NULL);
    
    IMP crownInputSequencer = class_getMethodImplementation(implIsa, @selector(crownInputSequencer));
    class_addMethod(isa, @selector(crownInputSequencer), crownInputSequencer, NULL);
    
    IMP crownInputSequencer_shouldRubberBandAtBoundary = class_getMethodImplementation(implIsa, @selector(crownInputSequencer:shouldRubberBandAtBoundary:));
    class_addMethod(isa, @selector(crownInputSequencer:shouldRubberBandAtBoundary:), crownInputSequencer_shouldRubberBandAtBoundary, NULL);
    
    IMP crownInputSequencerOffsetDidChange = class_getMethodImplementation(implIsa, @selector(crownInputSequencerOffsetDidChange:));
    class_addMethod(isa, @selector(crownInputSequencerOffsetDidChange:), crownInputSequencerOffsetDidChange, NULL);
    
    IMP isFirstResponderForSequencer = class_getMethodImplementation(implIsa, @selector(isFirstResponderForSequencer:));
    class_addMethod(isa, @selector(isFirstResponderForSequencer:), isFirstResponderForSequencer, NULL);
    
    IMP proposedRestingOffsetForContentOffset = class_getMethodImplementation(implIsa, @selector(proposedRestingOffsetForContentOffset:));
    class_addMethod(isa, @selector(proposedRestingOffsetForContentOffset:), proposedRestingOffsetForContentOffset, NULL);
    
    IMP canBecomeFirstResponder = class_getMethodImplementation(implIsa, @selector(canBecomeFirstResponder));
    class_addMethod(isa, @selector(canBecomeFirstResponder), canBecomeFirstResponder, NULL);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self crownInputSequencer];
        
        id label = self.label;
        [self addSubview:label];
        
        reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(label, sel_registerName("setTranslatesAutoresizingMaskIntoConstraints:"), NO);
        
        id labelTopAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(label, sel_registerName("topAnchor"));
        id labelBottomAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(label, sel_registerName("bottomAnchor"));
        id labelLeadingAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(label, sel_registerName("leadingAnchor"));
        id labelTrailingAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(label, sel_registerName("trailingAnchor"));
        id selfTopAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self, sel_registerName("topAnchor"));
        id selfBottomAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self, sel_registerName("bottomAnchor"));
        id selfLeadingAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self, sel_registerName("leadingAnchor"));
        id selfTrailingAnchor = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self, sel_registerName("trailingAnchor"));
        
        reinterpret_cast<void (*)(Class, SEL, id)>(objc_msgSend)(objc_lookUpClass("NSLayoutConstraint"), sel_registerName("activateConstraints:"), @[
            reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(labelTopAnchor, sel_registerName("constraintEqualToAnchor:"), selfTopAnchor),
            reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(labelBottomAnchor, sel_registerName("constraintEqualToAnchor:"), selfBottomAnchor),
            reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(labelLeadingAnchor, sel_registerName("constraintEqualToAnchor:"), selfLeadingAnchor),
            reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)(labelTrailingAnchor, sel_registerName("constraintEqualToAnchor:"), selfTrailingAnchor),
        ]);
        
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(label, sel_registerName("setText:"), @"Test");
    }
    
    return self;
}

- (void)dealloc {
    id _label;
    object_getInstanceVariable(self, "_label", reinterpret_cast<void **>(&_label));
    [_label release];
    
    id _crownInputSequencer;
    object_getInstanceVariable(self, "_crownInputSequencer", reinterpret_cast<void **>(&_crownInputSequencer));
    [_crownInputSequencer release];
    
    [super dealloc];
}

- (id)label {
    id label;
    object_getInstanceVariable(self, "_label", reinterpret_cast<void **>(&label));
    
    if (label) return label;
    
    label = reinterpret_cast<id (*)(id, SEL, CGRect)>(objc_msgSend)([objc_lookUpClass("UILabel") alloc], sel_registerName("initWithFrame:"), self.bounds);
    
    object_setInstanceVariable(self, "_label", [label retain]);
    return [label autorelease];
}

- (id)crownInputSequencer {
    id crownInputSequencer;
    object_getInstanceVariable(self, "_crownInputSequencer", reinterpret_cast<void **>(&crownInputSequencer));
    
    if (crownInputSequencer) return crownInputSequencer;
    
    crownInputSequencer = [objc_lookUpClass("PUICCrownInputSequencer") new];
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(crownInputSequencer, sel_registerName("setView:"), self);
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(crownInputSequencer, sel_registerName("setContinuous:"), YES);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(crownInputSequencer, sel_registerName("setMetricsDelegate:"), self);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(crownInputSequencer, sel_registerName("setDelegate:"), self);
    
    object_setInstanceVariable(self, "_crownInputSequencer", [crownInputSequencer retain]);
    
    NSLog(@"%@", crownInputSequencer);
    return [crownInputSequencer autorelease];
}

- (_Bool) crownInputSequencer:(id)arg1 shouldRubberBandAtBoundary:(long)arg2 {
    return YES;
}

- (void)crownInputSequencerOffsetDidChange:(id)sender {
    
}

- (_Bool) isFirstResponderForSequencer:(id)arg1 {
    return YES;
}

- (double) proposedRestingOffsetForContentOffset:(double)arg1 {
    return 0.f;
}

@end

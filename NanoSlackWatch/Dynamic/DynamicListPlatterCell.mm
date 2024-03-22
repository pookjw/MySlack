//
//  DynamicListPlatterCell.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "DynamicListPlatterCell.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

OBJC_EXPORT id objc_msgSendSuper2(void);

@interface DynamicListPlatterCell ()
@end

@implementation DynamicListPlatterCell

+ (Class)dynamicIsa {
    return objc_lookUpClass("PUICListPlatterCell");
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP prepareForReuse = class_getMethodImplementation(implIsa, @selector(prepareForReuse));
    assert(class_addMethod(isa, @selector(prepareForReuse), prepareForReuse, NULL));
    
    IMP isSelected = class_getMethodImplementation(implIsa, @selector(isSelected));
    assert(class_addMethod(isa, @selector(isSelected), isSelected, NULL));
    
    IMP setSelected = class_getMethodImplementation(implIsa, @selector(setSelected:));
    assert(class_addMethod(isa, @selector(setSelected:), setSelected, NULL));
    
    IMP isHighlighted = class_getMethodImplementation(implIsa, @selector(isHighlighted));
    assert(class_addMethod(isa, @selector(isHighlighted), isHighlighted, NULL));
    
    IMP setHighlighted = class_getMethodImplementation(implIsa, @selector(setHighlighted:));
    assert(class_addMethod(isa, @selector(setHighlighted:), setHighlighted, NULL));
}

- (void)prepareForReuse {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (BOOL)isSelected {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<BOOL (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setSelected:(BOOL)selected {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, BOOL)>(objc_msgSendSuper2)(&superInfo, _cmd, selected);
}

- (BOOL)isHighlighted {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<BOOL (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setHighlighted:(BOOL)highlighted {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, BOOL)>(objc_msgSendSuper2)(&superInfo, _cmd, highlighted);
}

@end

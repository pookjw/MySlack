//
//  ChannelsCollectionViewCell.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import "ChannelsCollectionViewCell.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface ChannelsCollectionViewCell ()
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
        
        isa = _isa;
    }
    
    return isa;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIColor *cyanColor = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(UIColor.class, sel_registerName("systemPinkColor"));
//        self.backgroundColor = cyanColor;
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end

//
//  RepliesViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "RepliesViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface RepliesViewController ()
@end

@implementation RepliesViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[RepliesViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_RepliesViewController", 0);
        
//        class_addIvar(_isa, "_channelID", sizeof(id), sizeof(id), @encode(id));
//        class_addIvar(_isa, "_viewModel", sizeof(id), sizeof(id), @encode(id));
//        class_addIvar(_isa, "_cellRegistration", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
}

- (instancetype)initWithChannelID:(NSString *)channelID threadID:(NSString *)threadID {
    if (self = [super initWithNibName:nil bundle:nil]) {
        
    }
    
    return self;
}

@end

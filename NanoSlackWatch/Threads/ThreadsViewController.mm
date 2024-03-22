//
//  ThreadsViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/22/24.
//

#import "ThreadsViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation ThreadsViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ThreadsViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ThreadsViewController", 0);
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
}

@end

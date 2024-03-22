//
//  ProfilesViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/22/24.
//

#import "ProfilesViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface ProfilesViewController ()
@end

@implementation ProfilesViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ProfilesViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ProfilesViewController", 0);
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP dismissBarButtonItemDidTrigger = class_getMethodImplementation(implIsa, @selector(dismissBarButtonItemDidTrigger:));
    assert(class_addMethod(isa, @selector(dismissBarButtonItemDidTrigger:), dismissBarButtonItemDidTrigger, NULL));
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        id navigationItem = self.navigationItem;
        id dismissBarButtonItem = reinterpret_cast<id (*)(id, SEL, id, NSInteger, id, SEL)>(objc_msgSend)([objc_lookUpClass("UIBarButtonItem") alloc], sel_registerName("initWithImage:style:target:action:"), [UIImage systemImageNamed:@"xmark"], 0, self, @selector(dismissBarButtonItemDidTrigger:));
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setLeftBarButtonItems:"), @[dismissBarButtonItem]);
        [dismissBarButtonItem release];
    }
    
    return self;
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    
}

- (void)dismissBarButtonItemDidTrigger:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

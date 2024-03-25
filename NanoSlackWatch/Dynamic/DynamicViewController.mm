//
//  DynamicViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import "DynamicViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

OBJC_EXPORT id objc_msgSendSuper2(void);

__attribute__((objc_direct_members))
@interface DynamicViewController ()
@end

@implementation DynamicViewController

+ (Class)dynamicIsa {
    return objc_lookUpClass("UIViewController");
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    IMP initWithNibName_bundle = class_getMethodImplementation(implIsa, @selector(initWithNibName:bundle:));
    assert(class_addMethod(isa, @selector(initWithNibName:bundle:), initWithNibName_bundle, NULL));
    
    IMP dealloc = class_getMethodImplementation(implIsa, @selector(dealloc));
    assert(class_addMethod(isa, @selector(dealloc), dealloc, NULL));
    
    IMP puic_statusBarPlacement = class_getMethodImplementation(implIsa, @selector(puic_statusBarPlacement));
    assert(class_addMethod(isa, @selector(puic_statusBarPlacement), puic_statusBarPlacement, NULL));
    
    IMP setView = class_getMethodImplementation(implIsa, @selector(setView:));
    assert(class_addMethod(isa, @selector(setView:), setView, NULL));
    
    IMP view = class_getMethodImplementation(implIsa, @selector(view));
    assert(class_addMethod(isa, @selector(view), view, NULL));
    
    IMP navigationItem = class_getMethodImplementation(implIsa, @selector(navigationItem));
    assert(class_addMethod(isa, @selector(navigationItem), navigationItem, NULL));
    
    IMP navigationController = class_getMethodImplementation(implIsa, @selector(navigationController));
    assert(class_addMethod(isa, @selector(navigationController), navigationController, NULL));
    
    IMP loadView = class_getMethodImplementation(implIsa, @selector(loadView));
    assert(class_addMethod(isa, @selector(loadView), loadView, NULL));
    
    IMP viewDidLoad = class_getMethodImplementation(implIsa, @selector(viewDidLoad));
    assert(class_addMethod(isa, @selector(viewDidLoad), viewDidLoad, NULL));
    
    IMP viewIsAppearing = class_getMethodImplementation(implIsa, @selector(viewIsAppearing:));
    assert(class_addMethod(isa, @selector(viewIsAppearing:), viewIsAppearing, NULL));
    
    IMP presentViewController_animated_completion = class_getMethodImplementation(implIsa, @selector(presentViewController:animated:completion:));
    assert(class_addMethod(isa, @selector(presentViewController:animated:completion:), presentViewController_animated_completion, NULL));
    
    IMP dismissViewControllerAnimated_completion = class_getMethodImplementation(implIsa, @selector(dismissViewControllerAnimated:completion:));
    assert(class_addMethod(isa, @selector(dismissViewControllerAnimated:completion:), dismissViewControllerAnimated_completion, NULL));
    
    IMP presentationController = class_getMethodImplementation(implIsa, @selector(presentationController));
    assert(class_addMethod(isa, @selector(presentationController), presentationController, NULL));
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    objc_super superInfo = { self, [self class] };
    self = reinterpret_cast<id (*)(objc_super *, SEL, id, id)>(objc_msgSendSuper2)(&superInfo, _cmd, nibNameOrNil, nibBundleOrNil);
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}
#pragma clang diagnostic pop

- (NSInteger)puic_statusBarPlacement {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<NSInteger (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)setView:(id)view {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, id)>(objc_msgSendSuper2)(&superInfo, _cmd, view);
}

- (id)view {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<id (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (id)navigationItem {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<id (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (id)presentationController {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<id (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (id)navigationController {
    objc_super superInfo = { self, [self class] };
    return reinterpret_cast<id (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)loadView {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)viewDidLoad {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL)>(objc_msgSendSuper2)(&superInfo, _cmd);
}

- (void)viewIsAppearing:(BOOL)animated {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, BOOL)>(objc_msgSendSuper2)(&superInfo, _cmd, animated);
}

- (void)presentViewController:(id)viewControllerToPresent animated:(BOOL)flag completion:(void (^)())completion {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, id, BOOL, id)>(objc_msgSendSuper2)(&superInfo, _cmd, viewControllerToPresent, flag, completion);
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)())completion {
    objc_super superInfo = { self, [self class] };
    reinterpret_cast<void (*)(objc_super *, SEL, BOOL, id)>(objc_msgSendSuper2)(&superInfo, _cmd, flag, completion);
}

- (void)nsw_setNeedsUpdateOfStatusBarPlacement {
    id window = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self.view, sel_registerName("window"));
    if (window == nil) return;
    
    id windowScene = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(window, sel_registerName("windowScene"));
    if (windowScene == nil) return;
    
    // PUICStatusBarManager
    id statusBarManager = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(windowScene, NSSelectorFromString(@"statusBarManager"));
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(statusBarManager, NSSelectorFromString(@"_updateStatusBarAppearanceSceneSettingsWithAnimationParameters:"), nil);
}

@end

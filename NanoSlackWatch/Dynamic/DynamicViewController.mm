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
    class_addMethod(isa, @selector(initWithNibName:bundle:), initWithNibName_bundle, NULL);
    
    IMP puic_statusBarPlacement = class_getMethodImplementation(implIsa, @selector(puic_statusBarPlacement));
    class_addMethod(isa, @selector(puic_statusBarPlacement), puic_statusBarPlacement, NULL);
    
    IMP setView = class_getMethodImplementation(implIsa, @selector(setView:));
    class_addMethod(isa, @selector(setView:), setView, NULL);
    
    IMP view = class_getMethodImplementation(implIsa, @selector(view));
    class_addMethod(isa, @selector(view), view, NULL);
    
    IMP loadView = class_getMethodImplementation(implIsa, @selector(loadView));
    class_addMethod(isa, @selector(loadView), loadView, NULL);
    
    IMP viewDidLoad = class_getMethodImplementation(implIsa, @selector(viewDidLoad));
    class_addMethod(isa, @selector(viewDidLoad), viewDidLoad, NULL);
    
    IMP viewIsAppearing = class_getMethodImplementation(implIsa, @selector(viewIsAppearing:));
    class_addMethod(isa, @selector(viewIsAppearing:), viewIsAppearing, NULL);
    
    IMP nsw_setNeedsUpdateOfStatusBarPlacement = class_getMethodImplementation(implIsa, @selector(nsw_setNeedsUpdateOfStatusBarPlacement));
    class_addMethod(isa, @selector(nsw_setNeedsUpdateOfStatusBarPlacement), nsw_setNeedsUpdateOfStatusBarPlacement, NULL);
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    objc_super superInfo = { self, [self class] };
    self = reinterpret_cast<id (*)(objc_super *, SEL, id, id)>(objc_msgSendSuper2)(&superInfo, _cmd, nibNameOrNil, nibBundleOrNil);
    return self;
}

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

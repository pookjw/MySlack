//
//  SceneDelegate.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/15/24.
//

#import "SceneDelegate.hpp"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ChannelsViewController.hpp"
#import "UIColor+Private.h"

OBJC_EXPORT id _Nullable objc_msgSend_noarg(id _Nullable self, SEL _Nonnull _cmd);

@interface SceneDelegate ()
@property (retain, nonatomic) id window; // UIWindow *
@end

@implementation SceneDelegate

+ (void)load {
    class_addProtocol(self, NSProtocolFromString(@"UISceneDelegate"));
}

//+ (BOOL)conformsToProtocol:(Protocol *)protocol {
//    if (strcmp(protocol_getName(protocol), "UISceneDelegate") != 0) {
//        return YES;
//    }
//    
//    return [super conformsToProtocol:protocol];
//}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

// - (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
- (void)scene:(id)scene willConnectToSession:(id)session options:(id)connectionOptions {
    // UIWindow *
    id window = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)([objc_lookUpClass("UIWindow") alloc], sel_registerName("initWithWindowScene:"), scene);
    
    id channelsViewController = [ChannelsViewController new];
    id navigationController = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)([objc_lookUpClass("PUICNavigationController") alloc], sel_registerName("initWithRootViewController:"), channelsViewController);
    [channelsViewController release];
    
    id navigationBar = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(navigationController, sel_registerName("navigationBar"));
    
    id standardAppearance = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(navigationBar, sel_registerName("standardAppearance"));
    
    NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(standardAppearance, sel_registerName("titleTextAttributes")) mutableCopy];
    titleTextAttributes[NSForegroundColorAttributeName] = UIColor.systemOrangeColor;
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(standardAppearance, sel_registerName("setTitleTextAttributes:"), titleTextAttributes);
    [titleTextAttributes release];
    
    NSMutableDictionary<NSAttributedStringKey, id> *largeTitleTextAttributes = [reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(standardAppearance, sel_registerName("largeTitleTextAttributes")) mutableCopy];
    largeTitleTextAttributes[NSForegroundColorAttributeName] = UIColor.systemGreenColor;
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(standardAppearance, sel_registerName("setLargeTitleTextAttributes:"), largeTitleTextAttributes);
    [largeTitleTextAttributes release];
    
    id backButtonAppearance = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(standardAppearance, sel_registerName("backButtonAppearance"));
    id backButtonNormal = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(backButtonAppearance, sel_registerName("normal"));
    NSMutableDictionary<NSAttributedStringKey, id> *backButtonTitleTextAttributes = [reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(backButtonNormal, sel_registerName("titleTextAttributes")) mutableCopy];
    backButtonTitleTextAttributes[NSForegroundColorAttributeName] = UIColor.systemPinkColor;
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(backButtonNormal, sel_registerName("setTitleTextAttributes:"), backButtonTitleTextAttributes);
    [backButtonTitleTextAttributes release];
    
    id doneButtonAppearance = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(standardAppearance, sel_registerName("buttonAppearance"));
    id doneButtonNormal = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(doneButtonAppearance, sel_registerName("normal"));
    NSMutableDictionary<NSAttributedStringKey, id> *doneButtonTitleTextAttributes = [reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(doneButtonNormal, sel_registerName("titleTextAttributes")) mutableCopy];
    doneButtonTitleTextAttributes[NSForegroundColorAttributeName] = UIColor.systemCyanColor;
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(doneButtonNormal, sel_registerName("setTitleTextAttributes:"), doneButtonTitleTextAttributes);
    [doneButtonTitleTextAttributes release];
    
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationBar, sel_registerName("setStandardAppearance:"), standardAppearance);
    
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(navigationBar, sel_registerName("setPrefersLargeTitles:"), YES);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(window, sel_registerName("setRootViewController:"), navigationController);
    [navigationController release];
    
    reinterpret_cast<void (*)(id, SEL)>(objc_msgSend_noarg)(window, sel_registerName("makeKeyAndVisible"));
    self.window = window;
    [window release];
}

@end

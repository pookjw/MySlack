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
    
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(window, sel_registerName("setRootViewController:"), navigationController);
    [navigationController release];
    
    reinterpret_cast<void (*)(id, SEL)>(objc_msgSend_noarg)(window, sel_registerName("makeKeyAndVisible"));
    self.window = window;
    [window release];
}

@end

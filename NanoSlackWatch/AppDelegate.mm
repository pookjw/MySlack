//
//  AppDelegate.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/14/24.
//

#import "AppDelegate.hpp"
#import "SceneDelegate.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

OBJC_EXPORT id _Nullable objc_msgSend_noarg(id _Nullable self, SEL _Nonnull _cmd);

@interface AppDelegate ()
@property (retain, nonatomic) id window; // UIWindow *
@property BOOL hasReceivedNonClockKitEvent;
@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions
- (BOOL)application:(id)application didFinishLaunchingWithOptions:(NSDictionary<NSString *, id> *)launchOptions {
    NSURL *scCacheURL = [[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject URLByAppendingPathComponent:@"Saved Application State" isDirectory:YES];
    [NSFileManager.defaultManager removeItemAtURL:scCacheURL error:NULL];
    
    return YES;
}

- (void)didReceiveNonClockKitEvent {
}

- (id)extendLaunchTest {
    return nil;
}

// - (void)applicationWillEnterForeground:(UIApplication *)application
- (void)applicationWillEnterForeground:(id)application {
}

// - (void)applicationDidBecomeActive:(UIApplication *)application
- (void)applicationDidBecomeActive:(id)application {
}

// - (void)applicationWillTerminate:(UIApplication *)application
- (void)applicationWillTerminate:(id)application {
    
}

// - (void)applicationWillSuspend:(UIApplication *)application
- (void)applicationWillSuspend:(id)application {
    
}

// - (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options
- (id)application:(id)application configurationForConnectingSceneSession:(id)connectingSceneSession options:(id)options {
    // UISceneConfiguration *
    id oldConfiguration = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend_noarg)(connectingSceneSession, sel_registerName("configuration"));
    id newConfiguration = [oldConfiguration copy];
    
    reinterpret_cast<void (*)(id, SEL, Class)>(objc_msgSend)(newConfiguration, sel_registerName("setDelegateClass:"), SceneDelegate.class);
    
    return [newConfiguration autorelease];
}

@end

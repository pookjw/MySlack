//
//  main.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/14/24.
//

#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import "AppDelegate.hpp"
#import "NSObject+Foundation_IvarDescription.h"

UIKIT_EXTERN int UIApplicationMain(int argc, char * _Nullable argv[_Nonnull], NSString * _Nullable principalClassName, NSString * _Nullable delegateClassName);
UIKIT_EXTERN NSURL *_restorationPath(NSString *);

int main(int argc, char * argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    // TODO: WatchKit tbd
    void *watchKit = dlopen("/System/Library/Frameworks/WatchKit.framework/WatchKit", RTLD_NOW);
    assert(watchKit);
    
    // PUICListCollectionViewLayoutDelegate PUICListCollectionViewDelegate
    NSLog(@"%@", [NSObject _fd__protocolDescriptionForProtocol:NSProtocolFromString(@"PUICListCollectionViewLayoutDelegate")]);
//    NSLog(@"%@", [NSObject _fd__protocolDescriptionForProtocol:NSProtocolFromString(@"PUICCrownInputSequencerDetentsDataSource")]);
    
    int result = UIApplicationMain(argc, argv, @"SPApplication", NSStringFromClass(AppDelegate.class));
    [pool release];
    return result;
}

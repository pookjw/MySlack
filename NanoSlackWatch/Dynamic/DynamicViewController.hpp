//
//  DynamicViewController.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicViewController : NSObject
@property (class, readonly, nonatomic) Class dynamicIsa;
@property (readonly, nonatomic) NSInteger puic_statusBarPlacement;
@property (retain, nonatomic) id view;
@property (readonly, nonatomic) id navigationItem;
@property (readonly, nonatomic) id _Nullable presentationController;
@property (retain, readonly, nonatomic) id _Nullable navigationController;
- (instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil;
+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewIsAppearing:(BOOL)animated;
- (void)presentViewController:(id)viewControllerToPresent animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ _Nullable)(void))completion;
- (void)nsw_setNeedsUpdateOfStatusBarPlacement __attribute__((objc_direct));
@end

NS_ASSUME_NONNULL_END

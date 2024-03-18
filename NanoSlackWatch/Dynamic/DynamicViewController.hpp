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
@property(retain, nonatomic) id view;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewIsAppearing:(BOOL)animated;
- (void)nsw_setNeedsUpdateOfStatusBarPlacement;
@end

NS_ASSUME_NONNULL_END

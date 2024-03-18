//
//  DynamicView.hpp
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/18/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicView : NSObject
@property (class, readonly, nonatomic) Class dynamicIsa;
@property (copy, nonatomic) UIColor * _Nullable backgroundColor;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGRect bounds;
@property (nonatomic) BOOL translatesAutoresizingMaskIntoConstraints;
@property (nonatomic) NSUInteger autoresizingMask;
+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(id)subview;
- (void)_wheelChangedWithEvent:(id)event;
@end

NS_ASSUME_NONNULL_END

//
//  ChannelsViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import "ChannelsViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "ChannelsViewModel.hpp"
#import "ChannelsCollectionViewCell.hpp"

__attribute__((objc_direct_members))
@interface ChannelsViewController ()
@property (retain, readonly, nonatomic) ChannelsViewModel *viewModel;
@property (retain, readonly, nonatomic) id cellRegistration;
@end

@implementation ChannelsViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ChannelsViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ChannelsViewController", 0);
        
        class_addProtocol(_isa, NSProtocolFromString(@"PUICListCollectionViewLayoutDelegate"));
        
        class_addIvar(_isa, "_viewModel", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_cellRegistration", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_nsw_puic_statusBarPlacement", sizeof(NSInteger), sizeof(NSInteger), @encode(NSInteger));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP collectionView_trailingSwipeActionsConfigurationForItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:trailingSwipeActionsConfigurationForItemAtIndexPath:));
    class_addMethod(isa, @selector(collectionView:trailingSwipeActionsConfigurationForItemAtIndexPath:), collectionView_trailingSwipeActionsConfigurationForItemAtIndexPath, NULL);
}

- (void)dealloc {
    id _viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&_viewModel));
    [_viewModel release];
    
    id _cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&_cellRegistration));
    [_cellRegistration release];
    
    [super dealloc];
}

- (NSInteger)puic_statusBarPlacement {
    NSInteger puic_statusBarPlacement;
    object_getInstanceVariable(self, "_nsw_puic_statusBarPlacement", reinterpret_cast<void **>(&puic_statusBarPlacement));
    return puic_statusBarPlacement;
}

- (void)loadView {
    id collectionViewLayout = [objc_lookUpClass("PUICListCollectionViewLayout") new];
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(collectionViewLayout, sel_registerName("setCurvesBottom:"), YES);
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(collectionViewLayout, sel_registerName("setCurvesTop:"), YES);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(collectionViewLayout, sel_registerName("setDelegate:"), self);
    
    // PUICCrownIndicatorContext 커스턴
    id collectionView = reinterpret_cast<id (*)(id, SEL, CGRect, id)>(objc_msgSend)([objc_lookUpClass("PUICListCollectionView") alloc], sel_registerName("initWithFrame:collectionViewLayout:"), CGRectNull, collectionViewLayout);
    
    [collectionViewLayout release];
    
    self.view = collectionView;
    
    [collectionView release];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    id crownInputSequencer = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self.view, sel_registerName("puic_crownInputSequencer"));
    id crownIndicatorContext = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(crownInputSequencer, sel_registerName("crownIndicatorContext"));
    CGSize trackSize = reinterpret_cast<CGSize (*)(id, SEL)>(objc_msgSend)(crownIndicatorContext, sel_registerName("trackSize"));
    NSLog(@"%@", crownIndicatorContext);
    NSLog(@"%@", NSStringFromCGSize(trackSize));
    
    reinterpret_cast<void (*)(id, SEL, CGSize)>(objc_msgSend)(crownIndicatorContext, sel_registerName("setTrackSize:"), CGSizeMake(40.f, 100.f));
    reinterpret_cast<void (*)(id, SEL)>(objc_msgSend)(crownIndicatorContext, sel_registerName("_refreshPropertiesForWindow"));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadDataSourceWithCompletionHandler:nil];
}

- (ChannelsViewModel *)viewModel __attribute__((objc_direct)) {
    ChannelsViewModel *viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&viewModel));
    
    if (viewModel) return viewModel;
    
    viewModel = [[ChannelsViewModel alloc] initWithDataSource:[self makeDataSource]];
    
    object_setInstanceVariable(self, "_viewModel", [viewModel retain]);
    return [viewModel autorelease];
}

- (id)cellRegistration {
    id cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&cellRegistration));
    
    if (cellRegistration) return cellRegistration;
    
    cellRegistration = reinterpret_cast<id (*)(Class, SEL, Class, id)>(objc_msgSend)(objc_lookUpClass("UICollectionViewCellRegistration"), sel_registerName("registrationWithCellClass:configurationHandler:"), ChannelsCollectionViewCell.dynamicIsa, ^(ChannelsCollectionViewCell *cell, NSIndexPath *indexPath, id item) {
        
    });
    
    object_setInstanceVariable(self, "_cellRegistration", [cellRegistration retain]);
    return cellRegistration;
}

- (id)makeDataSource __attribute__((objc_direct)) {
    id cellRegistration = self.cellRegistration;
    
    id dataSource = reinterpret_cast<id (*)(id, SEL, id, id)>(objc_msgSend)([objc_lookUpClass("UICollectionViewDiffableDataSource") alloc], sel_registerName("initWithCollectionView:cellProvider:"), self.view, ^id _Nullable(id  _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        id cell = reinterpret_cast<id (*)(id, SEL, id, id, id)>(objc_msgSend)(collectionView, sel_registerName("dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:"), cellRegistration, indexPath, itemIdentifier);
        
        return cell;
    });
    
    return [dataSource autorelease];
}

- (id)collectionView:(id)collectionView trailingSwipeActionsConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak auto weakSelf = self;
    
    id testAction = reinterpret_cast<id (*)(Class, SEL, NSInteger, id, id)>(objc_msgSend)(objc_lookUpClass("UIContextualAction"), sel_registerName("contextualActionWithStyle:title:handler:"), 0, nil, ^(id action, id sourceView, void (^completionHandler)(BOOL actionPerformed)){
        NSInteger newValue;
        if (weakSelf.puic_statusBarPlacement) {
            newValue = 0;
        } else {
            newValue = 1;
        }
        
        object_setInstanceVariable(weakSelf, "_nsw_puic_statusBarPlacement", (id)newValue);
        [weakSelf nsw_setNeedsUpdateOfStatusBarPlacement];
        completionHandler(YES);
    });
    
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(testAction, sel_registerName("setImage:"), [UIImage systemImageNamed:@"eraser.line.dashed"]);
    
//    id action = reinterpret_cast<id (*)(Class, SEL, id, id, id, id)>(objc_msgSend)(objc_lookUpClass("UIAction"), sel_registerName("actionWithTitle:image:identifier:handler:"), @"Hello", [UIImage systemImageNamed:@"eraser.line.dashed"], nil, ^(id action) {
//        
//    });
//    
//    id menu = reinterpret_cast<id (*)(Class, SEL, id, id)>(objc_msgSend)(objc_lookUpClass("UIMenu"), sel_registerName("menuWithTitle:children:"), @"Test", @[action]);
//    
//    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(testAction, sel_registerName("_setMenu:"), menu);
    
    UIColor *backgroundColor = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(UIColor.class, sel_registerName("arouetBlueColor"));
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(testAction, sel_registerName("setBackgroundColor:"), backgroundColor);
    
    id swipeActions = reinterpret_cast<id (*)(Class, SEL, id)>(objc_msgSend)(objc_lookUpClass("UISwipeActionsConfiguration"), sel_registerName("configurationWithActions:"), @[testAction]);
    
    return swipeActions;
}

@end

//
//  RepliesItemModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "RepliesItemModel.hpp"

NSString * const RepliesItemModelMessageKey = @"message";

@implementation RepliesItemModel

- (instancetype)initWithType:(RepliesItemModelType)type {
    if (self = [super init]) {
        _type = type;
    }
    
    return self;
}

- (void)dealloc {
    [_userInfo release];
    [super dealloc];
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([super isEqual:other]) {
        return YES;
    } else {
        auto casted = static_cast<decltype(self)>(other);
        return _type == casted->_type && [_userInfo isEqualToDictionary:casted->_userInfo];
    }
}

- (NSUInteger)hash {
    return _type ^ _userInfo.hash;
}

@end

//
//  ChannelsSectionModel.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/19/24.
//

#import "ChannelsSectionModel.hpp"

@implementation ChannelsSectionModel

- (instancetype)initWithType:(ChannelsSectionModelType)type {
    if (self = [super init]) {
        _type = type;
    }
    
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([super isEqual:other]) {
        return YES;
    } else {
        return _type == static_cast<decltype(self)>(other)->_type;
    }
}

- (NSUInteger)hash {
    return _type;
}

@end

/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "CKComponent+Yoga.h"
#import "CKCompositeComponentInternal.h"

YGConfigRef ckYogaDefaultConfig()
{
  static YGConfigRef defaultConfig;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    defaultConfig = YGConfigNew();
    YGConfigSetPointScaleFactor(defaultConfig, [UIScreen mainScreen].scale);
  });
  return defaultConfig;
}

@implementation CKComponent (Yoga)

- (BOOL)isYogaBasedLayout
{
  return NO;
}

- (YGNodeRef)ygNode:(CKSizeRange)constrainedSize
{
  return YGNodeNewWithConfig(ckYogaDefaultConfig());
}

- (CKComponentLayout)layoutFromYgNode:(YGNodeRef)layoutNode thatFits:(CKSizeRange)constrainedSize
{
  return {};
}

- (BOOL)usesCustomBaseline
{
  return NO;
}

@end

@implementation CKCompositeComponent (Yoga)

- (BOOL)isYogaBasedLayout
{
  return self.component.isYogaBasedLayout;
}

- (YGNodeRef)ygNode:(CKSizeRange)constrainedSize
{
  return [self.component ygNode:constrainedSize];
}

- (CKComponentLayout)layoutFromYgNode:(YGNodeRef)layoutNode thatFits:(CKSizeRange)constrainedSize
{
  const CKComponentLayout l = [self.component layoutFromYgNode:layoutNode thatFits:constrainedSize];
  return {self, l.size, {{{0,0}, l}}};
}

@end

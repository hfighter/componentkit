/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <Foundation/Foundation.h>

#import <ComponentKit/CKComponentProvider.h>
#import <ComponentKit/CKDimension.h>

/** Immutable value object that configures a data source */
@interface CKDataSourceConfiguration : NSObject

/**
 @param componentProvider See @protocol(CKComponentProvider)
 @param context Passed to methods exposed by @protocol(CKComponentProvider).
 @param sizeRange Used for the root layout.
 */
- (instancetype)initWithComponentProvider:(Class<CKComponentProvider>)componentProvider
                                  context:(id<NSObject>)context
                                sizeRange:(const CKSizeRange &)sizeRange;

- (instancetype)initWithComponentProviderFunc:(CKComponentProviderFunc)componentProvider
                                      context:(id<NSObject>)context
                                    sizeRange:(const CKSizeRange &)sizeRange;

@property (nonatomic, strong, readonly) id<NSObject> context;

- (const CKSizeRange &)sizeRange;
- (CKComponentProviderBlock)componentProvider;
- (BOOL)hasSameComponentProviderAndContextAs:(CKDataSourceConfiguration *)other;

@end

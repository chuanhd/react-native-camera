//
//  ZxingBarcodeDetectorManagerKit.h
//  react-native-camera
//
//  Created by Chuan Ho Danh on 10/30/19.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZXingObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXingBarcodeDetectorManagerKit : NSObject <ZXImageDecoderDelegate>

- (instancetype)init;

-(BOOL)isRealDetector;

+(NSDictionary *)constants;

- (void) setPossibleBarcodeFormats:(id)json;

- (void) findBarcodeInFrame:(CGImageRef)image withRotation:(CGFloat)rotation inverted:(BOOL)inverted withCompletion:(void (^)(ZXResult *result))completed;

@end

NS_ASSUME_NONNULL_END

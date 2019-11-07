//
//  ZxingBarcodeDetectorManagerKit.m
//  react-native-camera
//
//  Created by Chuan Ho Danh on 10/30/19.
//

#import "ZXingBarcodeDetectorManagerKit.h"
#import <React/RCTConvert.h>

@interface ZXingBarcodeDetectorManagerKit()
@property (nonatomic, strong) ZXImageDecoder * imageDecoder;
@property (nonatomic, copy, nullable) void (^barcodeDetectedCompletion)(ZXResult *);
@end

@implementation ZXingBarcodeDetectorManagerKit

- (instancetype)init
{
  if (self = [super init]) {
      self.imageDecoder = [[ZXImageDecoder alloc] init];
      self.imageDecoder.delegate = self;
  }
  return self;
}

- (BOOL)isRealDetector
{
  return true;
}

- (void)setPossibleBarcodeFormats:(id)json {
    NSArray * types = [RCTConvert NSArray:json];
    
    ZXDecodeHints * hints = [[ZXDecodeHints alloc] init];
    hints.tryHarder = YES;

    for (NSString * type in types) {
        NSNumber * format = [[ZXingBarcodeDetectorManagerKit constants] objectForKey:type];
        if (format != NULL) {
            [hints addPossibleFormat:format.intValue];
        }
    }
    
    if (self.imageDecoder != NULL) {
        [self.imageDecoder setHints:hints];
    }
}

+ (NSDictionary *)constants
{
    return @{
                @"CODE_128" : @(kBarcodeFormatCode128),
                @"CODE_39" : @(kBarcodeFormatCode39),
                @"CODE_93" : @(kBarcodeFormatCode93),
                @"CODABAR" : @(kBarcodeFormatCodabar),
                @"EAN_13" : @(kBarcodeFormatEan13),
                @"EAN_8" : @(kBarcodeFormatEan8),
                @"ITF" : @(kBarcodeFormatITF),
                @"UPC_A" : @(kBarcodeFormatUPCA),
                @"UPC_E" : @(kBarcodeFormatUPCE),
                @"QR_CODE" : @(kBarcodeFormatQRCode),
                @"PDF417" : @(kBarcodeFormatPDF417),
                @"AZTEC" : @(kBarcodeFormatAztec),
                @"DATA_MATRIX" : @(kBarcodeFormatDataMatrix),
                @"RSS14_LIMITED" : @(kBarcodeFormatRSS14Limited),
            };
}

- (void)findBarcodeInFrame:(CGImageRef)image withRotation:(CGFloat)rotation inverted:(BOOL)inverted withCompletion:(void (^)(ZXResult *result))completed {
    [self.imageDecoder decodeImage:image rotation:rotation inverted:inverted];
    self.barcodeDetectedCompletion = completed;
}

- (void)decodeResult:(ZXImageDecoder *)imageDecoder result:(ZXResult *)result {
    NSLog(@"ZXing decoded result: %@", result);
    
    if (self.barcodeDetectedCompletion) {
        self.barcodeDetectedCompletion(result);
    }
    
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end

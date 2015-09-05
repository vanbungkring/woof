//
//  Util.h
//  Chopchop
//
//  Created by Arie on 9/5/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreLocation/CoreLocation.h>
#import <sys/types.h>
#import <sys/sysctl.h>

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)
#define IS_iPhone_4_INCH ([[UIScreen mainScreen] bounds].size.height == 568)?YES:NO
#define IS_iPhone_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480)?YES:NO

@interface Util : NSObject

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+ (NSString *)nullToEmptyString:(id)value;
+ (UIColor *)getColor:(NSString *)hexColor withAlpha:(CGFloat)alpha;
+ (UIColor *)getColor:(NSString *)hexColor;
+ (UIImage *)resizedImage:(UIImage *)inImage frame:(CGRect)thumbRect;
+ (NSMutableDictionary *)twitterAuthData;
+ (NSURL *)urlFromString:(NSString *)urlString;
+ (UIImage *)imageByScaling:(BOOL)isScaling cropping:(BOOL)isCropping sourceImage:(UIImage *)sourceImage frame:(CGRect)targetFrame;
+ (NSString *)sha1:(NSString*)input;
+ (NSString *)generateRandomStringWithLength:(NSInteger)length;
+ (void)logAllFontFamiliesAndName;
+ (CGFloat)getDistanceFromLong:(double)longitude lat:(double)latitude andLong2:(double)longitude2 lat2:(double)latitude2;
+ (CGRect)getStringConstrainedSizeWithString:(NSString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size;
+ (CGRect)getStringConstrainedSizeWithAttributedString:(NSAttributedString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size;
+ (NSDate *)localDate:(NSDate *)date;
+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value numDecimalPoint:(NSInteger)numOfDecimalPoint showSign:(BOOL)isShowSign;
+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value;
+ (NSString *)hardwareString;
+ (NSString *)uniqueIdentifier;
+ (NSString *)priceFormat:(NSInteger)price;
+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat;
+ (NSTimeInterval)getCurrentTime;
+ (NSDate *)convertToDate:(NSString *)arrivalDateString; // Special case
+ (NSDate *)currentDate;
+ (CGSize)screenSize;
+ (NSString *)boolToString:(BOOL)boolean;
+ (BOOL)stringToBool:(NSString *)string;
+ (BOOL)isNullValue:(id)value;
+ (BOOL)isAlphabetCharactersOnlyFromText:(NSString *)text;
+ (BOOL)validatePhoneNumber:(NSString *)candidate;
+ (BOOL)validateAllNumber:(NSString *)candidate;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (NSDictionary *)parseQueryString:(NSString *)query;
+ (NSString *)stringFromJSON:(id)json;
+ (id)jsonFromString:(NSString *)string;
+ (NSString *)dateStringFromTimestamp:(NSString *)timestamp;
+ (NSString *)dateStringFromTimestamp:(NSString *)timestamp usingDateFormat:(NSString *)dateFormat;
+ (UIColor *)hexToColor:(NSInteger)hex;
+ (NSInteger)getRangeDate:(NSDate *)fromDate date:(NSDate *)toDate;
+ (NSMutableDictionary *)changeKeyForDictionary:(NSDictionary *)dict withNewKey:(NSString *)newKey andOldKey:(NSString *)oldKey;
+ (NSString*)phoneNumberWithPrefix:(NSString*)telPref number:(NSString*)number;
////just for tracking
+ (NSString *)dictionaryToString:(NSDictionary *)dictionary;
@end
//
//  Util.m
//  Chopchop
//
//  Created by Arie on 9/5/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <string.h>
#import "Util.h"

@implementation Util

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate{
    if ([date compare:beginDate] == NSOrderedAscending){
        return NO;
    }
    
    if ([date compare:endDate] == NSOrderedDescending){
        return NO;
    }
    
    return YES;
}

+ (NSString *)nullToEmptyString:(id)value {
    NSString *emptyString = @"";
    
    if (!value) return emptyString;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyString;
    }
    
    return (NSString *)value;
}

+ (NSMutableDictionary *)twitterAuthData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *authData = [defaults objectForKey:@"authData"];
    
    if (!authData) return nil;
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    NSArray *results = [authData componentsSeparatedByString:@"&"];
    
    for (NSString *result in results) {
        NSArray *keyvalues = [result componentsSeparatedByString:@"="];
        
        if ([keyvalues count] > 1) {
            NSString *key = [keyvalues objectAtIndex:0];
            NSString *value = [keyvalues objectAtIndex:1];
            
            [data setObject:value forKey:key];
        }
    }
    
    return data;
}

+ (UIImage *)resizedImage:(UIImage *)inImage frame:(CGRect)thumbRect {
    CGImageRef imageRef = [inImage CGImage];
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,		// width
                                                thumbRect.size.height,		// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                kCGBitmapAlphaInfoMask
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

+ (UIColor *)getColor:(NSString *)hexColor withAlpha:(CGFloat)alpha {
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

+ (UIColor *)getColor:(NSString *)hexColor {
    return [self getColor:hexColor withAlpha:1.0f];
}

+ (NSURL *)urlFromString:(NSString *)urlString {
    
    if ([urlString hasPrefix:@"http://"]) { //if from web with http header
        
        NSString *_path = [NSString stringWithFormat:@"%@", urlString];
        return [NSURL URLWithString:_path];
        
    } else { //if without http header (local resource)
        
        NSArray *_urlParts = [urlString componentsSeparatedByString:@"."];
        NSString *_path = [[NSBundle mainBundle] pathForResource:[_urlParts objectAtIndex:0] ofType:[_urlParts objectAtIndex:1]];
        return [NSURL fileURLWithPath:_path];
        
    }
    
}

+ (UIImage *)imageByScaling:(BOOL)isScaling cropping:(BOOL)isCropping sourceImage:(UIImage *)sourceImage frame:(CGRect)targetFrame {
    CGSize targetSize = targetFrame.size;
    
    CGPoint thumbnailPoint = CGPointMake(0.0f, 0.0f);
    if(isScaling && isCropping)thumbnailPoint = CGPointMake(0.0f, 0.0f);
    else if(isScaling)thumbnailPoint = CGPointMake(0.0f, 0.0f);
    else if(isCropping)thumbnailPoint = CGPointMake(-targetFrame.origin.x, -targetFrame.origin.y);
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat scaledWidth = targetSize.width;
    CGFloat scaledHeight = targetSize.height;
    
    if(isScaling){
        scaledWidth = targetSize.width;
        scaledHeight = targetSize.height;
    }
    else{
        scaledWidth = imageSize.width;
        scaledHeight = imageSize.height;
    }
    
    UIImage *newImage = nil;
    CGFloat scaleFactor = 0.0;
    
    if (isScaling){
        if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
            CGFloat widthFactor = targetSize.width / imageSize.width;
            CGFloat heightFactor = targetSize.height / imageSize.height;
            
            if (widthFactor > heightFactor) scaleFactor = widthFactor; //Scale to Fit Witdth
            else scaleFactor = heightFactor; //Scale to Fit Height
            
            scaledWidth  = imageSize.width * scaleFactor;
            scaledHeight = imageSize.height * scaleFactor;
            
            //Center The Image
            if (widthFactor > heightFactor){
                thumbnailPoint.y = (targetSize.height - scaledHeight) * 0.5;
            } else {
                if (widthFactor < heightFactor) {
                    thumbnailPoint.x = (targetSize.width - scaledWidth) * 0.5;
                }
            }
        }
    }
    
    if (isCropping) {
        //Crop Image
        UIGraphicsBeginImageContext(targetSize);
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        [sourceImage drawInRect:thumbnailRect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage == nil)NSLog(@"Faild to Crop Image");
        
        //Pop Context
        UIGraphicsEndImageContext();
    }
    return newImage;
}

+ (NSString *)sha1:(NSString*)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+ (NSString *)generateRandomStringWithLength:(NSInteger)length {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    for (int i=0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (void)logAllFontFamiliesAndName {
    for (NSString *fontFamily in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamily]) {
            NSLog(@"Font Name: %@", fontName);
        }
    }
}

+ (CGFloat)getDistanceFromLong:(double)longitude lat:(double)latitude andLong2:(double)longitude2 lat2:(double)latitude2 {
    CLLocation *locationA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *locationB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    
    CLLocationDistance distanceInMeters = [locationA distanceFromLocation:locationB];
    
    return distanceInMeters;
}

+ (CGRect)getStringConstrainedSizeWithString:(NSString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size {
    CGRect countedRect = CGRectZero;
    if ([string isEqual:[NSNull null]]) {
        return countedRect;
    }
    if ([string length] == 0) {
        return countedRect;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    countedRect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{
                                                 NSFontAttributeName:font,
                                                 NSParagraphStyleAttributeName:paragraphStyle
                                                 }
                                       context:nil];
    
    return countedRect;
}

+ (CGRect)getStringConstrainedSizeWithAttributedString:(NSAttributedString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size {
    CGRect countRect = CGRectZero;
    if ([string length] == 0) {
        return countRect;
    }
    
    countRect = [string boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                     context:nil];
    
    return countRect;
}

+ (NSDate *)localDate:(NSDate *)date {
    NSDate *sourceDate = date;
    
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return destinationDate;
}

+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value {
    return [Util formattedCurrencyWithCurrencySign:currencySign value:value numDecimalPoint:0 showSign:YES];
}

/**
 * Formatted number based on currencySign. Current implementation is not ideal yet. Formatting number should be based on current locale.
 */
+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value numDecimalPoint:(NSInteger)numOfDecimalPoint showSign:(BOOL)isShowSign {
    static NSNumberFormatter *numberFormatter;
    
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.usesGroupingSeparator = YES;
    }
    
    numberFormatter.minimumFractionDigits = numOfDecimalPoint;
    numberFormatter.maximumFractionDigits = numOfDecimalPoint;
    // Special case to Indonesian's Rupiah
    if ([currencySign isEqualToString:@"Rp"]) {
        numberFormatter.groupingSeparator = @".";
        numberFormatter.decimalSeparator = @".";
    }
    else {
        numberFormatter.groupingSeparator = @",";
        numberFormatter.decimalSeparator = @".";
    }
    
    NSNumber *number = [NSNumber numberWithDouble:((double)value / pow(10, numOfDecimalPoint))];
    if (isShowSign) {
        return [NSString stringWithFormat:@"%@%@", currencySign, [numberFormatter stringFromNumber:number]];
    }
    else {
        return [numberFormatter stringFromNumber:number];
    }
}

+ (NSString *)hardwareString {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

+ (NSString *)uniqueIdentifier {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)priceFormat:(NSInteger)price {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:@"."];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setMaximumFractionDigits:2];
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithInteger:price]];
}

+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSTimeInterval)getCurrentTime {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+ (NSDate *)convertToDate:(NSString *)dateString {
    NSArray *dateArray = [dateString componentsSeparatedByString:@" "];
    NSString *dayString = [dateArray objectAtIndex:1];
    NSString *monthString = [dateArray objectAtIndex:2];
    NSString *yearString = [dateArray objectAtIndex:3];
    
    NSInteger month = 0;
    NSArray *monthNames = @[@"Jan", @"Feb", @"Mar", @"Apr", @"Mei", @"Jun", @"Jul", @"Agu", @"Sep", @"Okt", @"Nov", @"Des"];
    for (int i = 0; i < [monthNames count]; i++) {
        NSString *monthName = [monthNames objectAtIndex:i];
        if ([monthString isEqualToString:monthName]) {
            month = i + 1;
            break;
        }
    }
    
    NSString *tempDateString = [NSString stringWithFormat:@"%@-%ld-%@", dayString, (long)month, yearString];
    return [Util dateFromString:tempDateString withFormat:@"d-M-yyyy"];
}

+ (NSDate *)currentDate {
    return [NSDate date];
}

+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (NSString *)boolToString:(BOOL)boolean {
    return (boolean) ? @"true" : @"false";
}

+ (BOOL)stringToBool:(NSString *)string {
    return ([string isEqualToString:@"true"]);
}

+ (BOOL)isNullValue:(id)value {
    return (value == (id)[NSNull null]);
}

+ (BOOL)isAlphabetCharactersOnlyFromText:(NSString *)text {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    NSCharacterSet *notLetters = [[NSCharacterSet characterSetWithCharactersInString:letters] invertedSet];
    
    BOOL valid = YES;
    
    for (int i = 0; i < [text length]; i++) {
        unichar c = [text characterAtIndex:i];
        if ([notLetters characterIsMember:c]) {
            valid = NO;
        }
    }
    return valid;
}

+ (BOOL)validatePhoneNumber:(NSString *)candidate {
    NSString *phoneNumberRegex = @"^[\\+0]?[1-9][0-9]*$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", phoneNumberRegex];
    
    return [phoneNumberTest evaluateWithObject:candidate];
}

+ (BOOL)validateAllNumber:(NSString *)candidate {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", numberRegex];
    
    return [numberTest evaluateWithObject:candidate];
}

+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

+ (NSString *)stringFromJSON:(id)json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"Got an error stringFromJSON method: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id)jsonFromString:(NSString *)string {
    NSError *error;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&error];
    if (!json) {
        NSLog(@"Got an error jsonFromString method: %@", error);
    }
    return json;
}

+ (NSString *)dateStringFromTimestamp:(NSString *)timestamp {
    if (!timestamp) {
        return @"";
    }
    else {
        NSTimeInterval timeInterval = [timestamp doubleValue] / 1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateFormat:@"d MMM yyyy"];
        
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString *)dateStringFromTimestamp:(NSString *)timestamp usingDateFormat:(NSString *)dateFormat {
    if (!timestamp) {
        return @"";
    }
    else {
        NSTimeInterval timeInterval = [timestamp doubleValue] / 1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateFormat:dateFormat];
        
        return [dateFormatter stringFromDate:date];
    }
}

+ (UIColor *)hexToColor:(NSInteger)hex {
    NSInteger divider = 256;
    
    CGFloat blue = hex % divider;
    hex /= divider;
    
    CGFloat green = hex % divider;
    hex /= divider;
    
    CGFloat red = hex % divider;
    CGFloat alpha = 1.0f;
    
    return [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:alpha];
}

+ (NSInteger)getRangeDate:(NSDate *)fromDate date:(NSDate *)toDate {
    
    NSDateFormatter *dateComparisonFormatter = [[NSDateFormatter alloc] init];
    [dateComparisonFormatter setDateFormat:@"yyyy-MM-dd"];
    
    if( [[dateComparisonFormatter stringFromDate:fromDate] isEqualToString:[dateComparisonFormatter stringFromDate:toDate]] ) {
        return 0;
    }
    else {
        NSUInteger unitFlags = NSDayCalendarUnit;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
        return [components day]+1;
    }
}

+ (NSMutableDictionary *)changeKeyForDictionary:(NSDictionary *)dict withNewKey:(NSString *)newKey andOldKey:(NSString *)oldKey {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    [dictionary setObject: [dictionary objectForKey: oldKey] forKey:newKey];
    [dictionary removeObjectForKey:oldKey];
    
    return dictionary;
}

+ (NSString*)phoneNumberWithPrefix:(NSString *)telPref number:(NSString *)number {
    if (number.length <= 1) {
        return number;
    }
    else if ([[number substringToIndex:telPref.length] isEqualToString:telPref]) {
        return number;
    }
    else if ([number characterAtIndex:0] == '0') {
        return [NSString stringWithFormat:@"%@%@",telPref, [number substringFromIndex:1]];
    }
    else if ([number rangeOfString:[telPref substringFromIndex:1]].location == 0) {
        return [NSString stringWithFormat:@"+%@", number];
    }
    else if ([number characterAtIndex:0] == '+') {
        return number;
    }
    else {
        return [NSString stringWithFormat:@"%@%@", telPref, number];
    }
}
+ (NSString *)dictionaryToString:(NSDictionary *)dictionary {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    return [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
}
@end
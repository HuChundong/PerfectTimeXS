#import <UIKit/UIFont.h>
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.huchundong.PerfectTimeXS.plist"
#define TWEAKEBUG 1

#ifndef TWEAKEBUG
#define printf(str, ...)
#define NSLog(str, ...)
#endif

static BOOL legacyFont = false;


/*
 * 是否启用
 */
static BOOL	enable1 = true;
static BOOL	enable2 = true;
static BOOL	enable3 = false;
static BOOL	enable4 = false;


/*
 * 字体大小
 */
static int	fontSize1	= 15;
static int	fontSize2	= 9;
static int	fontSize3	= 9;
static int	fontSize4	= 9;


/*
 * 格式
 */
static NSString *format1	= @"HH:mm";
static NSString *format2	= @" E";
static NSString *format3	= @"";
static NSString *format4	= @"";


/*
 * 字体偏移
 */
static CGFloat	fontOffset1	= 0;
static CGFloat	fontOffset2	= 0;
static CGFloat	fontOffset3	= 0;
static CGFloat	fontOffset4	= 0;


/*
 * 是否粗体
 */
static BOOL	isBold1 = false;
static BOOL	isBold2 = false;
static BOOL	isBold3 = false;
static BOOL	isBold4 = false;


/*
 * 是否换行
 */
static BOOL	breakLine1	= false;
static BOOL	breakLine2	= false;
static BOOL	breakLine3	= false;


/*
 * 全局语言
 */
static NSString *language = @"zh_CN";


/*
 * 是否显示定位图标
 */
static BOOL showLocation = false;


/*
 * 全局的布局样式
 */
static int textAlignment = 0;


/*
 * 格式化时间
 */

@implementation NSDateFormatter (Locale)
- (id) initWithSafeLocale {
    static NSLocale* en_US_POSIX = nil;
    self = [self init];
    if (en_US_POSIX == nil)
    {
        en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    [self setLocale : en_US_POSIX];
    return(self);
}
@end

static NSString* doAMPM(NSString* timeX, NSString* hour)
{
    NSArray *ampm	= @[@"凌晨", @"凌晨", @"凌晨", @"凌晨", @"黎明", @"拂晓", @"清晨", @"清晨", @"上午", @"上午", @"上午", @"中午", @"中午", @"下午", @"下午", @"下午", @"黄昏", @"傍晚", @"晚上", @"晚上", @"晚上", @"晚上", @"深夜", @"午夜"];
    NSRange range	= [timeX rangeOfString:@"AM"];
    if (range.location == NSNotFound)
    {
        range = [timeX rangeOfString:@"PM"];
    }
    if (range.location == NSNotFound)
    {
        range = [timeX rangeOfString:@"上午"];
    }
    if (range.location == NSNotFound)
    {
        range = [timeX rangeOfString:@"下午"];
    }
    if (range.location != NSNotFound && hour != nil && hour.length > 0)
    {
        NSString	*bStr	= [timeX substringWithRange:range];
        int		ho	= [hour intValue];
        if (ho >= 0 && ho <= 23)
        {
            NSString *timeX2 = [timeX stringByReplacingOccurrencesOfString : bStr withString :ampm[ho]];
            return(timeX2);
        }
    }
    /* NSLog(@"PerfectTimeXargsetText timeX %@", timeX); */
    return(timeX);
}


static void loadPrefs()
{
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    
    enable1 = [settings objectForKey:@"enable1"] ?[[settings objectForKey : @"enable1"] boolValue] : true;
    enable2 = [settings objectForKey:@"enable2"] ?[[settings objectForKey : @"enable2"] boolValue] : true;
    enable3 = [settings objectForKey:@"enable3"] ?[[settings objectForKey : @"enable3"] boolValue] : false;
    enable4 = [settings objectForKey:@"enable4"] ?[[settings objectForKey : @"enable4"] boolValue] : false;
    if (enable1)
    {
        fontSize1	= [settings valueForKey:@"fontSize1"] ?[[settings valueForKey : @"fontSize1"] intValue] : 15;
        format1		= [settings objectForKey:@"format1"] ?[settings objectForKey : @"format1"]  : @"HH:mm";
        fontOffset1	= [settings objectForKey:@"fontOffset1"] ?[[settings objectForKey : @"fontOffset1"] floatValue] : 0;
        isBold1		= [settings objectForKey:@"isBold1"] ?[[settings objectForKey : @"isBold1"] boolValue] : false;
        breakLine1	= [settings objectForKey:@"breakLine1"] ?[[settings objectForKey : @"breakLine1"] boolValue] : false;
    }
    if (enable2)
    {
        fontSize2	= [settings valueForKey : @"fontSize2"] ?[[settings valueForKey : @"fontSize2"] intValue] : 9;
        format2		= [settings objectForKey:@"format2"] ?[settings objectForKey : @"format2"]  : @" E";
        fontOffset2	= [settings objectForKey:@"fontOffset2"] ?[[settings objectForKey : @"fontOffset2"] floatValue] : 0;
        isBold2		= [settings objectForKey:@"isBold2"] ?[[settings objectForKey : @"isBold2"] boolValue] : false;
        breakLine2	= [settings objectForKey:@"breakLine2"] ?[[settings objectForKey : @"breakLine2"] boolValue] : false;
    }
    if (enable3)
    {
        fontSize3	= [settings valueForKey : @"fontSize3"] ?[[settings valueForKey : @"fontSize3"] intValue] : 9;
        format3		= [settings objectForKey:@"format3"] ?[settings objectForKey : @"format3"]  : @"";
        fontOffset3	= [settings objectForKey:@"fontOffset3"] ?[[settings objectForKey : @"fontOffset3"] floatValue] : 0;
        isBold3		= [settings objectForKey:@"isBold3"] ?[[settings objectForKey : @"isBold3"] boolValue] : false;
        breakLine3	= [settings objectForKey:@"breakLine3"] ?[[settings objectForKey : @"breakLine3"] boolValue] : false;
    }
    if (enable4)
    {
        fontSize4	= [settings valueForKey : @"fontSize4"] ?[[settings valueForKey : @"fontSize4"] intValue] : 9;
        format4		= [settings objectForKey:@"format4"] ?[settings objectForKey : @"format4"]  : @"";
        fontOffset4	= [settings objectForKey:@"fontOffset4"] ?[[settings objectForKey : @"fontOffset4"] floatValue] : 0;
        isBold4		= [settings objectForKey:@"isBold4"] ?[[settings objectForKey : @"isBold4"] boolValue] : false;
    }
    language	= [settings objectForKey : @"language"] ? [settings objectForKey : @"language"]  : @"zh_CN";
    showLocation	= [settings objectForKey:@"location"] ?[[settings objectForKey : @"location"] boolValue] : false;
    textAlignment	= [settings valueForKey:@"textAlignment"] ?[[settings valueForKey : @"textAlignment"] intValue] : 1;
    //[settings release];
}


static NSMutableAttributedString* getTimeStr(NSDate *nowDate)
{
    @autoreleasepool {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] initWithSafeLocale];
        [dateFormatter setTimeStyle : NSDateFormatterNoStyle];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier : language];
        dateFormatter.locale = locale;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
        if (enable1 && format1.length > 0)
        {
            UIFont *font = legacyFont ?  [UIFont fontWithName : isBold1 ? @".SFUIText-Semibold" : @".SFUIText" size : fontSize1] :
            (isBold1 ?[UIFont boldSystemFontOfSize : fontSize1] :[UIFont systemFontOfSize : fontSize1]);
            NSDictionary *attributes1 = @{ NSFontAttributeName : font, NSBaselineOffsetAttributeName : @(fontOffset1), };
            [dateFormatter setDateFormat : format1];
            NSString *ns1 = [dateFormatter stringFromDate:nowDate];
            if ([format1 containsString : @"a"] && [language isEqualToString:@"zh_CN"])
            {
                [dateFormatter setDateFormat : @"H"];
                NSString *hourNs = [dateFormatter stringFromDate:nowDate];
                ns1 = doAMPM(ns1, hourNs);
            }
            if (breakLine1)
            {
                ns1 = [ns1 stringByAppendingString : @"\n"];
            }
            /* NSLog(@"PerfectTimeX enable1 %@", ns1); */
            
            NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:ns1 attributes:attributes1];
            [attributedString appendAttributedString : attr0];
        }
        
        
        if (enable2 && format2.length > 0)
        {
            UIFont *font = legacyFont ?  [UIFont fontWithName : isBold2 ? @".SFUIText-Semibold" : @".SFUIText" size : fontSize2] :
            (isBold2 ?[UIFont boldSystemFontOfSize : fontSize2] :[UIFont systemFontOfSize : fontSize2]);
            NSDictionary *attributes2 = @{ NSFontAttributeName : font, NSBaselineOffsetAttributeName : @(fontOffset2), };
            [dateFormatter setDateFormat : format2];
            NSString *ns1 = [dateFormatter stringFromDate:nowDate];
            
            if ([format2 containsString : @"a"] && [language isEqualToString:@"zh_CN"])
            {
                [dateFormatter setDateFormat : @"H"];
                NSString *hourNs = [dateFormatter stringFromDate:nowDate];
                ns1 = doAMPM(ns1, hourNs);
            }
            if (breakLine2)
            {
                ns1 = [ns1 stringByAppendingString : @"\n"];
            }
            /* NSLog(@"PerfectTimeX enable2 %@", ns1); */
            NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:ns1 attributes:attributes2];
            [attributedString appendAttributedString : attr0];
        }
        
        
        if (enable3 && format3.length > 0)
        {
            UIFont *font = legacyFont ?  [UIFont fontWithName : isBold3 ? @".SFUIText-Semibold" : @".SFUIText" size : fontSize3] :
            (isBold3 ?[UIFont boldSystemFontOfSize : fontSize3] :[UIFont systemFontOfSize : fontSize3]);
            NSDictionary *attributes3 = @{ NSFontAttributeName : font, NSBaselineOffsetAttributeName : @(fontOffset3), };
            [dateFormatter setDateFormat : format3];
            NSString *ns1 = [dateFormatter stringFromDate:nowDate];
            if ([format3 containsString : @"a"] && [language isEqualToString:@"zh_CN"])
            {
                [dateFormatter setDateFormat : @"H"];
                NSString *hourNs = [dateFormatter stringFromDate:nowDate];
                ns1 = doAMPM(ns1, hourNs);
            }
            if (breakLine3)
            {
                ns1 = [ns1 stringByAppendingString : @"\n"];
            }
            /* NSLog(@"PerfectTimeX enable3 %@", ns1); */
            NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:ns1 attributes:attributes3];
            [attributedString appendAttributedString : attr0];
        }
        
        if (enable4 && format4.length > 0)
        {
            UIFont *font = legacyFont ?  [UIFont fontWithName : isBold4 ? @".SFUIText-Semibold" : @".SFUIText" size : fontSize4] :
            (isBold4 ?[UIFont boldSystemFontOfSize : fontSize4] :[UIFont systemFontOfSize : fontSize4]);
            NSDictionary *attributes4 = @{ NSFontAttributeName : font, NSBaselineOffsetAttributeName : @(fontOffset4), };
            [dateFormatter setDateFormat : format4];
            NSString *ns1 = [dateFormatter stringFromDate:nowDate];
            if ([format4 containsString : @"a"] && [language isEqualToString:@"zh_CN"])
            {
                [dateFormatter setDateFormat : @"H"];
                NSString *hourNs = [dateFormatter stringFromDate:nowDate];
                ns1 = doAMPM(ns1, hourNs);
            }
            NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:ns1 attributes:attributes4];
            [attributedString appendAttributedString : attr0];
        }
        return(attributedString);
    }
}


@interface _UIStatusBarStringView : UILabel
@property (nonatomic) NSInteger							numberOfLines;
@property (nullable, nonatomic, copy) NSString					*text;                          /* default is nil */
@property (nonatomic)     NSTextAlignment					textAlignment;                  /* default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)*/
@property (nullable, nonatomic, copy) NSAttributedString * attributedText	NS_AVAILABLE_IOS(6_0);        /* default is nil */
@property (nonatomic)     NSLineBreakMode					lineBreakMode;
@property (nonatomic, retain) UIColor						* textColor;
@end

%hook _UIStatusBarStringView
- (void) applyStyleAttributes : (id) arg1 {
    if (self.text != nil && [self.text containsString : @":"])
    {
        if (kCFCoreFoundationVersionNumber >= 1443.00 && kCFCoreFoundationVersionNumber<1665.15)
        {
           /* NSLog(@"PerfectTimeX_mode %@", arg1); */
            id val = [arg1 valueForKeyPath : @"style"];
           /* NSLog(@"PerfectTimeX_mode %@", val); */
            BOOL success = true; /* 白色 */
            if ([val isKindOfClass :[NSNumber class ]])
            {
                success = [val boolValue];
            }
            if (success)
            {
                self.textColor = [UIColor whiteColor];
            }else{
                self.textColor = [UIColor blackColor];
            }
        }
    }else{
        %orig(arg1);
    }
}

-(void) setText : (NSString *) text
{
    if ([text containsString : @":"])
    {
        //CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        self.textAlignment	= textAlignment;
        self.numberOfLines	= 0;
        /* NSLog(@"PerfectTimeX setText %@", text); */
        NSDate *nowDate = [NSDate date];
        /* 初始化NSMutableAttributedString */
        self.attributedText = getTimeStr(nowDate);
        //CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        //NSLog(@"PerfectTimeX Linked in %f ms", linkTime * 1000.0);
    }else {
        /* //NSLog(@"PerfectTimeX ORIG %@", text); */
        %orig(text);
    }
}
%end

%hook _UIStatusBarIndicatorLocationItem

- (id) applyUpdate : (id) arg1 toDisplayItem : (id) arg2 {
    /*
     * set it to hidden
     * id res = %orig;
     * id val = [arg2 valueForKeyPath : @"enabled"];
     * if ([val isKindOfClass :[NSNumber class]])
     * {
     * BOOL success = [val boolValue];
     * //NSLog(@"PerfectTimeX_IndicatorLocation %d", success);
     * }*/
    
    if (showLocation)
    {
        return(%orig);
    }else{
        return(nil);
    }
}

%end

@interface _UIStatusBarBackgroundActivityView : UIView
@property (copy) CALayer *pulseLayer;
@end

%hook _UIStatusBarBackgroundActivityView

- (void) setCenter : (CGPoint) point {
    @autoreleasepool {
        CGRect	cgBig	= CGRectMake(0, 0, 64, 32);
        CGRect	cgSmall = CGRectMake(0, 0, 32, 16);
        point.y			= 11;
        self.frame		= self.frame.size.width > 28 ? cgBig : cgSmall;
        self.pulseLayer.frame	= self.frame; /*	= CGRectMake(self.pulseLayer.frame.origin.x, self.pulseLayer.frame.origin.y, self.pulseLayer.frame.size.width*1.171, self.pulseLayer.frame.size.height*1.5); */
        %orig(point);
    }
}
%end

%ctor {
    /* NSLog(@"PerfectTimeX"); */
    loadPrefs();
    /* Only initialize tweak if it is enabled and if the current process is homescreen or an app */
    NSArray *args = [[NSProcessInfo processInfo] arguments];
    if (args != nil && args.count != 0)
    {
        NSString *execPath = args[0];
        if (execPath)
        {
            BOOL	isSpringBoard	= [[execPath lastPathComponent] isEqualToString:@"SpringBoard"];
            BOOL	isApplication	= [execPath rangeOfString:@"/Application"].location != NSNotFound;
            if ((isSpringBoard || isApplication))
            {
                if (kCFCoreFoundationVersionNumber >= 1443.00)
                {
                    %init;
                }
            }else{
                /*
                 * NSString *processName = [[NSProcessInfo processInfo] processName];
                 * NSLog(@"PerfectTimeX processName %@", processName);
                 */
            }
        }
    }
}

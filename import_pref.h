
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.huchundong.PerfectTimeXS.plist"

inline bool GetPrefBool(NSString *key)
{
    return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline NSString* GetPrefString(NSString *key)
{
    return [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] objectForKey:key];
}

inline int GetPrefInt(NSString *key)
{
    return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key)
{
    id temp=nil;
    temp=[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] objectForKey:key];
    return (temp ? [temp floatValue] : 0.125f);
}
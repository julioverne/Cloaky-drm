OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;
#include <sys/utsname.h>
#include <CommonCrypto/CommonDigest.h>

int main() {

NSFileManager *manager = [[[NSFileManager alloc] init] autorelease];

NSString *pref_lice = @"/var/mobile/Library/Preferences/jp.r-plus.Cloaky.plist";

NSString *package = @"jp.r-plus.cloaky";
NSString *version = @"2.0";

struct utsname systemInfo;
    uname(&systemInfo);
NSString *platform =  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

CFStringRef UDID = MGCopyAnswer(CFSTR("UniqueDeviceID"));
CFStringRef BuildVersion = MGCopyAnswer(CFSTR("BuildVersion"));
CFStringRef ProductVersion = MGCopyAnswer(CFSTR("ProductVersion"));

NSString *mountString = [NSString stringWithFormat:@"%@%@%@%@%@%@", (NSString *)UDID, platform, version, (NSString *)BuildVersion, (NSString *)ProductVersion, package];

const char *cStr = [mountString UTF8String];
unsigned char result[CC_SHA1_DIGEST_LENGTH];
CC_SHA1(cStr, strlen(cStr), result);
NSString *keyreg = [NSString  stringWithFormat:
               @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
               result[0], result[1], result[2], result[3], result[4],
               result[5], result[6], result[7],
               result[8], result[9], result[10], result[11], result[12],
               result[13], result[14], result[15],
               result[16], result[17], result[18], result[19]
               ];


if (![manager fileExistsAtPath:pref_lice]) { NSDictionary *dict = [NSDictionary dictionary];[dict writeToFile:pref_lice atomically:YES]; }
NSMutableDictionary *pref_liceCheck=[[NSMutableDictionary alloc] initWithContentsOfFile:pref_lice];
 [pref_liceCheck setObject:keyreg forKey:@"Information"];
BOOL success = [pref_liceCheck writeToFile:pref_lice atomically:YES];

if (!success) {printf("\n*** Error writing license to file! ***\n");}else{
NSDictionary *permission_prefs = [NSDictionary dictionaryWithObjectsAndKeys:
 @"mobile", NSFileOwnerAccountName,
 @"mobile", NSFileGroupOwnerAccountName,
 [NSNumber numberWithUnsignedLong:0644], NSFilePosixPermissions, nil];
[manager setAttributes:permission_prefs ofItemAtPath:pref_lice error:nil];
printf("\n*** License has been generated! ***\n");
}

printf("\n");
printf("Respring!!!\n");
printf("Respring!!!\n");
printf("Respring!!!\n");
printf("\n");
printf("*** Keygen Cloaky by julioverne ***\n");
printf("\n");
}
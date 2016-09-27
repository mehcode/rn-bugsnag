#import "RNBugsnag.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import <Bugsnag/Bugsnag.h>

@implementation RNBugsnag

+ (void)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* bugsnagAPIKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BUGSNAG_API_KEY"];

        [Bugsnag configuration].notifyReleaseStages = @[@"production"];
        [Bugsnag startBugsnagWithApiKey:bugsnagAPIKey];
    });
}

// .notify
RCT_REMAP_METHOD(notifyWithMessage,
                 notifyWithMessage:(NSString *) message
                 reason:(NSString *) reason
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    [Bugsnag notify:[NSException exceptionWithName:message reason:reason userInfo:nil]];

    resolve([NSNull null]);
}

// .setUser
RCT_REMAP_METHOD(setUser,
                 setUser:(NSString *_Nullable) userID
                 userName:(NSString *_Nullable) userName
                 userEmail:(NSString *_Nullable) userEmail
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    [[Bugsnag configuration] setUser:userID
                            withName:userName
                            andEmail:userEmail];

    resolve([NSNull null]);
}

// .clearUser
RCT_REMAP_METHOD(clearUser,
                 clearUser:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    [[Bugsnag configuration] setUser:nil
                            withName:nil
                            andEmail:nil];

    resolve([NSNull null]);
}

// .leaveBreadcrumb
RCT_REMAP_METHOD(leaveBreadcrumb,
                 leaveBreadcrumb:(NSString*) name
                 metadata:(NSDictionary*) metadata
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {

    [Bugsnag leaveBreadcrumbWithBlock:^(BugsnagBreadcrumb *crumb) {
        crumb.name = name;
        crumb.type = BSGBreadcrumbTypeNavigation;
        crumb.metadata = metadata;
    }];

    resolve([NSNull null]);
}

RCT_EXPORT_MODULE();
@end

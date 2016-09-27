#import "RNBugsnag.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import <Bugsnag/Bugsnag.h>

@implementation RNBugsnag

+ (void)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* bugsnagAPIKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BUGSNAG_API_KEY"];
        
//        [Bugsnag configuration].notifyReleaseStages = @[@"production"];
        [Bugsnag startBugsnagWithApiKey:bugsnagID];
    });
}

// .notify
RCT_EXPORT_METHOD(notifyWithMessage:(NSString *) message
                  reason:(NSString *) reason
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [Bugsnag notify:[NSException exceptionWithName:message reason:reason]];
    
    resolve([NSNull null]);
}

// .setUser
RCT_EXPORT_METHOD(setUser:(NSString *_Nullable) userID
                  userName:(NSString *_Nullable) userName
                  userEmail:(NSString *_Nullable) userEmail
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [[Bugsnag configuration] setUser:userID
                            withName:userName
                            andEmail:userEmail];

    resolve([NSNull null]);
}

// .leaveBreadcrumb
RCT_EXPORT_METHOD(leaveBreadcrumb:(NSString*) name
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

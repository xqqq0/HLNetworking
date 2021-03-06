//
//  HLSecurityPolicyConfig.m
//  HLPPShop
//
//  Created by wangshiyu13 on 2016/9/19.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import "HLSecurityPolicyConfig.h"

@interface HLSecurityPolicyConfig ()

@property (readwrite, nonatomic, assign) HLSSLPinningMode SSLPinningMode;

@end

@implementation HLSecurityPolicyConfig
+ (instancetype)policyWithPinningMode:(HLSSLPinningMode)pinningMode {
    HLSecurityPolicyConfig *securityPolicy = [[HLSecurityPolicyConfig alloc] init];
    if (securityPolicy) {
        securityPolicy.SSLPinningMode           = pinningMode;
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName      = YES;
        securityPolicy.cerFilePath              = nil;
    }
    return securityPolicy;
}

- (NSString *)description {
    NSMutableString *desc = [NSMutableString string];
#if DEBUG
    [desc appendString:@"\n----HLSecurityPolicyConfig Start----\n"];
    [desc appendFormat:@"SSLPinningMode: %@\n", [self getpinningModeString:self.SSLPinningMode]];
    [desc appendFormat:@"AllowInvalidCertificates: %@\n", self.allowInvalidCertificates ? @"YES" : @"NO"];
    [desc appendFormat:@"ValidatesDomainName: %@\n", self.validatesDomainName ? @"YES" : @"NO"];
    [desc appendFormat:@"CerFilePath: %@\n", self.cerFilePath ?: @"未设置"];
    [desc appendString:@"--------Config End--------"];
#else
    desc = @"";
#endif
    return desc;
}

- (NSString *)getpinningModeString:(HLSSLPinningMode)mode {
    switch (mode) {
        case HLSSLPinningModeNone:
            return @"HLSSLPinningModeNone";
            break;
        case HLSSLPinningModePublicKey:
            return @"HLSSLPinningModePublicKey";
        case HLSSLPinningModeCertificate:
            return @"HLSSLPinningModeCertificate";
        default:
            return @"HLSSLPinningModeNone";
            break;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    HLSecurityPolicyConfig *config = [[[self class] alloc] init];
    if (config) {
        config.SSLPinningMode = _SSLPinningMode;
        config.allowInvalidCertificates = _allowInvalidCertificates;
        config.validatesDomainName = _validatesDomainName;
        config.cerFilePath = [_cerFilePath copyWithZone:zone];
    }
    return config;
}
@end

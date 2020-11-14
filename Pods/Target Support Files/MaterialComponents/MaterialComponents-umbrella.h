#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MaterialActivityIndicator.h"
#import "MDCActivityIndicator.h"
#import "MDCActivityIndicatorDelegate.h"
#import "MaterialAvailability.h"
#import "MDCAvailability.h"
#import "MaterialFeatureHighlight.h"
#import "MDCFeatureHighlightView.h"
#import "MDCFeatureHighlightViewController.h"
#import "MaterialPalettes.h"
#import "MDCPalettes.h"
#import "MaterialTypography.h"
#import "MDCFontScaler.h"
#import "MDCFontTextStyle.h"
#import "MDCTypography.h"
#import "UIFont+MaterialScalable.h"
#import "UIFont+MaterialSimpleEquality.h"
#import "UIFont+MaterialTypography.h"
#import "UIFontDescriptor+MaterialTypography.h"
#import "MaterialApplication.h"
#import "UIApplication+MDCAppExtensions.h"
#import "MaterialMath.h"
#import "MDCMath.h"

FOUNDATION_EXPORT double MaterialComponentsVersionNumber;
FOUNDATION_EXPORT const unsigned char MaterialComponentsVersionString[];


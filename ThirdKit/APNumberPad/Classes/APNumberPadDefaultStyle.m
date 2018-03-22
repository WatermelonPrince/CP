//
//  APNumberPadDefaultStyle.m
//  APNumberPad
//
//  Created by Andrew Podkovyrin on 16/05/14.
//  Copyright (c) 2014 Podkovyrin. All rights reserved.
//

#import "APNumberPadDefaultStyle.h"
#import "NSBundle+APNumberPad.h"

static inline UIColor *APNP_RGBa(int r, int g, int b, CGFloat alpha) {
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:alpha];
}

@implementation APNumberPadDefaultStyle

#pragma mark - Pad

+ (CGRect)numberPadFrame {
    return CGRectMake(0.0, 0.0, 320.0, 216.0);
}

+ (CGFloat)separator {
    return [UIScreen mainScreen].scale == 2.0 ? 0.5 : 1.0;
}

+ (UIColor *)numberPadBackgroundColor {
//    return APNP_RGBa(183, 186, 191, 1.0);
    return APNP_RGBa(223, 223, 223, 1.0);
}

#pragma mark - Number button

+ (UIFont *)numberButtonFont {
//    return [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    return [UIFont systemFontOfSize:28.0 weight:UIFontWeightRegular];
}

+ (UIColor *)numberButtonTextColor {
    return [UIColor blackColor];
}

+ (UIColor *)numberButtonBackgroundColor {
//    return APNP_RGBa(252, 252, 252, 1.0);
    return APNP_RGBa(255, 255, 255, 1.0);
}

+ (UIColor *)numberButtonHighlightedColor {
    return APNP_RGBa(188, 192, 198, 1.0);
}

#pragma mark - Function button

+ (UIFont *)functionButtonFont {
//    return [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    return [UIFont systemFontOfSize:25.0 weight:UIFontWeightRegular];
}

+ (UIColor *)functionButtonTextColor {
    return [UIColor blackColor];
}

+ (UIColor *)functionButtonBackgroundColor {
    return APNP_RGBa(188, 192, 198, 1.0);
}

+ (UIColor *)redFunctionButtonBackgroundColor {
    return APNP_RGBa(222, 27, 60, 1.0);
}

+ (UIColor *)functionButtonHighlightedColor {
    return APNP_RGBa(252, 252, 252, 1.0);
}

+ (UIImage *)clearFunctionButtonImage {
    return [UIImage imageNamed:@"apnumberpad_backspace_icon.png" inBundle:[NSBundle ap_numberPadResourceBundle] compatibleWithTraitCollection:nil];
}

+ (UIImage *)clearFunctionButtonImageHighlighted {
    return [UIImage imageNamed:@"apnumberpad_backspace_icon.png" inBundle:[NSBundle ap_numberPadResourceBundle] compatibleWithTraitCollection:nil];
}

@end

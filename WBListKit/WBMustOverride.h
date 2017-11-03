//
//  WBMustOverride.h
//  Pods
//
//  Created by fangyuxi on 2017/6/6.
//
//

/**
 
 token from https://github.com/nicklockwood/MustOverride
 
 **/

#import <Foundation/Foundation.h>

/**
 * Include this macro inside any class or instance method that MUST be overridden
 * by its subclass(es). The app will then crash immediately on launch with an
 * assertion if the method is not overridden (even if it is never called).
 */
#define WB_SUBCLASS_MUST_OVERRIDE __attribute__((used, section("__DATA,MustOverride" \
))) static const char *__must_override_entry__ = __func__



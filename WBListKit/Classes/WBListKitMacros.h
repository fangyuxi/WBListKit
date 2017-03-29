//
//  WBListKitMacros.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//



#ifndef WBListKit_SUBCLASSING_RESTRICTED
#if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#define WBListKit_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
#endif
#endif

#ifndef WBListKit_UNAVAILABLE
#define WBListKit_UNAVAILABLE(message) __attribute__((unavailable(message)))
#endif

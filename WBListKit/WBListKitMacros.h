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

// We just forward primary call, in crash report, top most method in stack maybe WBLIST's,
// but it's really not our bug, you should check whether your table view's data source and
// displaying cells are not matched when reloading.

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wall"

static void __WBLIST_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(void (^callout)(void)) {
    callout();
}

#pragma clang diagnostic pop

#define WBLISTPrimaryCall(...) do {__WBLIST_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(^{__VA_ARGS__});} while(0)

//
//  WBListKitAssert.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#ifndef WBListKitAssert
#define WBListKitAssert( condition, ... ) NSCAssert( (condition) , ##__VA_ARGS__)
#endif // WBListKitAssert

#ifndef WBListKitParameterAssert
#define WBListKitParameterAssert( condition ) WBListKitAssert( (condition) , @"Invalid parameter not satisfying: %@", @#condition)
#endif // WBListKitParameterAssert

#ifndef WBListKitAssertMainThread
#define WBListKitAssertMainThread() WBListKitAssert( ([NSThread isMainThread] == YES), @"Must be on the main thread")
#endif // WBListKitAssertMainThread


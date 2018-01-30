//
//  ECMacro.h
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#ifndef ECMacro_h
#define ECMacro_h

#import <objc/runtime.h>

/*! runtime exchangeMethod */
#define EC_Objc_exchangeMethodAToB(originalSelector,swizzledSelector) { \
Class class = [self class]; \
Method originalMethod = class_getInstanceMethod(class, originalSelector); \
Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector); \
if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) { \
class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); \
} else { \
method_exchangeImplementations(originalMethod, swizzledMethod); \
} \
}

/*! runtime set */
#define EC_Objc_setObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

/*! runtime setCopy */
#define EC_Objc_setObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

/*! runtime get */
#define EC_Objc_getObj objc_getAssociatedObject(self, _cmd)

#endif /* ECMacro_h */

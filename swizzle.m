#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static Method method;
static IMP original;

__attribute__((constructor)) static void init(void) {
  Class class = objc_getClass("TargetType");
  if (class == nil) {
    return;
  }

  SEL selector = sel_registerName("targetMethod:");
  method = class_getInstanceMethod(class, selector);
  if (method == nil) {
    return;
  }

  IMP replacement = imp_implementationWithBlock(^{
    return YES;
  });
  original = method_setImplementation(method, replacement);
}

__attribute__((destructor)) static void fini(void) {
  if (method == nil || original == nil) {
    return;
  }

  IMP replacement = method_setImplementation(method, original);
  imp_removeBlock(replacement);
}

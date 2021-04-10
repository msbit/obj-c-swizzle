#import <Foundation/Foundation.h>

#include <dlfcn.h>

#import "TargetType.h"

void checkTargetMethod(TargetType *targetInstance) {
  BOOL result = [targetInstance targetMethod:nil];
  printf("targetMethod: %s\n", result ? "🎉" : "☠️");
}

int main(int argc, char **argv) {
  TargetType *targetInstance = [[TargetType alloc] init];

  checkTargetMethod(targetInstance);

  if (argc < 2) {
    return 0;
  }

  void *handle = dlopen(argv[1], RTLD_LAZY);
  if (handle == NULL) {
    printf("%s\n", dlerror());
    return -1;
  }

  checkTargetMethod(targetInstance);

  if (dlclose(handle) != 0) {
    printf("%s\n", dlerror());
    return -1;
  }

  checkTargetMethod(targetInstance);

  return 0;
}

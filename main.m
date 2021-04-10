#import <Foundation/Foundation.h>

#include <dlfcn.h>

@interface BIBuildInformation : NSObject
@end

@implementation BIBuildInformation
- (BOOL)isUpdateInstallable:(id)_ {
  return NO;
}
@end

void checkIsUpdateInstallable(BIBuildInformation *biBuildInformation) {
  BOOL result = [biBuildInformation isUpdateInstallable:nil];
  printf("isUpdateInstallable: %s\n", result ? "🎉" : "☠️");
}

int main(int argc, char **argv) {
  BIBuildInformation *biBuildInformation = [[BIBuildInformation alloc] init];

  checkIsUpdateInstallable(biBuildInformation);

  if (argc < 2) {
    return 0;
  }

  void *handle = dlopen(argv[1], RTLD_LAZY);
  if (handle == NULL) {
    printf("%s\n", dlerror());
    return -1;
  }

  checkIsUpdateInstallable(biBuildInformation);

  if (dlclose(handle) != 0) {
    printf("%s\n", dlerror());
    return -1;
  }

  checkIsUpdateInstallable(biBuildInformation);

  return 0;
}

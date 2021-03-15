#include <dlfcn.h>

__attribute__((constructor))
static void initializer(void) {
    dlopen("/usr/lib/ssh-keychain.dylib", RTLD_NOW | RTLD_GLOBAL);
}

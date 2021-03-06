// RUN: %clang_cc1 -fblocks -fobjc-arc -fobjc-runtime-has-weak -g -triple x86_64-apple-darwin -O0 -emit-llvm %s -o - | FileCheck %s

// rdar://problem/14386148
// Test that the foo is aligned at an 8 byte boundary in the DWARF
// expression (256) that locates it inside of the byref descriptor:
// CHECK: metadata !"foo", i32 0, i64 {{[0-9]+}}, i64 64, i64 256, i32 0, metadata

struct Foo {
  unsigned char *data;
};
int func() {
  __attribute__((__blocks__(byref))) struct Foo foo;
  return 0;
}

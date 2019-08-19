#include<iostream>
#include<caml/mlvalues.h>

extern "C" CAMLprim value hello(value unit) {
  std::cout << "Hello, world!" << std::endl;
  return Val_unit;
}

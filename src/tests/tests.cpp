#include "../headers/test.h"
#include "../cpptest/src/headers/cpptest.h"
#include <iostream>

#ifdef TEST
int main(int argc, char* argv[]) {
    TestManager manager;
    manager.NewTest("Test")->Run = []() {
        return true;
    };
    manager.RunAll();
}
#endif
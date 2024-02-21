#include "intro_lib.hpp"

namespace intro_lib {

[[nodiscard]] int factorial(int input) noexcept
{
    int result = 1;

    while (input > 0) {
        result *= input;
        --input;
    }

    return result;
}
}// namespace intro_lib

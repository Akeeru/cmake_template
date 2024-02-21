#ifndef __INTRO_LIB_HPP__
#define __INTRO_LIB_HPP__

namespace intro_lib {
[[nodiscard]] int factorial(int) noexcept;

[[nodiscard]] constexpr int factorial_constexpr(int input) noexcept
{
    if (input <= 0) { return 1; }

    return input * factorial_constexpr(input - 1);
}
}// namespace intro_lib

#endif//__INTRO_LIB_HPP__

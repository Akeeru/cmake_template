#include <intro_lib.hpp>
#include <iterator>
#include <span>
#include <spdlog/spdlog.h>


int main(int argc, const char **argv)
{
    auto args = std::span(argv, size_t(argc));

    spdlog::info("AL: {}\nArg[0]: {}", argc, args[0]);
    spdlog::info("intro_lib::factorial_constexpr(4): {}", intro_lib::factorial_constexpr(4));
    return 0;
}

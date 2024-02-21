#include <intro_lib.hpp>
#include <spdlog/spdlog.h>


int main(int argc, const char **argv)
{
    spdlog::info("AL: {}\nArg[0]: {}", argc, argv[0]);

    return 0;
}

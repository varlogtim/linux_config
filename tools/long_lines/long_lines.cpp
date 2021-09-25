#include <bits/stdc++.h>
#define DEFAULT_LINE_LENGTH 200

int main(int argc, char *argv[]) {
    uint32_t max_line_length = DEFAULT_LINE_LENGTH;
    if (argc == 2)
        max_line_length = atoi(argv[1]);
    if (max_line_length < 1) {
        std::cerr << "Max line length cannot be less than 1" << std::endl;
        exit(1);
    }

    for (std::string line; std::getline(std::cin, line);) {
        std::cout << line.substr(0, max_line_length) << std::endl;
        /* if (line.length() > max_line_length) */
        /*     std::cout << std::endl; */
    }
}

#ifndef MAIN_H
#define MAIN_H

// Declare function prototypes
int addd(int a, int b);
std::string calculate_sha256(const std::string& filename);
bool validate_sha256(const std::string& filename, const std::string& csv_path);
int main(int argc, char* argv[]);

#endif // MAIN_H


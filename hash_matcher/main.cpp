#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <iomanip>
#include <vector>
#include <cstdlib>

std::string calculate_sha256(const std::string& filename) {
    std::ifstream file(filename, std::ios::binary);

    //error handling for file under test
    if (!file.is_open()) {
        std::cerr << "Error opening file: " << filename << std::endl;
        return "";
    }
    if (file.fail() && !file.eof()) {
         std::cerr << "Error reading file: " << filename << std::endl;
        return "";
    }

    //prep sha256 check of specified file w/natives as 22.04's ssl versioning obfuscates sha.h
    std::string exec_path = "/usr/bin/sha256sum"; //
    std::string command = exec_path + " " + filename + "| awk '{print $1}' 2>&1";
    const char * cmd = command.c_str();
    std::string result = "";

    //run cmd and stuff cmd buffer into string
    char buffer[128];
    FILE* pipe = popen(cmd, "r");

    //alloc check
    if (!pipe) {
        return "Error: popen() failed!";
    }

    //collect string
    while (!feof(pipe)) {
        if (fgets(buffer, 128, pipe) != nullptr)
            result += buffer;
    }
    pclose(pipe);

    std::string sstring = result.substr(0, result.size()-1);;
    std::cout << "SHA256 calculated " << sstring << " for " << filename << std::endl;
    return sstring;
}


bool validate_sha256(const std::string& filename, const std::string& csv_path) {
    //call sha256 calculator with file under test
    std::string calculated_hash = calculate_sha256(filename);
        if (calculated_hash.empty()) {
        return false;
    }

    //open the designated .csv file
    std::ifstream csv_file(csv_path);
    if (!csv_file.is_open()) {
        std::cerr << "Error opening CSV file: " << csv_path << std::endl;
        return false;
    }

    //traverse the .csv for a matching file:hash
    std::string line;
    while (std::getline(csv_file, line)) {
        std::stringstream ss(line);
        std::string file_in_csv, hash_in_csv;

        if (std::getline(ss, file_in_csv, ',') && std::getline(ss, hash_in_csv)) {
             if (file_in_csv == filename && hash_in_csv == calculated_hash) {
                std::cout << "SHA256 validation successful for " << filename << std::endl;
                return true;
            }
        } else {
           std::cerr << "Incorrect format of line: " << line << " in " << csv_path << std::endl;
        }
    }

    std::cout << "SHA256 validation failed for " << filename << std::endl;
    std::cout << "SHA256 validation failed for " << filename << calculated_hash << std::endl;
    return false;
}

int main(int argc, char* argv[]) {
    //Detect and validate architecture
    #ifdef __aarch64__
        std::cerr << "ARM64 platform detected" << std::endl;
        //run actions for arch=aarch64
    #elif __x86_64__
        std::cerr << "x86_64 platform detected" << std::endl;
        //run unique actions for arch=x86_64
    #else
        std::cerr << "ERROR: Uknown architecture detected. Exiting now." << std::endl;
        //exit upon encountering unknown platform, return coded error.
        return 101;
    #endif

    //Run the utility
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <csv_path> <filename>" << std::endl;
        return 1;
    }

    std::string csv_path = argv[1];
    std::string filename = argv[2];

    if (!validate_sha256(filename, csv_path)) {
        return 1;
    }

    //exit gracefully
    return 0;
}


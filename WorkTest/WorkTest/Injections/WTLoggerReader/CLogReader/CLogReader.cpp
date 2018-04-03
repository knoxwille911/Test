//
//  CLogReader.cpp
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#include "CLogReader.hpp"

#include <string.h>
#include <stdlib.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>

static const char *kFilepath = "workTest.txt";
static const char *kDocuments = "/Documents/";

static const char kStarSymbol = '*';
static const char kQuestionSymbol = '?';

bool CLogReader::SetFilter(const char *filter) {
    // check lenght
    if (!strlen(filter)) {
        return false;
    }
    if (mFilter) {
        free(mFilter);
    }
    
    size_t len = strlen(filter);
    mFilter = (char*) malloc( len + 1 );
    strcpy(mFilter, filter);
    
    this->GetFilePath(filePath);
    std::remove(filePath);
    return true;
}


bool CLogReader::AddSourceBlock(const char *block, const size_t block_size) {
    //if oupput stream does not open - open him
    if (!this->fileWriteStream.is_open()) {
        this->fileWriteStream.open(filePath, std::ios::app);
    }
    this->fileWriteStream << block;
    this->fileWriteStream.close();
    return true;
}


bool CLogReader::GetNextLine(char *buf, const size_t buf_size) {
    //if input stream does not open - open him
    if (!this->fileReadStream.is_open()) {
        this->fileReadStream.open(filePath, std::ios::in);
    }
    if (this->fileReadStream.eof()) {
        return false;
    }
    this->fileReadStream.getline(buf, buf_size);
    
    if (strlen(buf)) {
        if (!isStringMatchToFilter(buf)) {
            buf = nullptr;
        }
        else {
            std::cout << buf << std::endl;
            return true;
        }
    }
    return false;
}


bool CLogReader::isStringMatchToFilter(const char *coreString) {
    size_t len = strlen(coreString);
    char *stringCopy = nullptr;
    stringCopy = static_cast<char *>(realloc(stringCopy, len + 1));
    strncpy(stringCopy, coreString, len);
    
//    char *string = stringCopy;
//    free(string);
    const char *string = "anton";
    char src;
    char fil;
    char lastFilterSymbol;
    len = strlen(mFilter);
    char *filterCopy= (char*) malloc( len + 1 );
    strcpy(filterCopy, mFilter);
    
    char *filter = filterCopy;
    
    //prematch

    while (*string && *filter != kStarSymbol) {
        if (!this->isCharsEqual(*string, *filter)) {
            return false;
        }
        string++;
        filter++;
    }
    while (*string) {
        src = *string;
        fil = *filter;
        

        if (fil == kStarSymbol) {
            if (*++filter == '\0') {
                return true;
            }
            lastFilterSymbol = *filter;
            string++;
            continue;
        }
        if (this->isCharsEqual(src, fil)) {
            string++;
            filter++;
        }
        else {
            string++;
        }
    }
    bool result = strlen(filter) ? false : true;
    
    free(filterCopy);
    free(stringCopy);
    return result;
}


bool CLogReader::isCharsEqual(char a, char b) {
    bool result = (a == b || b == kQuestionSymbol);
    return result;
}


void CLogReader::GetFilePath(char *path) {
    char buffer[256];
    strcpy(buffer,getenv("HOME"));
    strcat(buffer, kDocuments);
    strcat(buffer, kFilepath);
    strcpy(path, buffer);
}

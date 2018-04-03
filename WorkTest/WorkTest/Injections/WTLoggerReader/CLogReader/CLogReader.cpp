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
        if (!this->isStringMathWithFilter(buf)) {
            buf = nullptr;
        }
        else {
            std::cout << buf << std::endl;
            return true;
        }
    }
    return false;
}


bool CLogReader::isStringMathWithFilter(const char *coreString) {
    const char *stringCopy = coreString;
    char *filterCopy = mFilter;
    char lastFilterSymbol;

    //prematch
    while (*coreString && *this->mFilter != kStarSymbol) {
        if (!this->isCharsEqual(*coreString, *this->mFilter)) {
            this->mFilter = filterCopy;
            return false;
        }
        coreString++;
        mFilter++;
    }
    while (*coreString) {
        if (*mFilter == kStarSymbol) {
            if (*++mFilter == '\0') {
                this->mFilter = filterCopy;
                return true;
            }
            lastFilterSymbol = *this->mFilter;
            coreString++;
            continue;
        }
        if (this->isCharsEqual(*coreString, *this->mFilter)) {
            coreString++;
            this->mFilter++;
        }
        else {
            this->mFilter = filterCopy;
            coreString++;
        }
    }
    bool result = strlen(this->mFilter) ? false : true;

    coreString = stringCopy;
    this->mFilter = filterCopy;
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

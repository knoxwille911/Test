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

static const char *kStarSymbol = "*";
static const char *kQuestionSymbol = "?";

bool CLogReader::SetFilter(const char *filter) {
    // check lenght
    if (!strlen(filter)) {
        return false;
    }
    this->mFilter = filter;
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
    char tempBuf[buf_size];
    
    //read next line
    this->fileReadStream.getline(tempBuf, buf_size);
    
    if (isStringMatchToFilter(tempBuf)) {
        buf = tempBuf;
    }
    
    std::cout << tempBuf << std::endl;
    
    return true;
}


bool CLogReader::isStringMatchToFilter(const char *string) {
    
    while (*string) {
        while (*mFilter) {
            if (mFilter != string) {
                break;
            }
            mFilter++;
        }
        string++;
    }
    return true;
}


void CLogReader::GetFilePath(char *path) {
    char buffer[256];
    strcpy(buffer,getenv("HOME"));
    strcat(buffer, kDocuments);
    strcat(buffer, kFilepath);
    strcpy(path, buffer);
}

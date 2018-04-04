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
//    if (mFilter) {
//        free(mFilter);
//    }
    
    size_t len = strlen(filter);
    mFilter = (char*) malloc( len + 1 );
    strcpy(mFilter, filter);
    
    this->fileWriteStream.close();
    this->fileReadStream.close();
    
    this->GetFilePath(filePath);
    std::remove(filePath);
    return true;
}


bool CLogReader::AddSourceBlock(const char *block, const size_t block_size) {
    //if oupput stream does not open - open him
    //we need to save data to file because txt file can be huge
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
//        this->fileReadStream.ignore(buf_size, '\r');
    }
    if (this->fileReadStream.eof()) {
        //file is ended
        return false;
    }
    
    this->fileReadStream.getline(buf, buf_size);
    this->fileReadStream.clear();
    if (strlen(buf)) {
        if (!this->isStringMathWithFilter(buf)) {
            //just to mark that is not our string
            buf[0] = '\0';
        }
        else {
            std::cout << "matching:" << std::endl;
            std::cout << buf << std::endl;
        }
    }
    return true;
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
//            coreString++;
            continue;
        }
        else if (this->isCharsEqual(*coreString, *this->mFilter)) {
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
    size_t len = strlen(getenv("HOME"));
    this->filePath =  (char*) malloc( len + strlen(kDocuments) + strlen(kFilepath) + 1);
    
    strcpy(this->filePath,getenv("HOME"));
    strcat(this->filePath, kDocuments);
    strcat(this->filePath, kFilepath);
}

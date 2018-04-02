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
    
    size_t len = strlen(filter);
    mFilter = (char*) malloc( len + 1 );
    strcpy(mFilter, filter);
    
    this->setFilterType();
    
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
    
    bool result = false;
    
    size_t len = strlen(coreString);
    char *string= (char*) malloc( len + 1 );
    strcpy(string, coreString);

//    const char *string = "anton anton anton"; 
    char src = *string;
    
    while (*string) {
        //get next char from source string
        src = *string;
        
        //copy filter string
        len = strlen(mFilter);
        char *filter= (char*) malloc( len + 1 );
        strcpy(filter, mFilter);
        
        while (*filter) {
            
            //get next filter char
            char fil = *filter;
            src = *string;
            
            //if filter start from * continue
            if (fil == kStarSymbol || fil == kQuestionSymbol) {
                if (src == '\0') { //end string, means that after searched string 0, not * or ?, so this not our string
                    result = false;
                }
                filter++;
                continue;
            }
            
            if (fil == kQuestionSymbol) {
                
            }
            //if characters is not equal  stop cirkle
            if (!this->isCharsEqual(src, fil)) {
                result = false;
                break;
            }
            // if we here continue search by filter in source
            filter++;
            string++;
            result = true;
        }
        if (result) {
            break;
        }
        string++;
    }
    return result;
}


bool CLogReader::isCharsEqual(char a, char b) {
    bool result = a == b;
    return result;
}


void CLogReader::GetFilePath(char *path) {
    char buffer[256];
    strcpy(buffer,getenv("HOME"));
    strcat(buffer, kDocuments);
    strcat(buffer, kFilepath);
    strcpy(path, buffer);
}

//enum class matchFilterType : int
//{
//    matchfilterTypeNone,
//    matchfilterTypeStarInStart,
//    matchfilterTypeStarInEnd,
//    matchfilterTypeStatInBoth,
//    matchfilterTypeQuestInStart,
//    matchfilterTypeQuestInEnd,
//    matchfilterTypeQuestInBoth,
//    matchfilterTypeSimpleMatch
//};
void CLogReader::setFilterType() {
//    while (*mFilter) {
//        char currentSymbol = *mFilter;
//        if (filterType == matchFilterType::matchfilterTypeNone) {
//            if (currentSymbol == kStarSymbol) {
//                filterType = matchFilterType::matchfilterTypeStarInStart;
//            }
//            else if (currentSymbol == kQuestionSymbol) {
//                filterType = matchFilterType::matchfilterTypeQuestInStart;
//            }
//            else {
//                filterType = matchFilterType::matchfilterTypeSimpleMatch;
//            }
//        }
//        else {
//            if (filterType == matchFilterType::matchfilterTypeStarInStart) {
//                filterType = matchFilterType::matchfilterTypeStatInBoth;
//            }
//            else if (filterType == matchFilterType::matchfilterTypeQuestInStart) {
//                filterType = matchFilterType::matchfilterTypeQuestInBoth;
//            }
//        }
//        mFilter++;
//    }
}

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

bool CLogReader::SetFilter(const char *filter) {
    this->mFilter = filter;
    return true;
}


bool CLogReader::AddSourceBlock(const char *block, const size_t block_size) {

    std::remove(this->GetFilePath());
    this->fileWriteStream.open(this->GetFilePath(), std::ios::app);
    if (this->fileWriteStream.is_open()) {
        this->fileWriteStream << block;
        this->fileWriteStream.close();
    }
    else {
        this->fileWriteStream << block;
        this->fileWriteStream.close();
    }
    return true;
}


bool CLogReader::GetNextLine(char *buf, const size_t buf_size) {
    if (this->fileReadStream.is_open()) {
        
    }
    else {
        this->fileReadStream.open(kFilepath);
        if (!this->fileReadStream) {
            
        }
        else {
            while(!this->fileReadStream.eof())
            {
                char *line;
                
                this->fileReadStream.getline(buf, buf_size);
                
                char * buffer = new char [buf_size];
                this->fileReadStream.read(buffer, buf_size);
                std::cout << buffer << std::endl;
            }
        }
    }
    return true;
}

const char *CLogReader::GetFilePath() {
    char * home = getenv("HOME");
    char * result = new char(strlen(home));
    strcpy(result, home);
    
    strcat(result,kDocuments);
    strcat(result,kFilepath);
    

    return result;
}

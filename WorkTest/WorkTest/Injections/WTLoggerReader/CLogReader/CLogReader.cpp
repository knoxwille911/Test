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

bool CLogReader::SetFilter(const char *filter) {
    this->mFilter = filter;
    return true;
}


bool CLogReader::AddSourceBlock(const char *block, const size_t block_size) {
    return true;
}


bool CLogReader::GetNextLine(char *buf, const size_t buf_size) {
    return true;
}


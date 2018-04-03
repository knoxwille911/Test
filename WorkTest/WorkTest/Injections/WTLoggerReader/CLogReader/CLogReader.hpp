//
//  CLogReader.hpp
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#ifndef CLogReader_hpp
#define CLogReader_hpp

#include <stdio.h>
#include <fstream>
#include <iostream>
#include <fstream>

using namespace std;

class CLogReader
{
public:
//    CLogReader(...);
//    ~CLogReader(...);
    
    bool    SetFilter(const char *filter);   // установка фильтра строк, false - ошибка
    bool    AddSourceBlock(const char* block,const size_t block_size); // добавление очередного блока текстового файла
    bool    GetNextLine(char *buf,           // запрос очередной найденной строки,
                        const size_t buf_size);  // buf - буфер, bufsize - максимальная длина
    // false - конец файла или ошибка
private:
    
    bool isStringMatchToFilter(const char *string);
    bool isCharsEqual(char a, char b);
    void setFilterType();
    
    char* mFilter;
    ofstream fileWriteStream;
    ifstream fileReadStream;
    void GetFilePath(char *path);
    char filePath[256];
};

#endif /* CLogReader_hpp */

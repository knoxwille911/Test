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

class CLogReader
{
public:
    CLogReader(...);
//    ~CLogReader(...);
    
    bool    SetFilter(const char *filter);   // установка фильтра строк, false - ошибка
    bool    AddSourceBlock(const char* block,const size_t block_size); // добавление очередного блока текстового файла
    bool    GetNextLine(char *buf,           // запрос очередной найденной строки,
                        const size_t buf_size);  // buf - буфер, bufsize - максимальная длина
    // false - конец файла или ошибка
private:
    const char* mFilter;
};

#endif /* CLogReader_hpp */

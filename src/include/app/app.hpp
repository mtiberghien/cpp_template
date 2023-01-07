#pragma once
#include "common.hpp"

class app
{
    public:
        app(){this->init();}
        ~app(){this->clean();}
        void run();
    private:
        void init();
        void clean();
        void exit();
};
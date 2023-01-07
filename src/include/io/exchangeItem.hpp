#pragma once
#include "common.hpp"
#include <vector>
#include <map>

class ExchangeItem
{
    public:
        ExchangeItem(){};
        ExchangeItem(vector<string> properties);
        void setProperties(vector<string> properties);
        string& operator[](string key);
    private:
        map<string,string> data;
        vector<string> properties;
};
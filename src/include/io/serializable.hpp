#pragma once
#include "common.hpp"
#include "exchangeItem.hpp"
#include <vector>

class Serializable
{
    public:
        virtual vector<string> getProperties()=0;
        virtual ExchangeItem to_exchangeItem()=0;
        virtual void from_exchangeItem(ExchangeItem& item)=0;
};
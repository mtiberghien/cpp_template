#include "exchangeItem.hpp"

ExchangeItem::ExchangeItem(vector<string> properties)
{
    this->setProperties(properties);
}

void ExchangeItem::setProperties(vector<string> properties)
{
    this->properties.clear();
    map<string,string> temp = this->data;
    this->data.clear();
    for(string p : properties)
    {
        this->properties.push_back(p);
        if(temp.find(p) != temp.end())
        {
            this->data[p] = temp[p];
        }
        else
        {
            this->data[p] = string("");
        }
        
    }
}

string& ExchangeItem::operator[](string key)
{
    if(this->data.find(key) != this->data.end())
    {
        return this->data[key];
    }
    throw out_of_range("La clé n'existe pas");
}
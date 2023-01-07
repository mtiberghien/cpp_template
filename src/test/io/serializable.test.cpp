#include "serializable.hpp"
#include "up11.h"

class S: public Serializable
{
    public:
        S(string nom, string prenom):nom(nom),prenom(prenom){};
        vector<string> getProperties() override
        {
            return {"Nom","Prenom"};
        }
        ExchangeItem to_exchangeItem() override
        {
            ExchangeItem e(this->getProperties());
            e["Nom"]=this->nom;
            e["Prenom"]=this->prenom;
            return e;
        }
        void from_exchangeItem(ExchangeItem& item) override
        {
            this->nom = item["Nom"];
            this->prenom = item["Prenom"];
        }
        string getPrenom(){return this->prenom;}
        string getNom(){return this->nom;}
    private:
        string nom;
        string prenom;
};

UP_SUITE_BEGIN(serializable);


UP_TEST(implementation)
{
    
    S s("Tiberghien","Mathias");
    ExchangeItem e = s.to_exchangeItem();
    UP_ASSERT_EQUAL("Tiberghien", e["Nom"]);
    UP_ASSERT_EQUAL("Mathias", e["Prenom"]);
    e["Prenom"]="Thomas";
    s.from_exchangeItem(e);
    UP_ASSERT_EQUAL("Thomas", s.getPrenom());
    UP_ASSERT_EQUAL("Tiberghien", s.getNom());
}



UP_SUITE_END();
#include "app.hpp"

void app::init()
{
    cout << "Initialisation du programme" << endl;
}

void app::run()
{
    cout << "Lancement du programme" << endl;
    this->exit();
}

void app::clean()
{
    cout << "Clean du programme" << endl;
}

void app::exit()
{
    cout << "Sortie  du programme" << endl;
}
#include <log.hpp>

enum plog::Severity filter_from_string(string filter)
{
    if(filter.empty())
    {
        return plog::info;
    }
    if(filter.compare("verbose") == 0)
    {
        return plog::verbose;
    }
    if(filter.compare("debug") == 0)
    {
        return plog::debug;
    }
    if(filter.compare("info") == 0)
    {
        return plog::info;
    }
    if(filter.compare("warning") == 0)
    {
        return plog::warning;
    }
    if(filter.compare("error") == 0)
    {
        return plog::error;
    }
    if(filter.compare("fatal") == 0)
    {
        return plog::fatal;
    }

    return plog::info;
}

void init_logs(string filter)
{
    plog::init(filter_from_string(filter), &consoleAppender).addAppender(&fileAppender);
}
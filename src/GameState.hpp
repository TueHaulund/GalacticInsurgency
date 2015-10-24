#ifndef GAMESTATE_HPP
#define GAMESTATE_HPP

#include <string>
#include <stdexcept>
#include <memory>
#include <fstream>
#include <sstream>

#include <selene.h>

#include "Resource.hpp"

class GameState
{
    public:
        GameState(const std::string &p_lua_path, bool p_libs = true);
        void Update(float p_dt);
        void Draw();

    private:
        static std::unique_ptr<std::string> LoadScript(const std::string &p_path);
        sel::State m_lua_state;
};

#endif

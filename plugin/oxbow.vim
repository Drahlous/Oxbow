" Title:        Oxbow
" Description:  A plugin for navigating meandering codebases.
" Last Change:  3 August 2023
" Maintainer:   Drahlous <https://github.com/Drahlous>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_oxbow")
    finish
endif
let g:loaded_oxbow = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/oxbow/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 OxbowFile lua require("oxbow").run_file()
command! -nargs=0 OxbowFunction lua require("oxbow").run_function()

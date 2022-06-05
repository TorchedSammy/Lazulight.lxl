-- mod-version:2
local core = require 'core'

local function localPath()
   local str = debug.getinfo(2, 'S').source:sub(2)
   return str:match('(.*[/\\])')
end

local langPath = localPath() .. 'langs' .. PATHSEP
local langs = system.list_dir(langPath)
for _, lang in ipairs(langs) do
	dofile(langPath .. lang)
end

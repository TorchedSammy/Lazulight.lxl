-- mod-version:3
local syntax = require "core.syntax"

syntax.add {
  name = "Lua",
  files = "%.lua$",
  headers = "^#!.*[ /]lua",
  comment = "--",
  block_comment = { "--[[", "]]" },
  patterns = {
    { pattern = { '"', '"', '\\' },          type = "string" },
    { pattern = { "'", "'", '\\' },          type = "string" },
    { pattern = { "%[%[", "%]%]" },          type = "string" },
    { pattern = { "%-%-%[%[", "%]%]"},       type = "comment" },
    { pattern = "%-%-.-\n",                  type = "comment" },
    { pattern = "0x%x+%.%x*[pP][-+]?%d+",    type = "number" },
    { pattern = "0x%x+%.%x*",                type = "number" },
    { pattern = "0x%.%x+[pP][-+]?%d+",       type = "number" },
    { pattern = "0x%.%x+",                   type = "number" },
    { pattern = "0x%x+[pP][-+]?%d+",         type = "number" },
    { pattern = "0x%x+",                     type = "number" },
    { pattern = "%d%.%d*[eE][-+]?%d+",       type = "number" },
    { pattern = "%d%.%d*",                   type = "number" },
    { pattern = "%.?%d*[eE][-+]?%d+",        type = "number" },
    { pattern = "%.?%d+",                    type = "number" },
    { pattern = "<%a+>",                     type = "keyword2" },
    -- variadic; treat as a parameter
    { pattern = "%.%.%.",                    type = "parameter" },
    { pattern = "%.%.",                      type = "operator" },
    { pattern = "[<>~=]=",                   type = "operator" },
    { pattern = "[%+%-=/%*%^%%#<>]",         type = "operator" },
    -- Function calls
    { pattern = "[%a_][%w_]+()%s*%f[(\"'{]", type = {"function", "normal"} },
    { pattern = "[%a_][%w_%.]+()%.()[%a_][%w_]+()%s*%f[(\"'{]",
      type = { "normal", "normal", "function", "normal"} },
    { regex = {"(?=(?:local)?\\s*function\\s*(?:[a-zA-Z_][a-zA-Z0-9_.]*\\s*)?\\()", "\\)"},
      type = "normal",
      syntax = {
        patterns = {
          { pattern = "[%a_][%w_]*%s*(),%s*",
            type = {"parameter", "normal"}
          },
          { pattern = "[%a_][%w_]*%s*%f[)]",
            type = "parameter"
          },
          { pattern = "[%a_][%w_]*()%s*%f[(]",
            type = {"function", "normal"}
          },
          { pattern = "%.()[%a_][%w_]*()%s*%f[(]",
            type = {"normal", "function", "normal"}
          },
          { pattern = "%.()[%a_][%w_]*",
            type = {"normal", "field"}
          },
          { pattern = "[%a_][%w_]*%f[.]",
            type = "variable"
          },
          { pattern = "[%a_][%w_]*",
            type = "variable"
          }
        },
        symbols = {
          ["local"] = "keyword",
          ["function"] = "keyword"
        }
      }
    },
    -- function declarations to prevent matching as variables
    { pattern = "local()%s+()function()%s+()[%a_][%w_]*()%(",
      type = { "keyword", "normal", "keyword", "normal", "function", "normal" }
    },
    { pattern = "local()%s+()function",
      type = { "keyword", "normal", "keyword" }
    },
    -- Placeholder
    { pattern = "_(),",
      type = { "constant", "normal" }
    },
    -- Uppercase constants of at least 2 chars in len
    {
        pattern = "%u[%u_][%u%d_]*%f[%s%+%*%-%.%(%)%?%^%%=/<>~|&:,~]",
        type = "constant"
    },
    -- Sub fields
    { pattern = "%.()[%a_][%w_]*",
      type = { "normal", "field" }
    },
    -- Variable declarations and assignments
    { pattern = {"local", "[=\n]"},
      syntax = {
        patterns = {
          {
            pattern = "[%a_][%w_]*()%s*,?%s*",
            type = {"variable", "normal"}
          }
        },
        symbols = {}
      },
      type = "operator"
    },
    { regex = {"(?=(?:(?:[a-zA-Z_][\\w.\\[\\]\\\"\\']*\\s*,\\s*)*(?:[a-zA-Z_][\\w.\\[\\]\\\"\\']*\\s*=.*))|(?:local))", "(?==|\n)"},
      syntax = {
        patterns = {
          { pattern = { '"', '"', '\\' },          type = "string" },
          { pattern = { "'", "'", '\\' },          type = "string" },
          -- Sub fields
          { pattern = "%.()[%a_][%w_]*",
            type = { "normal", "field" }
          },
          {
            pattern = "[%a_][%w_]*()[ \t]*,?",
            type = {"variable", "normal"}
          },
          {
            pattern = "[%a_][%w_]*",
            type = "normal"
          }
        },
        symbols = {
          ["local"] = "keyword"
        }
      },
      type = "normal"
    },
    -- Labels
    { pattern = "::[%a_][%w_]*::",           type = "function" },
    -- Other text
    { pattern = "[%a_][%w_]*",               type = "normal" },
  },
symbols = {
    -- builtin functions
    ["assert"]          = "function_builtin",
    ["collectgarbage"]  = "function_builtin",
    ["dofile"]          = "function_builtin",
    ["error"]           = "function_builtin",
    ["getfenv"]         = "function_builtin",
    ["getmetatable"]    = "function_builtin",
    ["ipairs"]          = "function_builtin",
    ["load"]            = "function_builtin",
    ["loadfile"]        = "function_builtin",
    ["loadstring"]      = "function_builtin",
    ["module"]          = "function_builtin",
    ["next"]            = "function_builtin",
    ["pairs"]           = "function_builtin",
    ["pcall"]           = "function_builtin",
    ["print"]           = "function_builtin",
    ["rawequal"]        = "function_builtin",
    ["rawget"]          = "function_builtin",
    ["rawset"]          = "function_builtin",
    ["require"]         = "function_builtin",
    ["select"]          = "function_builtin",
    ["setfenv"]         = "function_builtin",
    ["setmetatable"]    = "function_builtin",
    ["tonumber"]        = "function_builtin",
    ["tostring"]        = "function_builtin",
    ["type"]            = "function_builtin",
    ["unpack"]          = "function_builtin",
    ["xpcall"]          = "function_builtin",
    -- keywords: conditional
    ["then"]     = "conditional",
    ["and"]      = "conditional",
    ["not"]      = "conditional",
    ["or"]       = "conditional",
    -- todo: conditional in right contexts
    ["elseif"]   = "keyword",
    ["else"]     = "keyword",
    ["if"]       = "keyword",
    ["end"]      = "keyword",
    -- todo ^^^ ---------------------- ^^^
    ["do"]       = "keyword",
    ["function"] = "keyword",
    ["repeat"]   = "keyword",
    ["until"]    = "keyword",
    ["while"]    = "keyword",
    ["for"]      = "keyword",
    ["break"]    = "keyword",
    ["return"]   = "keyword",
    ["local"]    = "keyword",
    ["in"]       = "keyword",
    ["goto"]     = "keyword",
    ["true"]     = "literal",
    ["false"]    = "literal",
    -- builtin constants
    ["nil"]      = "constant",
    -- builtin variables
    ["self"]     = "variable_builtin",
    ["_G"]       = "variable_builtin",
  },
}

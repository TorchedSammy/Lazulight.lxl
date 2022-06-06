-- mod-version:3
local syntax = require "core.syntax"

syntax.add {
  name = "Go",
  files = { "%.go$" },
  comment = "//",
  block_comment = {"/*", "*/"},
  patterns = {
    { pattern = "//.-\n",               type = "comment"  },
    { pattern = { "/%*", "%*/" },       type = "comment"  },
    { pattern = { '"', '"', '\\' },     type = "string"   },
    { pattern = { "`", "`", '\\' },     type = "string"   },
    { pattern = { "'", "'", '\\' },     type = "string"   },
    { pattern = "0[oO_][0-7]+",         type = "number"   },
    { pattern = "-?0x[%x_]+",           type = "number"   },
    { pattern = "-?%d+_%d",             type = "number"   },
    { pattern = "-?%d+[%d%.eE]*f?",     type = "number"   },
    { pattern = "-?%.?%d+f?",           type = "number"   },
    -- goto label
    { pattern = "^%s+()[%a_][%w%_]*()%s*:%s$", -- this is to fix `default:`
      type = { "normal", "function", "normal" }
    },
    { pattern = "^%s*[%a_][%w%_]*()%s*:%s$",
      type = { "function", "normal" }
    },
    -- slice type
    { pattern = "%[%]()[%a_][%w%_]*",
      type = { "normal", "type" }
    },
    -- type coerce
    {
      pattern = "%.%(()[%a_][%w_]*()%)",
      type = { "normal", "type", "normal" }
    },
    -- struct literal
    { pattern = "[%a_][%w%_]*()%s*{%s*",
      type = { "type", "normal" }
    },
    -- operators
    { pattern = "[%+%-=/%*%^%%<>!~|&]", type = "operator" },
    { pattern = ":=",                   type = "operator" },
    -- variadic; treat as a parameter
    { pattern = "%.%.%.",               type = "parameter" },
    -- function calls
    { pattern = "[%a_][%w_]*%f[(]",     type = "function" },
    { pattern = "%.()[%a_][%w_]*%f[(]",
      type = { "normal", "function" }
    },
    -- type declaration
    { pattern = "type()%s+()[%a_][%w%_]*",
      type = { "keyword", "normal", "type" }
    },
    -- constants
    { pattern = "const()%s+()[%a_][%w%_]*",
      type = { "keyword", "normal", "constant" }
    },
    -- variable declaration
    { pattern = "var()%s+()[%a_][%w%_]*",
      type = { "keyword", "normal", "symbol" }
    },
    -- goto
    { pattern = "goto()%s+()[%a_][%w%_]*",
      type = { "keyword", "normal", "function" }
    },
    -- if fix
    { pattern = "if()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- for fix
    { pattern = "for()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- return fix
    { pattern = "return()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- range fix
    { pattern = "range()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- func fix
    { pattern = "func()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- switch fix
    { pattern = "switch()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- case fix
    { pattern = "case()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- break fix
    { pattern = "break()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- continue fix
    { pattern = "continue()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- package fix
    { pattern = "package()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- go fix
    { pattern = "go()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- chan fix
    { pattern = "chan()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- defer fix
    { pattern = "defer()%s+%f[%a_]",
      type = { "keyword", "normal" }
    },
    -- field declaration
    { pattern = "[%a_][%w%_]*()%s*():%s*%f[%w%p]",
      type = { "field", "normal", "operator" }
    },
    -- parameters or declarations
    { pattern = "[%a_][%w%_]*()%s+()[%*~&]?()[%a_][%w%_]*",
      type = { "parameter", "normal", "operator", "type" }
    },
    { pattern = "[%a_][%w_]*()%s+()%[%]()[%a_][%w%_]*",
      type = { "parameter", "normal", "normal", "type" }
    },
    -- single return type
    {
      pattern = "%)%s+%(?()[%a_][%w%_]*()%)?%s+%{",
      type = { "normal", "type", "normal" }
    },
    -- sub fields
    { pattern = "%.()[%a_][%w_]*",
      type = { "normal", "field" }
    },
    -- every other symbol
    { pattern = "[%a_][%w_]*",          type = "symbol"   },
  },
  symbols = {
    -- builtin functions
    ["append"]      = "function_builtin",
    ["cap"]         = "function_builtin",
    ["close"]       = "function_builtin",
    ["complex"]     = "function_builtin",
    ["copy"]        = "function_builtin",
    ["delete"]      = "function_builtin",
    ["imag"]        = "function_builtin",
    ["len"]         = "function_builtin",
    ["make"]        = "function_builtin",
    ["new"]         = "function_builtin",
    ["panic"]       = "function_builtin",
    ["print"]       = "function_builtin",
    ["println"]     = "function_builtin",
    ["real"]        = "function_builtin",
    ["recover"]     = "function_builtin",
    -- keywords: conditional
    ["if"]          = "conditional",
    ["else"]        = "conditional",
    ["elseif"]      = "conditional",
    ["switch"]      = "conditional",
    -- keywords: others
    ["for"]         = "keyword",
    ["continue"]    = "keyword",
    ["return"]      = "keyword",
    ["struct"]      = "keyword",
    ["case"]        = "keyword",
    ["default"]     = "keyword",
    ["const"]       = "keyword",
    ["package"]     = "keyword",
    ["import"]      = "keyword",
    ["func"]        = "keyword",
    ["var"]         = "keyword",
    ["type"]        = "keyword",
    ["interface"]   = "keyword",
    ["select"]      = "keyword",
    ["break"]       = "keyword",
    ["range"]       = "keyword",
    ["chan"]        = "keyword",
    ["defer"]       = "keyword",
    ["go"]          = "keyword",
    ["fallthrough"] = "keyword",
    ["goto"]        = "keyword",
    -- types
    ["map"]         = "keyword", -- map is an exception; use keyword on it
    ["int"]         = "type_builtin",
    ["int64"]       = "type_builtin",
    ["int32"]       = "type_builtin",
    ["int16"]       = "type_builtin",
    ["int8"]        = "type_builtin",
    ["uint"]        = "type_builtin",
    ["uint64"]      = "type_builtin",
    ["uint32"]      = "type_builtin",
    ["uint16"]      = "type_builtin",
    ["uint8"]       = "type_builtin",
    ["uintptr"]     = "type_builtin",
    ["float64"]     = "type_builtin",
    ["float32"]     = "type_builtin",
    ["string"]      = "type_builtin",
    ["rune"]        = "type_builtin",
    ["bool"]        = "type_builtin",
    ["byte"]        = "type_builtin",
    ["error"]       = "type_builtin",
    ["complex64"]   = "type_builtin",
    ["complex128"]  = "type_builtin",
    ["true"]        = "literal",
    ["false"]       = "literal",
    -- builtin constants
    ["nil"]         = "constant",
    ["_"]           = "constant",
   },
}


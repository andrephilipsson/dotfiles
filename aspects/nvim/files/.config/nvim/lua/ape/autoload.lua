-- Provides a lazy autoload mechanism similar to Vimscript's autoload mechanism.
--
-- Examples:
--
--    " Vimscript - looks for function named `ape#foo#bar#baz()` in
--    " autoload/ape/foo/bar.vim):
--
--    call ape#foo#bar#baz()
--
--    -- Lua - lazy-loads these files in sequence before calling
--    -- `ape.foo.bar.baz()`:
--    --
--    --    1. lua/ape/foo.lua (or lua/ape/foo/init.lua)
--    --    2. lua/ape/foo/bar.lua (or lua/ape/foo/bar/init.lua)
--    --    3. lua/ape/foo/bar/baz.lua (or lua/ape/foo/bar/baz/init.lua)
--
--    local ape = require'ape'
--    ape.foo.bar.baz()
--
--    -- Note that because `require'ape'` appears at the top of the top-level
--    -- init.lua, the previous example can be written as:
--
--    ape.foo.bar.baz()
--
local autoload = function(base)
  local storage = {}
  local mt = {
    __index = function(_, key)
      if storage[key] == nil then
        storage[key] = require(base .. '.' .. key)
      end
      return storage[key]
    end,
  }

  return setmetatable({}, mt)
end

return autoload

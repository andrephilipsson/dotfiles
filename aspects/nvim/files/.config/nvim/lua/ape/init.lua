local autoload = require('ape.autoload')

local ape = autoload('ape')

-- Using a real global here to make sure anything stashed in here (and
-- in `ape.g`) survives even after the last reference to it goes away.
_G.ape = ape

return ape

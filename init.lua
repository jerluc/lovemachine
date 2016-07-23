-- The external lovemachine API
local M = require('lovemachine.machine')
M.debug = require('lovemachine.debug')
M.scene = require('lovemachine.scene')
M.state = require('lovemachine.state')

-- Actually binds LOVE handlers to lovemachine
-- TODO: Is there any more standard place to put this?
M._bindToLOVE()

return M

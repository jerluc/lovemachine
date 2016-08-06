-- The external lovemachine API
local M = require('lovemachine.machine')
M.debug = require('lovemachine.debug')
M.scene = require('lovemachine.scene')
M.animation = require('lovemachine.animation')
M.state = require('lovemachine.state')
M.run = M._bindToLOVE
return M

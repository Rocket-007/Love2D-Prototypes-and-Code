-- mocks for LÖVE functions
local Quadmt = {
  __eq = function(a,b)
    if #a ~= #b then return false end
    for i,v in ipairs(a) do
      if b[i] ~= v then return false end
    end
    return true
  end,
  __tostring = function(self)
    local buffer = {}
    for i,v in ipairs(self) do
      buffer[i] = tostring(v)
    end
    return "quad: {" .. table.concat(buffer, ",") .. "}"
  end
}

local lastDrawq = nil

love = {
  graphics = {
    newQuad = function(...)
      return setmetatable({...}, Quadmt)
    end,
    drawq = function(...)
      lastDrawq = {...}
    end,
    getLastDrawq = function()
      return lastDrawq
    end

  }
}

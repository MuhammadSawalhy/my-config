local mRandom = math.random
local tableUtils = {}

function tableUtils.shuffle(t)
  local n = #t
  while n > 2 do
    -- n is now the last pertinent index
    local k = mRandom(1, n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
end

function tableUtils.deepcopy(t)
  if type(t) ~= 'table' then return t end
  local mt = getmetatable(t)
  local res = {}
  for k,v in pairs(t) do
    if type(v) == 'table' then
      v = tableUtils.deepcopy(v)
    end
    res[k] = v
  end
  setmetatable(res,mt)
  return res
end

function tableUtils.combine(...)
  local combinedTable = {}
  local arg = {...}

  for _, v in pairs(arg) do
    if type(v) == 'table' then
      for tkey, tvalue in pairs(v) do
        combinedTable[tkey] = tvalue
      end
    end
  end
  return combinedTable
end

function tableUtils.indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function tableUtils.removeByRef(t, obj)
    tableUtils.remove(t, tableUtils.indexOf(t, obj))
end

return tableUtils

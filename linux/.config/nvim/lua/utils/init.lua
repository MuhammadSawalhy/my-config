-- some of the code came from: https://gist.github.com/Lerg/8791431
-- ----------------------------------------------------------------

require "utils.table"

Utils = {
  get_visual_selection_text = require "utils.get_visual_selection",
}

local tInsert = table.insert
local app = require('lib.app')

function string.trim(s)
  local from = s:match"^%s*()"
  return from > #s and "" or s:match(".*%S", from)
end

function string.startswith(s, piece)
  return string.sub(s, 1, string.len(piece)) == piece
end

function string.endswith(s, send)
  return #s >= #send and s:find(send, #s-#send+1, true) and true or false
end

function string.split(p,d)
  local t, ll, l
  t={}
  ll=0
  if(#p == 1) then return {p} end
  while true do
    l=string.find(p,d,ll,true) -- find the next d in the string
    if l~=nil then -- if "not not" found then..
      tInsert(t, string.sub(p,ll,l-1)) -- Save it in our array.
      ll=l+1 -- save just after where we found it for searching next time.
    else
      tInsert(t, string.sub(p,ll)) -- Save what's left in our array.
      break -- Break at end, as it should be, according to the lua manual.
    end
  end
  return t
end

function math.clamp(value, low, high)
  if low and value <= low then
    return low
  elseif high and value >= high then
    return high
  end
  return value
end

function math.inBounds(value, low, high)
  if value >= low and value <= high then
    return true
  else
    return false
  end
end

function math.round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function app.saveFile(strFilename, strValue, dir)
  local path = system.pathForFile(strFilename, dir or system.DocumentsDirectory)
  local file = io.open( path, "w+" )
  if file then
    file:write(strValue)
    io.close(file)
  end
end

function app.readFile(strFilename, dir)
  local theFile = strFilename
  local path = system.pathForFile( theFile, dir or system.DocumentsDirectory )
  -- io.open opens a file at path. returns nil if no file found
  local file = io.open( path, "r" )
  if file then
    -- read all contents of file into a string
    local contents = file:read( "*a" )
    io.close( file )
    return contents
  else
    return ''
  end
end

function math.checkIn(value, ...)
  if type(arg[1]) == 'table' then
    for k, v in pairs(arg[1]) do
      if v == value then
        return true
      end
    end
  else
    for i, v in ipairs(arg) do
      if v == value  then
        return true
      end
    end
  end
  return false
end

function app.datetime()
  local t = os.date('*t')
  return t.year .. '-' .. t.month .. '-' .. t.day .. ' ' .. t.hour .. ':' .. t.min .. ':' .. t.sec
end

function app.parseDatetime(datetime)
  local pattern = '(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)'
  local year, month, day, hour, minute, seconds = datetime:match(pattern)
  year = tonumber(year)
  month = tonumber(month)
  day = tonumber(day)
  return {year = year, month = month, day = day, hour = hour, min = minute, sec = seconds}
end

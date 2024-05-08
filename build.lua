local printColors = false

local accentColors = {
   'rosewater',
   'flamingo', 
   'pink',
   'mauve',
   'red',
   'maroon',
   'peach',
   'yellow',
   'green',
   'teal',
   'sky',
   'sapphire',
   'blue',
   'lavender'
}

-- libraries
local getMapColor = require('colors')

-- read file
local file = io.open("input.xml", "r")
local input = file:read("*a")
file:close()

-- make output folder
io.popen('mkdir output')

-- generate colors
for _, i in pairs({'latte', 'frappe', 'macchiato', 'mocha'}) do
   local theme = require('flavors/'..i)
   for i, v in pairs(theme) do
      if type(v) == 'table' then
         theme[i] = v.hex:gsub('#', '')
      end
   end
   local mapColor = getMapColor(theme)
   -- parse
   local colors = {}
   
   for name, color in input:gmatch('key="([^"]*)">(#%x+)</') do
      if color:sub(2, 3) == '00' then
         mapColor[name] = '#00000000'
      end
      colors[name] = color:lower()
   end
   
   --colors for print
   local escapeString = string.char(27) .. '[%sm'
   local function escapeCode(str, colorBg)
      str = tostring(str)
      local color = str:match('%x%x%x%x%x%x')
      if color then
         local r = tonumber(color:sub(1, 2), 16)
         local g = tonumber(color:sub(3, 4), 16)
         local b = tonumber(color:sub(5, 6), 16)
         return escapeString:format((colorBg and '48' or '38')..';2;'..r..';'..g..';'..b)
      else
         return escapeString:format(str)
      end
   end
   
   -- map colors
   local colorsToChange = {}
   local noTheme = {}
   for i, v in pairs(mapColor) do
      colorsToChange[colors[i]] = v:lower()
   end
   
   -- replace colors and print all colors that got replaced
   for i, v in pairs(colors) do
      if colorsToChange[v] then
         local color = colorsToChange[v]
         colors[i] = color
         if color:match('#%x%x%x%x%x%x%x%x') and printColors then
            local colorBrightness = tonumber(color:sub(4, 5), 16) + tonumber(color:sub(6, 7), 16) + tonumber(color:sub(8, 9), 16)
            colorBrightness = colorBrightness / 255 / 3
            print(escapeCode(32)..'+ ' .. escapeCode(colorBrightness > 0.5 and '#000000' or '#ffffff') .. escapeCode(color:sub(4, -1), true) .. color .. escapeCode(0) .. ' ' .. i)
         elseif printColors then
            print(escapeCode(32)..'+ ' .. escapeCode(0) .. color .. ' ' .. i)
         end
      else
         noTheme[v] = noTheme[v] or {}
         table.insert(noTheme[v], i)
      end
   end
   
   -- print all missing colors
   if printColors then
      for color, list in pairs(noTheme) do
         local colorBrightness = tonumber(color:sub(4, 5), 16) + tonumber(color:sub(6, 7), 16) + tonumber(color:sub(8, 9), 16)
         colorBrightness = colorBrightness / 255 / 3
         for i = 1, #list do
            print(escapeCode(31)..'- ' .. escapeCode(colorBrightness > 0.5 and '#000000' or '#ffffff') .. escapeCode(color:sub(4, -1), true) .. color .. escapeCode(0) .. ' ' .. list[i])
         end
      end
   end
   
   -- generate output
   local output = {}
   
   table.insert(output, '<?xml version="1.0" encoding="utf-8"?>')
   table.insert(output, '<properties>')
   table.insert(output, '<entry key="title">catppuccin '..i..' ${accentName}</entry>')
   table.insert(output, '<entry key="author">Auriafoxgirl</entry>')
   
   for i, v in pairs(colors) do
   	table.insert(output, '<entry key="'..i..'">'..v..'</entry>')
   end
   
   table.insert(output, '</properties>')
   
   -- print(table.concat(output, '\n'))
   
   -- save output
   file = io.open("output/"..i..".xml", "w")
   file:write(table.concat(output, '\n'))
   file:close()
   
   -- save accent colors
   local tbl = {}
   for _, i in pairs(accentColors) do
      table.insert(tbl, i..':'..theme[i])
   end
   file = io.open("output/"..i..".txt", "w")
   file:write(table.concat(tbl, '\n'))
   file:close()
   
   print('generated', i)
end
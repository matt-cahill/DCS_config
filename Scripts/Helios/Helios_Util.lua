Helios_Util = {}

function Helios_Util.TableCheckFunction(array, name)
	if array == nil or name == nil then return false end
	if type(array) ~= "table" then return false end
	
	for key, value in pairs(array) do
		if Helios_Util.CompareString(key, name) and type(value) == "function" then
			return true
		end
	end
	
	return false
end

function Helios_Util.CompareString(str1, str2)
	if str1 == str2 or string.find(str1, str2) ~= nil then
		return true
	end
	
	return false
end

function Helios_Util.Split(text, pattern)
   local ret = {}
   local findpattern = "(.-)"..pattern
   local last = 1
   local startpos, endpos, str = text:find(findpattern, 1)
   
   while startpos do
      if startpos ~= 1 or str ~= "" then table.insert(ret, str) end	  
      last = endpos + 1
      startpos, endpos, str = text:find(findpattern, last)
   end
   
   if last <= #text then
      str = text:sub(last)
      table.insert(ret, str)
   end
   
   return ret
end

function Helios_Util.Degrees(radians)
	return radians * 57.2957795
end

function Helios_Util.Convert_Lamp(valor_lamp)
	return (valor_lamp  > 0.1) and 1 or 0
end

function Helios_Util.Convert_SW (valor)
	return math.abs(valor-1)+1
end

function Helios_Util.ValueConvert(actual_value, input, output)
	local range=1
	local real_value=0
	local slope = {}

	for a=1,#output-1 do -- calculating the table of slopes
		slope[a]= (input[a+1]-input[a]) / (output[a+1]-output[a])
	end

	for a=1,#output-1 do 
		if actual_value >= output[a] and actual_value <= output[a+1] then
			range = a
			break
		end     -- check the range of the value
	end

	final_value= ( slope[range] * (actual_value-output[range]) ) + input[range]
	
	return final_value
end

function Helios_Util.GetListIndicator(id)
	local indicator = list_indication(id)
	local result = {}

	if indicator == "" then
		return nil
	end

	local spl = indicator:gmatch("-----------------------------------------\n([^\n]+)\n([^\n]*)\n")
	
	while true do
		local key, value = spl()
		
		if not key then break end
		
		result[key] = value
	end
	
	return result
end

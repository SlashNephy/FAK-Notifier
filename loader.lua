if not Steam then
	return
end

function ExecuteScript(scriptPath)
	local hook_files = {
		["lib/units/beings/player/playerdamage"] = "PlayerDamage.lua"
	}
	local requiredScript = scriptPath:lower()

	if hook_files[requiredScript] then
		fileName = ModPath .. "scripts/" .. hook_files[requiredScript]
		local stdout, stderr = pcall(
			function()
				if io.file_is_readable(fileName) then
					dofile(fileName)
				else
					log("[Error] BLT could not open script '" .. fileName .. "'.")
				end
			end
		)
		if not stdout then
			log("[Error] Script: " .. fileName .. "\n" .. stderr)
		end
	else
		log("[Error] Unregistered script called: " .. requiredScript)
	end
end

if RequiredScript then
	ExecuteScript(RequiredScript)
end

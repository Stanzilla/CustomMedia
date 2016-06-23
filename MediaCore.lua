local LSM3 = LibStub("LibSharedMedia-3.0", true)

SharedMedia = {}
SharedMedia.revision = tonumber(string.sub("$Revision: 63552 $", 12, -3)) or 1

SharedMedia.registry = { ["statusbar"] = {} }

function SharedMedia:Register(mediatype, key, data, langmask)
	if LSM3 then
		LSM3:Register(mediatype, key, data, langmask)
	end	
	if not SharedMedia.registry[mediatype] then
		SharedMedia.registry[mediatype] = {}
	end
	table.insert(SharedMedia.registry[mediatype], { key, data, langmask})
end

function SharedMedia.OnEvent(this, event, ...)
	if not LSM3 then
		LSM3 = LibStub("LibSharedMedia-3.0", true)
		if LSM3 then
			for m,t in pairs(SharedMedia.registry) do
				for _,v in ipairs(t) do
					LSM3:Register(m, v[1], v[2], v[3])
				end
			end
		end
	end	
end

SharedMedia.frame = CreateFrame("Frame")
SharedMedia.frame:SetScript("OnEvent", SharedMedia.OnEvent)
SharedMedia.frame:RegisterEvent("ADDON_LOADED")

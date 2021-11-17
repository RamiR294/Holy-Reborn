local Loader = {
	_DEBUG = true
}

local include_realm = {
	sv = SERVER and include or function() end,
	cl = SERVER and AddCSLuaFile or include
}

include_realm.sh = function(f)
	AddCSLuaFile(f)
	return include(f)
end

function Loader:include(path, realm, _lvl)
	local worker = include_realm[realm or "sh"]
	if worker == nil then
		realm = "sh"
		worker = include_realm.sh
	end

	if file.Find(path, "LUA") then
		if self._DEBUG then
			print(string.rep("\t", _lvl or 0) .. realm .." > ".. path)
		end

		return worker(path)
	end
end

function Loader:GetFilename(path)
	return path:match("[^/]+$")
end

function Loader:RemoveExtension(path)
	return path:match("(.+)%..+")
end

function Loader:Include(path, realm, _lvl)
	realm = realm or string.sub(self:GetFilename(path), 1, 2)
	return self:include(path, realm, _lvl)
end

local is_client = {
	["sv"] = SERVER
}

function Loader:IncludeDir(dir, recursive, realm, storage, _base_path_len, _lvl)
	_base_path_len = _base_path_len or #dir + 2
	_lvl = _lvl or 1

	local path = dir .."/"
	local files, folders = file.Find(path .."*", "LUA")

	if self._DEBUG and is_client[realm] ~= false then
		print(string.rep("\t", _lvl - 1) .."Loader:IncludeDir(".. (realm or "All") .. (recursive and ", recursive" or "") ..") > ".. dir)
	end

	for _, f in ipairs(files) do
		if storage then
			storage[self:RemoveExtension(recursive and (path:sub(_base_path_len) .. f) or f)] = self:Include(path .. f, realm, _lvl)
		else
			self:Include(path .. f, realm, _lvl)
		end
	end

	if not recursive then return end

	for _, f in ipairs(folders) do
		self:IncludeDir(dir .."/".. f, recursive, realm, storage, _base_path_len, _lvl + 1)
	end
end

function Loader:AddCsDir(dir, recursive, _lvl)
	_lvl = _lvl or 1

	local path = dir .."/"
	local files, folders = file.Find(path .."*", "LUA")

	if self._DEBUG then
		print(string.rep("\t", _lvl - 1) .."Loader:AddCsDir(".. (recursive and "recursive" or "") ..") > ".. dir)
	end

	for _, f in ipairs(files) do
		if self._DEBUG then
			print(string.rep("\t", _lvl) .." ".. path .. f)
		end

		pcall(AddCSLuaFile, path .. f)
	end

	if not recursive then return end

	for _, f in ipairs(folders) do
		self:AddCsDir(path .. f, true, _lvl + 1)
	end
end

Loader.__index = Loader
return Loader
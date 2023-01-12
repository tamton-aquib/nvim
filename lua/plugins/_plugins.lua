local path = vim.fn.stdpath("config") .. "/plugins.json"
local nice

local fi = io.open(path, "r")
if fi ~= nil then
    local local_content = fi:read("*a")
    nice = vim.json.decode(local_content)
    fi:close()
end

return nice

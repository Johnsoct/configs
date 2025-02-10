-- WINDOW HIGHLIGHTING
-- WINDOW HIGHLIGHTING
-- WINDOW HIGHLIGHTING

local function darken_color(hex, percent)
    -- TODO: convert default color theme color values to hex ("NvimLightGrey3")
    -- print("hex", hex)
    -- print("percent", percent)
    local r = math.floor(tonumber(tostring(hex):sub(2, 3), 16) * percent)
    local g = math.floor(tonumber(tostring(hex):sub(4, 5), 16) * percent)
    local b = math.floor(tonumber(tostring(hex):sub(6, 7), 16) * percent)
    return string.format("#%02x%02x%02x", r, g, b)
end

-- local normal_hl = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("StatusLine")), "bg")
-- local active_bg = normal_hl and darken_color(normal_hl, 0.9) or "#222222"

-- Apply highlight groups dynamically
-- vim.api.nvim_set_hl(0, "NormalActive", { bg = active_bg })
-- vim.api.nvim_set_hl(0, "InactiveWindow", { bg = normal_hl })

-- Apply winhighlight
-- vim.cmd([[set winhighlight=Normal:NormalActive,NormalNC:InactiveWindow]])

-- WINDOW HIGHLIGHTING END
-- WINDOW HIGHLIGHTING END
-- WINDOW HIGHLIGHTING END

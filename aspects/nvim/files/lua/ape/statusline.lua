local has_lualine, lualine = pcall(require, "lualine")

if not has_lualine then
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        always_divide_middle = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diagnostics",

                sources = { "nvim_diagnostic", "nvim_lsp" },

                sections = { "error", "warn", "info", "hint" },

                diagnostics_color = {
                    error = "DiagnosticError",
                    warn = "DiagnosticWarn",
                    info = "DiagnosticInfo",
                    hint = "DiagnosticHint",
                },
                symbols = {
                    error = "E ",
                    warn = "W ",
                    info = "I ",
                    hint = "H ",
                },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
})
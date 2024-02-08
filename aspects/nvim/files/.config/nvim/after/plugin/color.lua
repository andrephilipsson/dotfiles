local has_material, material = pcall(require, 'material')

if has_material then
  material.setup({
    styles = { -- Give comments style such as bold, italic, underline etc.
    comments = { italic = true },
    strings = { --[[ bold = true ]] },
    keywords = { --[[ underline = true ]] },
    functions = { --[[ bold = true, undercurl = true ]] },
    variables = {},
    operators = {},
    types = {},
  },

  plugins = { -- Uncomment the plugins that you use to highlight them
  -- Available plugins:
  -- "dap",
  -- "eyeliner",
  -- "fidget",
  -- "flash",
  -- "gitsigns",
  -- "hop",
  -- "illuminate",
  -- "indent-blankline",
  -- "lspsaga",
  -- "mini",
  -- "neogit",
  -- "neotest",
  -- "neo-tree",
  -- "neorg",
  -- "noice",
  "nvim-cmp",
  -- "nvim-navic",
  -- "nvim-tree",
  -- "nvim-web-devicons",
  -- "rainbow-delimiters",
  -- "sneak",
  -- "telescope",
  -- "trouble",
  -- "which-key",
  },

  async_loading = true, -- Load parts of the theme asyncronously for faster startup
})

vim.g.material_style = "deep ocean"
vim.cmd("colorscheme material")
end



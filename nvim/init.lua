vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>o", function()
  vim.cmd("update")
  if vim.bo.filetype == "lua" then
    vim.cmd("source %")
    print("Config reloaded!")
  else
    print("Saved (Not a config file)")
  end
end)

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/rmagatti/auto-session' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/vague2k/vague.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/supermaven-inc/supermaven-nvim' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
})

vim.filetype.add({ extension = { wgsl = "wgsl" } })

vim.lsp.config('zls', {
  cmd = { "zls" },
  root_markers = { "build.zig", ".git" },
})
vim.lsp.config('wgsl_analyzer', {
  cmd = { "wgsl_analyzer" },
  filetypes = { "wgsl" },
  root_markers = { ".git", "build.zig" },
})
vim.lsp.config('rust_analyzer', {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = { ["rust-analyzer"] = { checkOnSave = true } },
})
vim.lsp.config('nil', {
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})

vim.lsp.enable('nil')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('wgsl_analyzer')
vim.lsp.enable('zls')
vim.lsp.enable('lua_ls')

require('nvim-treesitter.install').compilers = { "clang", "gcc" }
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup({
    ensure_installed = { "rust", "glsl", "c", "zig", "lua", "wgsl", "vimdoc", "toml", "json" },
    highlight        = { enable = true },
    indent           = { enable = true },
    sync_install     = true,
  })
end

require("supermaven-nvim").setup({
  keymaps = { accept_suggestion = "<C-l>", clear_suggestion = "<C-]>", accept_word = "<C-o>" },
})
require("auto-session").setup({
  log_level = "error",
  auto_restore_enabled = true,
  auto_session_suppress_dirs = { "~/", "/tmp" },
  session_lens = { load_on_setup = true },
})

local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(), -- Add this
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- Add this
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } },
    { { name = 'buffer' }, { name = 'path' } })
})

require('fzf-lua').setup({
  winopts = { height = 0.85, width = 0.80, border = 'rounded', preview = { layout = 'vertical', vertical = 'down:45%' } },
})
require("oil").setup({ keymaps = { ["q"] = "actions.close" }, view_options = { show_hidden = true, }, default_file_explorer = true, })

local icons_ok, devicons = pcall(require, "nvim-web-devicons")
if icons_ok then devicons.setup({ default = true }) end

_G.H = {}
function H.statusline_path()
  local path = vim.fn.expand("%:p")
  if path == "" then return " [No Name] " end
  return " " .. vim.fn.fnamemodify(path, ":p:h:t") .. "/" .. vim.fn.fnamemodify(path, ":t") .. " "
end

vim.opt.statusline = "%{v:lua.H.statusline_path()}%m %= %l:%c "
vim.cmd("colorscheme vague")
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes'
vim.o.showtabline = 0
vim.opt.redrawtime = 1500
vim.opt.updatetime = 250
vim.opt.lazyredraw = true
vim.opt.timeoutlen = 300
vim.o.winborder = "rounded"

-- Keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>r", function()
  local view = vim.fn.winsaveview()
  vim.lsp.buf.format({ async = false })
  vim.fn.winrestview(view)
end, { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>q", ":q!<CR>")
vim.keymap.set("n", "<leader>c", "gcc")
vim.keymap.set("v", "<leader>c", "gc")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")
-- vim.keymap.set("n", "<leader>gk", "<cmd>tabn<CR>")
-- vim.keymap.set("n", "<leader>gj", "<cmd>tabp<CR>")
vim.keymap.set("n", "vl", "V")
vim.keymap.set("n", "vv", "v")
vim.keymap.set("n", "vb", "<C-v>")
vim.keymap.set("n", "va", "ggVG")
-- vim.keymap.set("n", "<leader>sj", ":split | wincmd j<CR>")
-- vim.keymap.set("n", "<leader>sk", ":split | wincmd k<CR>")
-- vim.keymap.set("n", "<leader>sl", ":vsplit | wincmd l<CR>")
-- vim.keymap.set("n", "<leader>sh", ":vsplit | wincmd h<CR>")
-- vim.keymap.set("n", "<leader>zz", "<C-w>w")
-- vim.keymap.set("n", "<leader>zh", "<C-w>h")
-- vim.keymap.set("n", "<leader>zj", "<C-w>j")
-- vim.keymap.set("n", "<leader>zk", "<C-w>k")
-- vim.keymap.set("n", "<leader>zl", "<C-w>l")
vim.keymap.set("n", "<C-j>", "7jzz")
vim.keymap.set("n", "<C-k>", "7kzz")
vim.keymap.set("i", "<C-j>", "<Esc>10ji")
vim.keymap.set("i", "<C-k>", "<Esc>10ki")
vim.keymap.set("n", "<CR>", "i<CR><ESC>")
vim.keymap.set("n", "<BS>", "i<BS><ESC>l")
vim.keymap.set("n", "<TAB>", "10l")
vim.keymap.set("n", "<S-TAB>", "10h")

vim.keymap.set("n", "<leader>t", function()
  vim.cmd("lcd %:p:h")
  vim.cmd("vertical botright split | term fish")
  vim.cmd("startinsert")
end)

vim.keymap.set("n", "<leader>qq", function()
  require("auto-session").SaveSession()
  vim.cmd("qall!")
end)

vim.keymap.set("n", "<leader>sl", function()
  require("auto-session").RestoreSession()
end)

vim.keymap.set('n', '<leader>/', function()
  local cmd = "tmux new-window -n 'config' 'nvim " .. vim.fn.expand("$MYVIMRC") .. "'"
  os.execute(cmd)
end)

vim.keymap.set("n", "<leader>e", function()
  require("oil").open_float(nil, {
    window = {
      width = math.floor(vim.o.columns * 0.6),
      height = math.floor(vim.o.lines * 0.6),
      border = "rounded",
    }
  })
end)

vim.keymap.set('n', '<leader>ff', "<cmd>FzfLua files<CR>")
vim.keymap.set('n', '<leader>fg', "<cmd>FzfLua live_grep<CR>")
vim.keymap.set('n', '<leader>go', "<cmd>FzfLua lsp_document_symbols<CR>")
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>== ")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

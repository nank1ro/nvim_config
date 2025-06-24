-- open config
vim.cmd("nmap <leader>c :e ~/.config/nvim/init.lua<cr>")

-- save
vim.cmd("nmap <leader>s :w<cr>", { silent = true, desc = "Save" })

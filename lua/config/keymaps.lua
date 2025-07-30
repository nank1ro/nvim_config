-- repeat previous f, t, F or T movement
vim.keymap.set("n", "'", ";")

-- paste without overwriting
vim.keymap.set("v", "p", "P")

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":nohlsearch<cr>", { silent = true })


-- Map '<' in visual mode to indent left and reselect the visual block
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- Map '>' in visual mode to indent right and reselect the visual block
vim.keymap.set("v", ">", ">gv", { noremap = true })
if vim.g.vscode then
	local vscode = require("vscode")
	vim.keymap.set({ "n" }, "]d", function()
		vscode.action("editor.action.marker.next")
	end)

	vim.keymap.set({ "n" }, "[d", function()
		vscode.action("editor.action.marker.prev")
	end)
-- Window navigation mappings for VSCode
	vim.keymap.set({ "n" }, "<C-h>", function()
		vscode.action("workbench.action.focusLeftGroup")
	end, { noremap = true, silent = true })

	vim.keymap.set({ "n" }, "<C-j>", function()
		vscode.action("workbench.action.focusBelowGroup")
	end, { noremap = true, silent = true })

	vim.keymap.set({ "n" }, "<C-k>", function()
		vscode.action("workbench.action.focusAboveGroup")
	end, { noremap = true, silent = true })

	vim.keymap.set({ "n" }, "<C-l>", function()
		vscode.action("workbench.action.focusRightGroup")
	end, { noremap = true, silent = true })

  vim.keymap.set({'n'}, '<leader>bo', function()
    vscode.call('workbench.action.closeOtherEditors')
  end, { desc = 'Delete other buffers' })

  vim.keymap.set({'n'}, '<leader>bd', function()
    vscode.call('workbench.action.closeActiveEditor')
  end, { desc = 'Delete buffer' })

  vim.keymap.set({'n'}, '<leader>`', function()
    vscode.call('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')
    vscode.call('list.select')
  end, { desc = 'Switch to Other Buffer' })

  vim.keymap.set({'n'}, '<S-Tab>', function()
    vscode.call('workbench.action.previousEditor')
  end, { desc = 'Switch to Previous Buffer' })

  vim.keymap.set({'n'}, '<Tab>', function()
    vscode.call('workbench.action.nextEditor')
  end, { desc = 'Switch to Next Buffer' })
else
	-- Remap Ctrl+h/j/k/l to navigate windows like Ctrl+w h/j/k/l
	vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
end

local markdown_helpers = require('config.markdown_styling')

-- Set keymaps for bolding
vim.keymap.set({'n', 'v',}, '<leader>b', markdown_helpers.bold_word_or_selection, { desc = 'Bold word/selection (Markdown)' })
vim.keymap.set({'i'}, '<C-b>', markdown_helpers.bold_word_or_selection, { desc = 'Bold word/selection (Markdown)' })

-- Set keymaps for italicizing
vim.keymap.set({'n', 'v'}, '<leader>i', markdown_helpers.italic_word_or_selection, { desc = 'Italic word/selection (Markdown)' })
vim.keymap.set({'i'}, '<C-i>', markdown_helpers.italic_word_or_selection, { desc = 'Italic word/selection (Markdown)' })

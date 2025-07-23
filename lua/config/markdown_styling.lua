local M = {}

--- Applies Markdown styling with mode-specific logic.
-- In Insert mode, it leaves you in Insert mode.
-- @param open_tag string The opening Markdown tag (e.g., "**", "_")
-- @param close_tag string The closing Markdown tag (e.g., "**", "_")
local function apply_markdown_style(open_tag, close_tag)
    local mode = vim.fn.mode()
    local keys_to_press

    -- This is the command to paste the text that was just deleted by 'c' or 'ciw'.
    local paste_from_register = '<C-r>"'

    if mode == 'n' then
        -- In Normal mode, we want to end up back in Normal mode.
        -- ciw -> inserts text -> <Esc>
        keys_to_press = 'ciw' .. open_tag .. paste_from_register .. close_tag .. '<Esc>'
    elseif mode:match('^[vV\22]') then
        -- In Visual mode, we also want to end up back in Normal mode.
        -- c -> inserts text -> <Esc>
        keys_to_press = 'c' .. open_tag .. paste_from_register .. close_tag .. '<Esc>'
    elseif mode == 'i' then
        -- **THE KEY CHANGE IS HERE**
        -- In Insert mode, we want to remain in Insert mode.
        -- <C-o>ciw puts us back into insert mode automatically, so we *do not* add <Esc>.
        keys_to_press = '<C-o>ciw' .. open_tag .. paste_from_register .. close_tag
    else
        vim.notify("Markdown styling only works in Normal, Visual, or Insert mode.", vim.log.levels.WARN, { title = "Neovim Markdown Helper" })
        return
    end

    -- Use nvim_feedkeys to simulate typing the commands.
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(keys_to_press, true, true, true),
        'n', -- 'n' allows remapping, which is what we want.
        false
    )
end

-- Public function to bold text using asterisks
M.bold_word_or_selection = function()
    apply_markdown_style('**', '**')
end

-- Public function to italicize text using underscores
M.italic_word_or_selection = function()
    apply_markdown_style('*', '*')
end

return M

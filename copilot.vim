    {
        "github/copilot.vim",
        --event = "VeryLazy",
        config = function()
            -- For copilot.vim
            -- enable copilot for specific filetypes
            vim.g.copilot_filetypes = {
                ["TelescopePrompt"] = false,
            }

            -- Set to true to assume that copilot is already mapped
            vim.g.copilot_assume_mapped = true
            -- Set workspace folders
            vim.g.copilot_workspace_folders = "~/work"

            -- Setup keymaps
            local keymap = vim.keymap.set
            local opts = { silent = true }

            vim.g.copilot_no_tab_map = true

            --keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
            keymap("i", "<C-y>", 'copilot#Accept("\\<Tab>")', { expr = true, replace_keycodes = false })
            keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)
            keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)

            keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
            keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)
            keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
            -- default maps:
            --     <M-Right>     Accept the next word of the current suggestion. <Plug>(copilot-accept-word)
            --     <M-C-Right>   Accept the next line of the current suggestion. <Plug>(copilot-accept-line)
        end,
    },

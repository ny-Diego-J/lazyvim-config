return {
    "mbbill/undotree",
    lazy = false,
    keys = {
        { "<leader>hu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree öffnen" },
        { "<leader>hf", "<cmd>UndotreeFocus<CR>", desc = "Undo Tree Fokussieren" },
    },
    init = function()
        if vim.fn.has("win32") == 1 then
            vim.g.undotree_DiffCommand = "C:/Program Files/Git/usr/bin/diff.exe"
        end
    end,
}

return {
    "mbbill/undotree",
    lazy = false,
    keys = {
        { "<leader>hu", "<cmd>UndotreeToggle<CR>", desc = "Open undotree" },
        { "<leader>hf", "<cmd>UndotreeFocus<CR>", desc = "Focus undotree" },
    },
    init = function()
        if vim.fn.has("win32") == 1 then
            vim.g.undotree_DiffCommand = "C:/Program Files/Git/usr/bin/diff.exe"
        end
    end,
}

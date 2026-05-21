vim.api.nvim_create_user_command("RunC", function()
    local file = vim.fn.expand("%")
    local out = vim.fn.expand("%:r.exe")

    vim.notify("Compiling " .. file .. "...", vim.log.levels.INFO)

    vim.system({ "clang", file, "-o", out }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify("Compilation successful!", vim.log.levels.INFO)
                vim.cmd("split | terminal ./" .. out)
            else
                vim.notify("Compilation failed:\n" .. obj.stderr, vim.log.levels.ERROR)
            end
        end)
    end)
end, { desc = "Compile and run C file" })
-- removes netrw from the buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.bo.bufhidden = "wipe" -- Löscht den Buffer aus der Liste, wenn er nicht mehr sichtbar ist
    end,
})

_G.last_java_main_class = _G.last_java_main_class or ""

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        vim.keymap.set("n", "<F6>", function()
            vim.ui.input({
                prompt = "Main Class (z.B. com.example.Main): ",
                default = _G.last_java_main_class or "dj.Main",
            }, function(main_class)
                if main_class == nil then
                    return
                end
                _G.last_java_main_class = main_class

                vim.ui.input({
                    prompt = "Arguments (optional): ",
                    default = _G.last_java_args or "",
                }, function(args)
                    if args == nil then
                        return
                    end
                    _G.last_java_args = args

                    local cmd = "split | terminal mvn.cmd exec:java"

                    if main_class ~= "" then
                        cmd = cmd .. ' -Dexec.mainClass="' .. main_class .. '"'
                    end

                    if args ~= "" then
                        cmd = cmd .. ' -Dexec.args="' .. args .. '"'
                    end

                    vim.cmd(cmd)
                end)
            end)
        end, { desc = "Maven Run (Main + Args)", buffer = true })

        vim.opt_local.makeprg = "mvn.cmd compile"
        vim.opt.shellpipe = ">%s 2>&1"

        vim.keymap.set("n", "<F5>", function()
            vim.cmd("silent make!")
            vim.cmd("redraw!")

            vim.notify("Starting to build ...", vim.log.levels.INFO)
            if vim.v.shell_error == 0 then
                vim.notify("Successfully build", vim.log.levels.INFO)
            else
                vim.notify("build failed! Enter :copen to get infos", vim.log.levels.ERROR)
            end
        end, { desc = "Maven Build (Lautlos + Info)", buffer = true })
        vim.keymap.set("n", "<F7>", "<cmd>split | terminal mvn.cmd test<CR>", { desc = "Maven Test", buffer = true })
    end,
})

return {}

_G.last_java_main_class = _G.last_java_main_class or ""
_G.last_java_args = _G.last_java_args or ""

local M = {
    "nvim-treesitter/nvim-treesitter",
}

local function get_project_info()
    local current_dir = vim.fn.expand("%:p:h")

    local root_file = vim.fs.find({ "pom.xml", "build.gradle", "build.gradle.kts" }, {
        path = current_dir,
        upward = true,
    })[1]

    if not root_file then
        return { type = "maven", cmd = "mvn.cmd", root = current_dir }
    end

    local root_dir = vim.fs.dirname(root_file)
    local file_name = vim.fs.basename(root_file)

    if file_name == "pom.xml" then
        local cmd = vim.fn.filereadable(root_dir .. "/mvnw.cmd") == 1 and "mvnw.cmd" or "mvn.cmd"
        return { type = "maven", cmd = cmd, root = root_dir }
    else
        local cmd = vim.fn.filereadable(root_dir .. "/gradlew.bat") == 1 and "gradlew.bat" or "gradle.bat"
        return { type = "gradle", cmd = cmd, root = root_dir }
    end
end

M.config = function()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
            local project = get_project_info()

            vim.keymap.set("n", "<F6>", function()
                vim.ui.input({
                    prompt = "Main Class: ",
                    default = _G.last_java_main_class ~= "" and _G.last_java_main_class or "dj.main.Main",
                }, function(main_class)
                    if not main_class then
                        return
                    end
                    _G.last_java_main_class = main_class

<<<<<<< HEAD
                    vim.ui.input({
                        prompt = "Arguments (optional): ",
                        default = _G.last_java_args,
                    }, function(args)
                        if not args then
                            return
                        end
                        _G.last_java_args = args
=======
<<<<<<< HEAD
                    local cmd = "split | terminal mvn exec:java"
=======
                    local cmd = "split | terminal " .. run_base_cmd
>>>>>>> refs/remotes/origin/main
>>>>>>> 56c29fec12aea840aa17249c0f8dcc3d65735c16

                        local cmd_args = {}
                        if project.type == "gradle" then
                            table.insert(cmd_args, "run")
                            if main_class ~= "" then
                                table.insert(cmd_args, "--main-class=" .. main_class)
                            end
                            if args ~= "" then
                                table.insert(cmd_args, "--args=" .. args)
                            end
                        else
                            table.insert(cmd_args, "exec:java")
                            if main_class ~= "" then
                                table.insert(cmd_args, "-Dexec.mainClass=" .. main_class)
                            end
                            if args ~= "" then
                                table.insert(cmd_args, "-Dexec.args=" .. args)
                            end
                        end

                        vim.cmd("split")
                        vim.fn.termopen({ project.cmd, unpack(cmd_args) }, { cwd = project.root })
                    end)
                end)
            end, { desc = "Java Run", buffer = true })

<<<<<<< HEAD
            vim.opt.shellpipe = ">%s 2>&1"
=======
<<<<<<< HEAD
        vim.opt_local.makeprg = "mvn compile"
        vim.opt.shellpipe = ">%s 2>&1"

        vim.keymap.set("n", "<F5>", function()
            vim.cmd("silent make!")
            if vim.v.shell_error ~= 0 then
                vim.cmd("copen")
                vim.notify("Build failed!", vim.log.levels.ERROR)
            else
                vim.cmd("cclose")
                vim.notify("Build successful", vim.log.levels.INFO)
            end
        end, { desc = "Maven Build", buffer = true })
        vim.keymap.set("n", "<F7>", "<cmd>split | terminal mvn test<CR>", { desc = "Maven Test", buffer = true })
=======
        vim.keymap.set("n", "<F7>", function()
            vim.cmd("split | terminal " .. test_cmd)
        end, { desc = build_system_name .. " Test", buffer = true })
>>>>>>> refs/remotes/origin/main
    end,
})
>>>>>>> 56c29fec12aea840aa17249c0f8dcc3d65735c16

            vim.keymap.set("n", "<F5>", function()
                if project.type == "gradle" then
                    vim.opt_local.makeprg = project.cmd .. ' -p "' .. project.root .. '" compileJava'
                else
                    vim.opt_local.makeprg = project.cmd .. ' -f "' .. project.root .. '/pom.xml" compile'
                end

                vim.cmd("silent make!")
                if vim.v.shell_error ~= 0 then
                    vim.cmd("copen")
                    vim.notify("Build failed!", vim.log.levels.ERROR)
                else
                    vim.cmd("cclose")
                    vim.notify("Build successful", vim.log.levels.INFO)
                end
            end, { desc = "Java Build", buffer = true })

            vim.keymap.set("n", "<F7>", function()
                local current_file = vim.fn.expand("%:t:r")
                local is_test = current_file:match("Test$") or current_file:match("^Test")
                local cmd_args = { "test" }

                if is_test then
                    if project.type == "gradle" then
                        table.insert(cmd_args, "--tests")
                        table.insert(cmd_args, current_file)
                    else
                        table.insert(cmd_args, "-Dtest=" .. current_file)
                    end
                    vim.notify("Running single test: " .. current_file, vim.log.levels.INFO)
                else
                    vim.notify("Running all tests...", vim.log.levels.INFO)
                end

                vim.cmd("split")
                vim.fn.termopen({ project.cmd, unpack(cmd_args) }, { cwd = project.root })
            end, { desc = "Java Test", buffer = true })
        end,
    })
end

return M

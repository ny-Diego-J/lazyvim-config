_G.last_java_main_class = _G.last_java_main_class or ""
_G.last_java_args = _G.last_java_args or ""

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function(args)
        local current_file_dir = vim.fs.dirname(args.file)

        local maven_root = vim.fs.root(current_file_dir, { "pom.xml" })
        local gradle_root = vim.fs.root(current_file_dir, { "build.gradle", "build.gradle.kts", "settings.gradle.kts" })

        local is_maven = maven_root ~= nil
        local is_gradle = gradle_root ~= nil

        local build_cmd = ""
        local test_cmd = ""
        local run_base_cmd = ""
        local build_system_name = ""

        if is_maven then
            build_cmd = 'mvn.cmd -f "' .. maven_root .. '/pom.xml" compile'
            test_cmd = 'mvn.cmd -f "' .. maven_root .. '/pom.xml" test'
            run_base_cmd = 'mvn.cmd -f "' .. maven_root .. '/pom.xml" exec:java'
            build_system_name = "Maven"
        elseif is_gradle then
            local has_wrapper = vim.fn.filereadable(gradle_root .. "/gradlew.bat") == 1
            local gradle_bin = has_wrapper and (gradle_root .. "/gradlew.bat") or "gradle"

            build_cmd = '"' .. gradle_bin .. '" -p "' .. gradle_root .. '" compileJava'
            test_cmd = '"' .. gradle_bin .. '" -p "' .. gradle_root .. '" test'

            run_base_cmd = '"' .. gradle_bin .. '" -p "' .. gradle_root .. '" run'
            build_system_name = "Gradle"
        else
            build_system_name = "Standard Java"

            if vim.fn.isdirectory("out") == 0 then
                vim.fn.mkdir("out", "p")
            end

            local lib_cp = vim.fn.isdirectory("lib") == 1 and ";.\\lib\\*" or ""

            build_cmd = 'powershell -Command "Get-ChildItem -Recurse -Filter *.java .\\src \\| % { $_.FullName } \\| Out-File -Encoding ascii sources.txt"; javac -cp ".\\out'
                .. lib_cp
                .. '" -d .\\out @sources.txt'

            test_cmd = "echo 'Kein Test-Framework für Standard-Java konfiguriert'"
        end

        vim.opt_local.makeprg = build_cmd
        vim.opt.shellpipe = ">%s 2>&1"

        vim.keymap.set("n", "<F5>", function()
            vim.cmd("silent make!")
            if build_system_name == "Standard Java" and vim.fn.filereadable("sources.txt") == 1 then
                vim.fn.delete("sources.txt")
            end

            if vim.v.shell_error ~= 0 then
                vim.cmd("copen")
                vim.notify(build_system_name .. " Build fehlgeschlagen!", vim.log.levels.ERROR)
            else
                vim.cmd("cclose")
                vim.notify(build_system_name .. " Build erfolgreich", vim.log.levels.INFO)
            end
        end, { desc = build_system_name .. " Build", buffer = true })

        vim.keymap.set("n", "<F6>", function()
            vim.ui.input({
                prompt = "Main Class (z.B. main.Main): ",
                default = _G.last_java_main_class ~= "" and _G.last_java_main_class or "main.Main",
            }, function(main_class)
                if main_class == nil then
                    return
                end
                _G.last_java_main_class = main_class

                vim.ui.input({
                    prompt = "Arguments (optional): ",
                    default = _G.last_java_args,
                }, function(args)
                    if args == nil then
                        return
                    end
                    _G.last_java_args = args

                    local cmd = "split | terminal " .. run_base_cmd

                    if is_maven then
                        if main_class ~= "" then
                            cmd = cmd .. ' -Dexec.mainClass="' .. main_class .. '"'
                        end
                        if args ~= "" then
                            cmd = cmd .. ' -Dexec.args="' .. args .. '"'
                        end
                    elseif is_gradle then
                        if args ~= "" then
                            cmd = cmd .. ' --args="' .. args .. '"'
                        end
                    end

                    vim.cmd(cmd)
                end)
            end)
        end, { desc = build_system_name .. " Run (Main + Args)", buffer = true })

        vim.keymap.set("n", "<F7>", function()
            vim.cmd("split | terminal " .. test_cmd)
        end, { desc = build_system_name .. " Test", buffer = true })
    end,
})

return {}

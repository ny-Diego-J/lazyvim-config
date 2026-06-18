return {
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local function setup_jdtls()
                local config_dir = vim.fn.stdpath("config")
                local win_safe_path = config_dir:gsub("\\", "/")
                local format_url = "file:///" .. win_safe_path .. "/eclipse-style.xml"

                local data_dir = vim.fn.stdpath("data")
                local jdtls_path = data_dir .. "/mason/packages/jdtls"
                local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
                local config_path = jdtls_path .. "/config_win"

                local workspace_dir = data_dir .. "/site/java/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

                local config = {
                    cmd = {
                        "java",
                        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                        "-Dosgi.bundles.defaultStartLevel=4",
                        "-Declipse.product=org.eclipse.jdt.ls.core.product",
                        "-Dlog.level=ALL",
                        "-Xmx2G",
                        "-XX:+UseParallelGC",
                        "-Xms512m",
                        "-jar", launcher_jar,
                        "-configuration", config_path,
                        "-data", workspace_dir,
                    },
                    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
                    settings = {
                        java = {
                            format = {
                                settings = { url = format_url },
                            },
                        },
                    },
                }
                require("jdtls").start_or_attach(config)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = setup_jdtls,
            })
        end,
    },
}

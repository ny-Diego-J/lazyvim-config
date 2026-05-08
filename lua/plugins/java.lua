return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            local config_dir = vim.fn.stdpath("config")
            local win_safe_path = config_dir:gsub("\\", "/")
            local format_url = "file:///" .. win_safe_path .. "/eclipse-style.xml"

            -- 1. Initialize settings if they don't exist
            opts.settings = opts.settings or {}
            opts.settings.java = opts.settings.java or {}

            -- 2. Add your formatting
            opts.settings.java.format = {
                settings = { url = format_url },
            }

            -- 3. Add the Performance Flags (The JVM args)
            -- We insert them at the beginning of the command list
            opts.jdtls_args = {
                "-Xmx2G", -- Max RAM (2GB)
                "-XX:+UseParallelGC", -- Faster garbage collection
                "-Xms512m", -- Initial RAM (starts faster)
            }

            return opts
        end,
    },
}

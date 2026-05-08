-- java formatter and optimisation of jdtls
return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            local config_dir = vim.fn.stdpath("config")
            local win_safe_path = config_dir:gsub("\\", "/")
            local format_url = "file:///" .. win_safe_path .. "/eclipse-style.xml"

            opts.settings = opts.settings or {}
            opts.settings.java = opts.settings.java or {}

            -- 2. Add your formatting
            opts.settings.java.format = {
                settings = { url = format_url },
            }

            -- jvm optimisations
            opts.jdtls_args = {
                "-Xmx2G", -- Max RAM 2GB
                "-XX:+UseParallelGC", -- Faster garbage collection
                "-Xms512m", -- Initial RAM
            }

            return opts
        end,
    },
}

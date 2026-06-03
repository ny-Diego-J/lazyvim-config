return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            local config_dir = vim.fn.stdpath("config")
            local win_safe_path = config_dir:gsub("\\", "/")
            local format_url = "file:///" .. win_safe_path .. "/eclipse-style.xml"

            opts.settings = opts.settings or {}
            opts.settings.java = opts.settings.java or {}

            opts.settings.java.format = {
                settings = { url = format_url },
            }

            opts.jdtls_args = {
                "-Xmx2G",
                "-XX:+UseParallelGC",
                "-Xms512m",
            }

            return opts
        end,
    },
}

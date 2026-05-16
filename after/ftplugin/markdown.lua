vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "marksman" then
            vim.diagnostic.enable(false, { bufnr = vim.api.nvim_get_current_buf() })
            vim.opt_local.spell = false
        end
    end,
})

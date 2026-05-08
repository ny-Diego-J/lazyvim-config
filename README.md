# 🚀 My Neovim Configuration

A customized Neovim setup based on [LazyVim](https://github.com/LazyVim/LazyVim), optimized for Java development and enhanced for [Neovide](https://neovide.dev/).

## ✨ Features

- **Java Focused:** Deep integration with `nvim-jdtls`, Maven support, and custom Eclipse-style formatting.
- **Enhanced Debugging:** Full DAP support with `nvim-dap-ui` and virtual text.
- **Neovide Optimized:** Smooth zooming, transparency toggling, and font configuration.
- **Web Development:** Live server integration for quick previews.
- **C Development:** Custom commands for fast compilation and execution.

## 🛠️ Custom Commands

| Command   | Description                                                              |
| :-------- | :----------------------------------------------------------------------- |
| `:RunC`   | Compiles the current C file with `clang` and runs it in the terminal.    |
| `:RunCMD` | Compiles the current C file and runs it in a new Windows Command Prompt. |

## ⌨️ Keybindings

### Neovide (Global)

| Key     | Action                                                  |
| :------ | :------------------------------------------------------ |
| `<C-9>` | Zoom In (Scale +10%)                                    |
| `<C-->` | Zoom Out (Scale -10%)                                   |
| `<C-0>` | Reset Zoom                                              |
| `<F12>` | Toggle Transparency (80% / 100%) and switch colorscheme |

### Java / Maven (Java files only)

| Key    | Action                                                                    |
| :----- | :------------------------------------------------------------------------ |
| `<F5>` | **Maven Build:** Runs `mvn compile` silently with notification status.    |
| `<F6>` | **Maven Run:** Prompts for Main Class and Arguments, then runs via Maven. |
| `<F7>` | **Maven Test:** Runs `mvn test` in a split terminal.                      |

### Live Server

| Key          | Action                        |
| :----------- | :---------------------------- |
| `<leader>ls` | Start Live Server (Port 8080) |
| `<leader>lS` | Stop Live Server              |

## 📦 Plugins Overview

This configuration includes several essential plugins:

- **[LazyVim](https://github.com/LazyVim/LazyVim):** The base framework.
- **[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls):** Java LSP with custom JVM optimizations (`-Xmx2G`, etc.) and Eclipse-style formatting.
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap):** Debug Adapter Protocol support.
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui):** A beautiful UI for debugging.
- **[conform.nvim](https://github.com/stevearc/conform.nvim):** Formatter plugin (Prettier for web, LSP for Java).
- **[live-server.nvim](https://github.com/selimacerbas/live-server.nvim):** Local development server for web projects.
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim):** Real-time markdown preview in the browser.
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim):** Git management inside Neovim.

## ⚙️ Configuration Details

- **Tab Width:** Set to 4 spaces globally.
- **Java Formatting:** Uses `eclipse-style.xml` located in the config root.
- **JVM Optimizations:** Configured for `jdtls` to improve performance on large Java projects.
- **Diagnostics:** Virtual text is enabled for immediate feedback.

---@diagnostic disable: undefined-global

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            -- Mason setup
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "rust_analyzer",
                    -- Backend (Laravel)
                    "intelephense",
                    -- Laravel (PHP + Blade): install via :MasonInstall laravel-ls (not in mason-lspconfig ensure_installed map)

                    -- Frontend
                    "ts_ls",
                    "eslint",
                    "html",
                    "cssls",
                    "emmet_ls",
                    "jsonls",

                    -- DevOps
                    "dockerls",
                    "yamlls",

                    -- Neovim
                    "lua_ls",
                },
                automatic_installation = true,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- on_attach function to map keys after LSP attaches to buffer
            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap.set

                keymap("n", "gd", function() require("telescope.builtin").lsp_definitions() end, opts) -- go to definition
                keymap("n", "gr", vim.lsp.buf.references, opts)                                -- go to references
                keymap("n", "gi", vim.lsp.buf.implementation, opts)                            -- go to implementation
                keymap("n", "K", vim.lsp.buf.hover, opts)                                      -- hover
                keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)                            -- rename
                keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)                       -- code action
                keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)    -- previous diagnostic
                keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)     -- next diagnostic
                -- keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts) -- format
            end

            -- ======================
            --      -- PHP / Laravel (Phpactor)
            --      -- ======================
            --







            --      vim.lsp.config.phpactor = {
            --        cmd = { "phpactor", "language-server" },
            --        filetypes = { "php" },
            --        root_markers = { "composer.json", "artisan", ".git" },
            --        capabilities = capabilities,
            --        on_attach = on_attach,
            --      }

            -- PHP (Intelephense)
            vim.lsp.config.intelephense = {
                cmd = { "intelephense", "--stdio" },
                filetypes = { "php" },
                root_markers = { "artisan" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    intelephense = {
                        files = { maxSize = 1000000 },
                        telemetry = { enabled = false },
                    },
                },
            }

            -- Go
            vim.lsp.config.gopls = {
                cmd = { "gopls", "serve" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_markers = { "go.work", "go.mod", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            }

            -- Rust
            -- Bundled lspconfig root_dir (cargo metadata workspace detection) is kept.
            -- Use mason's binary explicitly: ~/.cargo/bin/rust-analyzer is a rustup proxy
            -- that errors unless `rustup component add rust-analyzer` was run.
            local mason_ra = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
            vim.lsp.config.rust_analyzer = {
                cmd = { vim.fn.executable(mason_ra) == 1 and mason_ra or "rust-analyzer" },
                filetypes = { "rust" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        check = { command = "clippy" },
                    },
                },
            }

            -- Laravel (PHP + Blade) — run :MasonInstall laravel-ls once
            vim.lsp.config.laravel_ls = {
                cmd = { "laravel-ls" },
                filetypes = { "php", "blade" },
                root_markers = { "artisan", "composer.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- ======================
            -- JavaScript / TypeScript
            -- ======================
            vim.lsp.config.ts_ls = {
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                -- Override bundled root_dir which uses nested tables incompatible with nvim 0.12-dev
                root_dir = function(bufnr, on_dir)
                    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" }
                    local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
                    local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
                    local project_root = vim.fs.root(bufnr, root_markers)
                    if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
                        return
                    end
                    if deno_root and (not project_root or #deno_root >= #project_root) then
                        return
                    end
                    on_dir(project_root or vim.fn.getcwd())
                end,
                capabilities = capabilities,
                on_attach = on_attach,
            }

            vim.lsp.config.eslint = {
                cmd = { "vscode-eslint-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                },
                -- Override bundled root_dir which uses nested tables incompatible with nvim 0.12-dev
                root_dir = function(bufnr, on_dir)
                    if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
                        return
                    end
                    local root = vim.fs.root(bufnr, {
                        "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git",
                    }) or vim.fn.getcwd()
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    local has_cfg = vim.fs.find({
                        ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml",
                        ".eslintrc.yml", ".eslintrc.json", "eslint.config.js",
                        "eslint.config.mjs", "eslint.config.cjs",
                    }, { path = fname, type = "file", limit = 1, upward = true })[1]
                    if has_cfg then
                        on_dir(root)
                    end
                end,
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- ======================
            -- HTML / CSS / Emmet
            -- ======================
            vim.lsp.config.html = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html", "blade", "erb" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            vim.lsp.config.cssls = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            vim.lsp.config.emmet_ls = {
                cmd = { "emmet-ls", "--stdio" },
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "blade",
                },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- ======================
            -- JSON
            -- ======================
            vim.lsp.config.jsonls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- ======================
            -- Docker
            -- ======================
            vim.lsp.config.dockerls = {
                cmd = { "docker-langserver", "--stdio" },
                filetypes = { "dockerfile" },
                root_markers = { "Dockerfile", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- ======================
            -- YAML (docker-compose, CI)
            -- ======================
            vim.lsp.config.yamlls = {
                cmd = { "yaml-language-server", "--stdio" },
                filetypes = { "yaml", "yml" },
                root_markers = {
                    "docker-compose.yml",
                    "docker-compose.yaml",
                    ".git",
                },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    yaml = {
                        validate = true,
                        completion = true,
                        hover = true,
                        schemas = {
                            ["https://json.schemastore.org/docker-compose.json"] = {
                                "docker-compose.yml",
                                "docker-compose.yaml",
                            },
                            ["https://json.schemastore.org/github-workflow.json"] =
                            ".github/workflows/*",
                        },
                    },
                },
            }

            -- ======================
            -- Lua (Neovim)
            -- ======================
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = {
                    ".luarc.json",
                    ".luarc.jsonc",
                    ".luacheckrc",
                    "stylua.toml",
                    ".git",
                },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- Enable all configured LSPs (required in Neovim 0.11+; config alone does not start them)
            vim.lsp.enable({
                "gopls",
                "rust_analyzer",
                "intelephense",
                "laravel_ls",
                "ts_ls",
                "eslint",
                "html",
                "cssls",
                "emmet_ls",
                "jsonls",
                "dockerls",
                "yamlls",
                "lua_ls",
            })

            -- diagnostics config with modern sign configuration
            vim.diagnostic.config({
                virtual_text = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✗",
                        [vim.diagnostic.severity.WARN] = "⚠",
                        [vim.diagnostic.severity.HINT] = "💡",
                        [vim.diagnostic.severity.INFO] = "ℹ",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
}

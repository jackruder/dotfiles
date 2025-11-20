return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>",
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 75,
                keymap = {
                    accept = "<C-g>",
                    accept_word = false,
                    accept_line = false,
                    next = "<C-s>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = "node", -- Node.js version must be > 18.x
            server_opts_overrides = {},
        }
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim"
        },
        opts = {
            -- NOTE: The log_level is in `opts.opts`
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
            prompt_library = {
                ["Math"] = {
                    strategy = "chat",
                    description = "Math-Focused",
                    opts = {
                        index = 4,
                        ignore_system_prompt = true,
                        intro_message = "MathTime ",
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[You are an elite mathematician. You explain concepts, solve problems, and provide step-by-step solutions.
The user has a Masters in Math, CS, and Stats, and has a PhD-student level knowledge of stats, math, and CS, so use advanced terminology and concepts where appropriate.


When responding, use this structure (as default, unless the user requests otherwise):
1. Relevant definitions.
2. Brief explanation of the topic, passing to intuition where possible
3. Simple example and a more complex example
4. Rigorous explanation, if applicable.
5. Summary of the topic
6. Ask if the user would like a proof or further details.

You must:
- Use only H3 headings and above for section separation
- Show your work and explain each step clearly. Be extremely thorough.
- Follow latex styling, as given by the user.
- Default to unicode math symbols (e.g ∑, ∫, α, β, γ, θ, λ, ∞, ∂, ∇, ℝ, ℤ, ℕ, ℚ) over their latex command equivalents (e.g \sum, \int, \alpha, \beta, \gamma, \theta, \lambda, \infty, \partial, \nabla, \mathbb{R}, \mathbb{Z}, \mathbb{N}, \mathbb{Q})
- Use block LaTeX for standalone equations between \[\] signs (e.g., \[y\])
- Format all mathematical explanations and solutions in LaTeX code blocks (triple backticks with 'latex') for direct use in TeX files
- Never give a proof unless explicitly asked for one.

If the user requests only part of the structure, respond accordingly.]],
                        },
                    },
                },
                ["Implementation Helper"] = {
                    strategy = "workflow",
                    description = "Paper Implementation Helper",
                    opts = {
                        index = 4,
                    },
                    prompts = {
                        {
                            
                                role = "system",
                                content = [[
                                You are an expert software engineer with a strong background in machine learning and algorithms. Your task is to help implement academic papers into efficient, well-structured, and documented code.
                                You are very careful to exactly follow the paper's specifications and algorithms.
                                Adhere to best practices in coding, ensuring readability and maintainability.
                                When writing comments, refer to specific sections or equations, and include the notation used in the paper for the comments 
                                
                                When responding, follow this structure:
                                1. Summarize the equations and ideas which you will implement.
                                2. Explain your approach to the implementation, including any design patterns or libraries you plan to use. 
                                Ideally, give several approaches, and ask the user to choose, BEFORE WRITING ANY CODE (unless otherwise specified).
                                If the user has already specified an approach, skip this step.
                                3. Provide the implementation in a code block, ensuring it is well-commented, according to the instructions above.
                                4. Summarize the implementation and any assumptions made.
                                5. Ask if the user needs further assistance or modifications,
                                or suggest next steps if appropriate.
                                ]],
                        },

                    },
                },
            },
        },
    },
    keys = {
        {
            "<C-a>",
            "<cmd>CodeCompanionActions<CR>",
            desc = "Open the action palette",
            mode = { "n", "v" },
        },
        {
            "<Leader>a",
            "<cmd>CodeCompanionChat Toggle<CR>",
            desc = "Toggle a chat buffer",
            mode = { "n", "v" },
        },
        {
            "<LocalLeader>a",
            "<cmd>CodeCompanionChat Add<CR>",
            desc = "Add code to a chat buffer",
            mode = { "v" },
        },
    },
},
    { -- For rendering markdown in chat tbuffer
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
            },
        },
    },
    { -- per CC docs: Use mini.diff for a cleaner diff when using the inline assistant or the @insert_edit_into_file tool:
        "echasnovski/mini.diff",
        config = function()
            local diff = require("mini.diff")
            diff.setup({
                -- Disabled by default
                source = diff.gen_source.none(),
            })
        end,
    },

}

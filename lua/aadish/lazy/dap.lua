return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            -- Python setup
            require("dap-python").setup("python3")

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Keybindings
            vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Breakpoint with Condition" })
            vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })
        end,
    },
}

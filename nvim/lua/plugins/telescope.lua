-- telescope
require('telescope').setup{
  defaults = {
    path_display = {smart},
    layout_strategy = 'bottom_pane',
    layout_config = {
      bottom_pane = {
        height = 15,
        preview_cutoff = 120,
        prompt_position = "bottom"
      },
    },
    mappings = {
      i = {
        ["<C-s>"] = "select_horizontal",
        ["<esc>"] = "close",
        ["<C-u>"] = false,
        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<M-n>"] = require('telescope.actions').edit_search_line,
      },
    }
  },
  pickers = {
    find_files = {
      find_command = {"fd", "--type", "f"}, -- linux only option
      hidden = false, -- linux only option
      mappings = {
        n = {
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent lcd %s", dir))
          end
        }
      }
    },
    live_grep = {
      prompt_title = "find string in current directory",
      grep_open_files = false,
    },
    grep_string = {
      use_regex = true,
    },
    buffers = {
      sort_mru = true,
    },
  },
  extensions = {
    fzf = { -- linux only option
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  }
}
-- load_extension
if jit.os == "Linux" then
  require('telescope').load_extension('fzf')
end

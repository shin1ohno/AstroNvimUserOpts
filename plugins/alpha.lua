return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-project.nvim",
  },
  config = function(_, _)
    local _, plenary_path = pcall(require, "plenary.path")
    local dashboard = require("alpha.themes.dashboard")
    local theme = require("alpha.themes.theta")
    local button = require("astronvim.utils").alpha_button

    math.randomseed(os.time())

    local function create_gradient(start, finish, steps)
      local r1, g1, b1 =
          tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
      local r2, g2, b2 =
          tonumber("0x" .. finish:sub(2, 3)), tonumber("0x" .. finish:sub(4, 5)), tonumber("0x" .. finish:sub(6, 7))

      local r_step = (r2 - r1) / steps
      local g_step = (g2 - g1) / steps
      local b_step = (b2 - b1) / steps

      local gradient = {}
      for i = 1, steps do
        local r = math.floor(r1 + r_step * i)
        local g = math.floor(g1 + g_step * i)
        local b = math.floor(b1 + b_step * i)
        table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
      end

      return gradient
    end

    local function apply_gradient_hl(text)
      local start = "#BF616A"
      local finish = "#4C566A"

      local gradient = create_gradient(start, finish, #text)
      local lines = {}
      for i, line in ipairs(text) do
        local tbl = {
          type = "text",
          val = line,
          opts = {
            hl = "HeaderGradient" .. i,
            shrink_margin = false,
            position = "center",
          },
        }
        table.insert(lines, tbl)

        vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
      end

      return {
        type = "group",
        val = lines,
        opts = { position = "center" },
      }
    end

    local hello = {}
    hello.panda = {
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣆⠀⢀⣀⣀⣤⣤⣤⣶⣦⣤⣤⣄⣀⣀⠀⢠⣾⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀   ]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀    ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀    ]],
      [[⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⠟⠀⠀⠀⠀⠀⣀⣤⣤⣤⡀⠀⠀⠀⠀⠀⢀⣤⣤⣤⣄⡀⠀⠀⠀⠀⠘⣿⡿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀   ]],
      [[⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⣠⣾⣿⣿⠛⣿⡇⠀⠀⠀⠀⠀⢸⣿⣿⠛⣿⣿⣦⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
      [[⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⡟⢠⣶⣾⣿⣿⣷⣤⢹⣿⣿⣿⣿⣿⡇⠀⠀⣀⣤⣿⣷⣴⣶⣦⣀⡀⠀⠀⠀⠀   ]],
      [[⠀⠀⠀⠀ ⠀⠀⠀⢀⣠⣤⣤⣤⣇⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠘⠻⣿⣿⣿⡿⠋⠀⢹⣿⣿⣿⣿⡇⠀⣿⣿⣿⡏⢹⣿⠉⣿⣿⣿⣷⠀⠀⠀   ]],
      [[⠀⠀⠀ ⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠹⣿⣿⠿⠋⠀⢤⣀⢀⣼⡄⠀⣠⠀⠈⠻⣿⣿⠟⠀⢸⣿⣇⣽⣿⠿⠿⠿⣿⣅⣽⣿⡇⠀⠀   ]],
      [[⠀⠀⠀⠀ ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣟⠁⠀⠀⠀⠈⣿⣿⣿⡇⠀⠀⠀  ]],
      [[⠛⠛⠛⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛]],
      [[⠀⠀⠀⠀⠀⠀⠘⠛⠻⢿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
    }
    hello.vlogo = {
      [[     .          .     ]],
      [[   ';;,.        ::'   ]],
      [[ ,:::;,,        :ccc, ]],
      [[,::c::,,,,.     :cccc,]],
      [[,cccc:;;;;;.    cllll,]],
      [[,cccc;.;;;;;,   cllll;]],
      [[:cccc; .;;;;;;. coooo;]],
      [[;llll;   ,:::::'loooo;]],
      [[;llll:    ':::::loooo:]],
      [[:oooo:     .::::llodd:]],
      [[.;ooo:       ;cclooo:.]],
      [[  .;oc        'coo;.  ]],
      [[    .'         .,.    ]],
    }

    local function get_header(headers)
      local header_text = headers[math.random(#headers)]
      return apply_gradient_hl(header_text)
    end

    local function get_info()
      local lazy_stats = require("lazy").stats()
      local total_plugins = " " .. lazy_stats.loaded .. "/" .. lazy_stats.count .. " packages"
      local datetime = os.date(" %A %B %d")
      local version = vim.version()
      local nvim_version_info = "ⓥ  " .. version.major .. "." .. version.minor .. "." .. version.patch

      local info_string = datetime .. "  |  " .. total_plugins .. "  |  " .. nvim_version_info

      return {
        type = "text",
        val = info_string,
        opts = {
          hl = "Delimiter",
          position = "center",
        },
      }
    end

    -- MRU
    local function get_mru(max_shown)
      local tbl = {
        { type = "text", val = "Recent Files", opts = { hl = "SpecialComment", position = "center" } },
      }

      local mru_list = theme.mru(0, "", max_shown)
      for _, file in ipairs(mru_list.val) do
        table.insert(tbl, file)
      end

      return { type = "group", val = tbl, opts = {} }
    end


    local function get_projects(max_shown)
      local alphabet = "abcdefghijknopqrstuvwxyz"

      local tbl = {
        { type = "text", val = "Recent Projects", opts = { hl = "SpecialComment", position = "center" } },
      }

      require 'telescope'.load_extension('project')

      local project_list = require("telescope._extensions.project.utils").get_projects("recent")
      for i, project in ipairs(project_list) do
        if i > max_shown then
          break
        end

        local icon = "📁 "

        -- create shortened path for display
        local target_width = 35
        local display_path = project.path
        if #display_path > target_width then
          display_path = plenary_path.new(display_path):shorten(1, { -2, -1 })
          if #display_path > target_width then
            display_path = plenary_path.new(display_path):shorten(1, { -1 })
          end
        end

        -- get semantic letter for project
        local letter
        local project_name = display_path:match("[/\\][%w%s%.%-]*$")
        if project_name == nil then
          project_name = display_path
        end
        project_name = project_name:gsub("[/\\]", "")
        letter = string.sub(project_name, 1, 1):lower()

        -- get alternate letter if not available
        if string.find(alphabet, letter) == nil then
          letter = string.sub(alphabet, 1, 1):lower()
        end

        -- remove letter from available alphabet
        alphabet = alphabet:gsub(letter, "")

        -- create button element
        local file_button_el = dashboard.button(
          letter,
          icon .. display_path,
          "<cmd>lua require('telescope.builtin').find_files( { cwd = '"
          .. project.path
          .. "' }) <cr>"
        )

        -- create hl group for the start of the path
        local fb_hl = {}
        table.insert(fb_hl, { "Comment", 0, #icon + #display_path - #project_name })
        file_button_el.opts.hl = fb_hl

        table.insert(tbl, file_button_el)
      end

      return {
        type = "group",
        val = tbl,
        opts = {},
      }
    end

    theme.config.layout = {
      { type = "padding", val = 4 },
      get_header({ hello.panda, hello.vlogo }),
      { type = "padding", val = 1 },
      button("LDR n", "  New File  "),
      button("LDR f f", "  Find File  "),
      button("LDR f o", "󰈙  Recents  "),
      button("LDR f w", "󰈭  Find Word  "),
      button("LDR f '", "  Bookmarks  "),
      button("LDR S l", "  Last Session  "),
      { type = "padding", val = 2 },
      get_mru(10),
      { type = "padding", val = 2 },
      get_projects(10),
      { type = "padding", val = 3 },
      get_info()
    }
    require("alpha").setup(theme.config)
  end
}

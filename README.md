# logger.nvim

Logger for Neovim lua plugin development.

## Introduction

This is a logger library for Neovim lua plugin development,
which I use to develop my Neovim lua plugins.

## Usage

### Lazy.nvim

```lua
    {
        'linrongbin16/logger.nvim',
        lazy = true,
        config = function()
            require('logger').setup()
        end,
    },
```

Or you can simply add logger as your plugin's dependency:

```lua
    {
        'your_name/your_plugin',
        dependencies = 'linrongbin16/logger.nvim',
        ...
    },
```

## Configuration

```lua
require('logger').setup({
    -- Logger name.
    name = nil,

    -- Log level.
    --   DEBUG
    --   INFO
    --   WARN
    --   ERROR
    level = "INFO",

    -- Write log to console(command line).
    console = true,

    -- Write log to file.
    file = false,

    -- Log file name, working with `file=true`.
    -- For example `lsp-progress.log`.
    file_name = nil,

    -- Log file directory, working with `file=true`.
    -- By default is vim.fn.stdpath('data'):
    --   For Windows: $env:USERPROFILE\AppData\Local\nvim-data\
    --   For *NIX: ~/.local/share/nvim/
    file_dir = vim.fn.stdpath("data"),
})
```

## API

- `require('logger').debug(fmt, ...)`
- `require('logger').info(fmt, ...)`
- `require('logger').warn(fmt, ...)`
- `require('logger').error(fmt, ...)`

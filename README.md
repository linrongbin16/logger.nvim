# logger.nvim

A logger library for Neovim lua plugin development, which I use to develop my
Neovim lua plugins.

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

And in your plugin (usually in the setup function), setup the logger:

```lua
require('logger').setup()
```

## Configuration

```lua
require('logger').setup({
    -- Logger name.
    name = nil,

    -- Log level: ERROR > WARN > INFO > DEBUG.
    level = "INFO",

    -- Console(command line) logger.
    console = true,

    -- File logger.
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

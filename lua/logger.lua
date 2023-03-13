local EchoHl = {
    ["ERROR"] = "ErrorMsg",
    ["WARN"] = "ErrorMsg",
    ["INFO"] = "None",
    ["DEBUG"] = "Comment",
}
local Defaults = {
    log_level = "INFO",
    console_log = true,
    name = "logger",
    file_log = false,
    file_log_name = nil,
    file_log_dir = vim.fn.stdpath("data"),
    file_log_path = nil,
}
local Config = {}

local function setup(option)
    Config = vim.tbl_deep_extend("force", vim.deepcopy(Defaults), option or {})
    if Config.file_log_name and string.len(Config.file_log_name) > 0 then
        -- For Windows: $env:USERPROFILE\AppData\Local\nvim-data\lsp-progress.log
        -- For *NIX: ~/.local/share/nvim/lsp-progress.log
        Config.file_log_path =
            string.format("%s/%s", Config.file_log_dir, Config.file_log_name)
    end
end

local function log(level, msg)
    if vim.log.levels[level] < vim.log.levels[Config.log_level] then
        return
    end

    local msg_lines = vim.split(msg, "\n")
    if Config.console_log then
        vim.cmd("echohl " .. EchoHl[level])
        for _, line in ipairs(msg_lines) do
            vim.cmd(
                string.format(
                    'echom "%s"',
                    vim.fn.escape(
                        string.format("[%s] %s", Config.name, line),
                        '"'
                    )
                )
            )
        end
        vim.cmd("echohl None")
    end
    if Config.file_log then
        local fp = io.open(Config.file_log_path, "a")
        if fp then
            for _, line in ipairs(msg_lines) do
                fp:write(
                    string.format(
                        "[%s] %s [%s]: %s\n",
                        Config.name,
                        os.date("%Y-%m-%d %H:%M:%S"),
                        level,
                        line
                    )
                )
            end
            fp:close()
        end
    end
end

local function debug(fmt, ...)
    log("DEBUG", string.format(fmt, ...))
end

local function info(fmt, ...)
    log("INFO", string.format(fmt, ...))
end

local function warn(fmt, ...)
    log("WARN", string.format(fmt, ...))
end

local function error(fmt, ...)
    log("ERROR", string.format(fmt, ...))
end

local M = {
    setup = setup,
    debug = debug,
    info = info,
    warn = warn,
    error = error,
}

return M

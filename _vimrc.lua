----------------------------------------------------------------------
-- Neovim 配置文件 (从Vim配置迁移)
-- 测试方法: \nvim -u _vimrc.lua _vimrc.lua
-- 安装：见 make install_vimrc
-- https://github.com/cubao/build-envs/blob/dev/_vimrc.lua
----------------------------------------------------------------------

----------------------------------------------------------------------
-- => 通用设置
----------------------------------------------------------------------
-- nocompatible 在 Neovim 中无需设置，默认启用
vim.g.mapleader = ","             -- 设置leader键为逗号
vim.opt.history = 1000            -- 命令历史记录数量
-- vim.opt.autoread = true           -- 当文件在外部被修改时自动重新读取
-- backspace 在 Neovim 中已默认设置，无需再设置
vim.opt.mouse = ""                -- 禁用鼠标
vim.opt.langmenu = "en_US.UTF-8"  -- 设置语言 (使用 Neovim 中更新的方式)

-- 关闭备份文件和交换文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

----------------------------------------------------------------------
-- => 界面与显示设置
----------------------------------------------------------------------
vim.opt.number = true             -- 显示行号
vim.opt.cursorline = true         -- 高亮当前行
vim.opt.ruler = true              -- 在状态栏显示光标位置
vim.opt.showcmd = true            -- 在状态栏显示正在输入的命令
vim.opt.showmatch = true          -- 高亮显示匹配的括号
-- showfulltag 在 Neovim 中不可用
vim.opt.matchpairs = "(:),{:},[:],<:>" -- 设置需要匹配的括号
vim.opt.matchtime = 5             -- 匹配括号高亮的时间（0.5秒）
vim.opt.linespace = 3             -- 行间距
-- guioptions 在 Neovim 中处理方式不同，此设置可能无效

----------------------------------------------------------------------
-- => 文本、制表符与缩进
----------------------------------------------------------------------
vim.opt.expandtab = true          -- 使用空格代替制表符
vim.opt.tabstop = 4               -- 制表符宽度为4
vim.opt.shiftwidth = 4            -- 自动缩进宽度为4
vim.opt.softtabstop = 4           -- 按下Tab键时插入4个空格
vim.opt.autoindent = true         -- 自动缩进
vim.opt.iskeyword:remove("_")     -- 将下划线视为单词分隔符
-- vim.opt.paste = true              -- 启用粘贴模式，防止粘贴时自动缩进；和 expandtab 冲突

----------------------------------------------------------------------
-- => 搜索设置
----------------------------------------------------------------------
vim.opt.hlsearch = true           -- 高亮搜索结果
vim.opt.incsearch = true          -- 实时搜索
vim.opt.ignorecase = true         -- 搜索时忽略大小写
vim.opt.smartcase = true          -- 如果搜索包含大写字母，则区分大小写

----------------------------------------------------------------------
-- => 编码设置
----------------------------------------------------------------------
vim.opt.encoding = "utf-8"        -- 内部使用的字符编码
-- termencoding 在 Neovim 中冗余
vim.opt.fileencoding = "utf-8"    -- 新文件的编码
vim.opt.fileencodings = "ucs-bom,utf-8,chinese,cp936" -- 尝试解码的顺序

----------------------------------------------------------------------
-- => 键映射
----------------------------------------------------------------------
-- 可视模式下使用p不会覆盖当前寄存器的内容
vim.keymap.set("x", "<leader>p", "\"_c<C-r>0<Esc>", {silent = true})

-- 可视模式下的搜索和替换功能
-- 原Vimscript的VisualSelection函数转换成Lua函数
local function visual_selection(direction)
    local saved_reg = vim.fn.getreg('"')
    vim.cmd("normal! vgvy")
    local pattern = vim.fn.escape(vim.fn.getreg('"'), '\\/.*$^~[]')
    pattern = string.gsub(pattern, "\n$", "")
    
    if direction == 'b' then
        vim.cmd("normal ?" .. pattern .. "<CR>")
    elseif direction == 'gv' then
        vim.cmd("vimgrep " .. '/' .. pattern .. '/' .. ' **/*.')
    elseif direction == 'replace' then
        vim.cmd("%s" .. '/' .. pattern .. '/')
    elseif direction == 'f' then
        vim.cmd("normal /" .. pattern .. "<CR>")
    end
    
    vim.fn.setreg('/', pattern)
    vim.fn.setreg('"', saved_reg)
end

-- 设置可视模式下的映射
vim.keymap.set("v", "*", function() visual_selection('f') end, {silent = true})
vim.keymap.set("v", "#", function() visual_selection('b') end, {silent = true})
vim.keymap.set("v", "gv", function() visual_selection('gv') end, {silent = true})
vim.keymap.set("v", "r", function() visual_selection('replace') end, {silent = true})

-- for macOS: command-v
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
vim.g.neovide_input_use_logo = 1

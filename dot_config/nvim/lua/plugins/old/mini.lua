-- plugins/mini.lua

local ok, mini = pcall(require, "mini.pairs")
if ok then
  mini.setup()
end

local ok_comment, comment = pcall(require, "mini.comment")
if ok_comment then
  comment.setup()
end

local ok_scope, scope = pcall(require, "mini.indentscope")
if ok_scope then
  scope.setup({
    symbol = "│",
    options = { try_as_border = true },
  })
end


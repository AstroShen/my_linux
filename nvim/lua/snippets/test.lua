local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local rep = require("luasnip.extras").rep

snippets = {
  all = {
  s("header", f(header)),
  s(
    "func",
    fmt([[
      // {1}
      {a}
      {2} {3}({4}) {{
        {5}
      }}
    ]],{
      i(1, "Function Description"),
      a = d(5, function (variables)
        local parts = vim.split(variables[1][1], ',', true)
        local var_nodes = {}
        for index, variable in ipairs(parts) do
          variable = vim.split(variable:gsub("^%s*(.-)%s*$", "%1"), ' ', true)[2] or ""
          variable = "// " .. variable .. ": "
          table.insert(var_nodes, t(variable))
          table.insert(var_nodes, i(index, "variable discription"))
          if index == #parts then
            break
          end
          table.insert(var_nodes, t({"", ""}))
        end
        return sn(nil, var_nodes)
      end, {4}),
      i(2, "Type"),
      i(3, "Function"),
      i(4, "variables,..."),
      i(6)
    })
  ),
  s("trigger1", {
    i(1, "First jump"),
    t(" :: "),
    sn(2, {
      i(1, "Second jump"),
      t" : ",
      i(2, "Third jump")
    })
  }),
  s("test2",
  fmt(
  [[
  {1}
  {2}
  {3}
  ]], {
  t("one"),
  i(2, "three"),
  sn(1, {
    i(1, "And an insertNode."),
    i(2, "And an insertNode.")
  })}
  )
  ),
  },
}
for file_type, snippet in pairs(snippets) do
  ls.add_snippets(tostring(file_type), snippet)
end

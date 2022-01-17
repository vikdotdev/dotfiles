require "pears".setup(function(conf)
  conf.pair("|", "|", {filetypes = {"ruby"}})
  conf.pair("<%", "%>", {filetypes = {"erb"}})
  conf.pair("<%=", "%>", {filetypes = {"erb"}})
  conf.expand_on_enter(true)
end)


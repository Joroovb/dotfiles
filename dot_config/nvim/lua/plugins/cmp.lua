-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')


cmp.setup({
  completion = {
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Use LuaSnip.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    
    -- ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    -- ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    -- ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    -- ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>']     = cmp.config.disable, -- Specify `cmp.config.disable` to remove the default mapping.
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-e>']     = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp'},
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
  })
})

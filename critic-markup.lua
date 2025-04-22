
local maybesubs = false
local stk_end = false

if FORMAT:match 'html' then
  add = pandoc.RawInline('html', "<ins>")
  adde = pandoc.RawInline('html', "</ins>")

  rm = pandoc.RawInline('html', "<del>")
  rme = pandoc.RawInline('html', "</del>")
  rmeadd = pandoc.RawInline('html', "</del><ins>")

  mark = pandoc.RawInline('html', "<mark>")
  marke = pandoc.RawInline('html', "</mark>")

  comm = pandoc.RawInline('html', [[<span class="critic comment">]])
  comme = pandoc.RawInline('html', "</span>")
elseif FORMAT:match 'typst' then
  add = pandoc.RawInline('typst', "#added[")
  adde = pandoc.RawInline('typst', "]")

  rm = pandoc.RawInline('typst', "#deleted[")
  rme = pandoc.RawInline('typst', "]")
  rmeadd = pandoc.RawInline('typst', "]#added[")

  mark = pandoc.RawInline('typst', "/* mark")
  marke = pandoc.RawInline('typst', "*/")

  comm = pandoc.RawInline('typst', "#comment[")
  comme = pandoc.RawInline('typst', "]")
end
ruless = {['{%+%+']=add, ['{\u{2013}']=rm, ['{==']=mark, ['{>>']=comm, ['{%-%-']=rm,
          ['%+%+}']=adde, ['\u{2013}}']=rme, ['==}']=marke, ['<<}']=comme, ['%-%-}']=rme, ['~>']=rmeadd}

-- Strikeout before/after
st_b = '{'
st_e = '}'

local scriptcode = [[


]]

local latexcode = [[

]]

function cirtiblock(blocks, k, v)
  local newblock = {}
  for ti,t in pairs(blocks) do
    if t.text then
      i, j = t.text:find(k)
      if i then
        newblock[#newblock + 1] = pandoc.Str(t.text:sub(1, i-1))
        newblock[#newblock + 1] = v
        newblock[#newblock + 1] = pandoc.Str(t.text:sub(j+1, t.text:len()))
      else
        newblock[#newblock + 1] = t
      end
    else
      newblock[#newblock + 1] = t
    end
  end
  return newblock
end


function Str (el)
  local replaced = {el}
  -- Check for standard substitutions
  for k,v in pairs(ruless) do
    replaced = cirtiblock(replaced, k, v)
  end
  return replaced
end

function Strikeout (strk)
  return strk.content
end

-- Check Inlines for Strikeout (~~) and remove brackets before/after for replacement
function Inlines (inlines)
  for i = #inlines-1,2,-1 do
    if inlines[i] and inlines[i].t == 'Strikeout' and inlines[i+1] then
      if inlines[i+1].t == 'Str' then
        if inlines[i+1].text == st_e then
          inlines[i+1] = adde
        end
      end
    end
    if inlines[i] and inlines[i].t == 'Strikeout' and inlines[i-1] then
      if inlines[i-1].t == 'Str' then
        if inlines[i-1].text == st_b then
          inlines[i-1] = rm
        end
      end
    end
  end
  return inlines
end

--- From the lightbox filter
local function add_header_includes(meta, blocks)

  local header_includes = pandoc.List(blocks)

  -- add any exisiting meta['header-includes']
  -- it could be a MetaList or a single String
  if meta['header-includes'] then
    if type(meta['header-includes']) == 'List' then
      header_includes:extend(meta['header-includes'])
    else
      header_includes:insert(meta['header-includes'])
    end
  end

  meta['header-includes'] = pandoc.MetaBlocks(header_includes)
  return meta
end


function criticheader (meta)
  if FORMAT:match 'html' then
    -- quarto.doc.add_html_dependency({
    --   name = 'critic',
    --   scripts = {'critic.min.js'},
    --   stylesheets = {'critic.css'}
    -- })
    -- -- inject the rendering code
    quarto.doc.include_text("after-body", scriptcode)
--   else
--     quarto.doc.include_text("in-header", latexcode)
  end
end

-- All pass with Meta first
return {{Meta = criticheader}, {Inlines = Inlines}, {Strikeout = Strikeout}, {Str = Str}}
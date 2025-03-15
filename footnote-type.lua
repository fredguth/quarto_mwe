function RawInline(el)
    -- Look for footnote pattern <fn id="...">
    local content = el.text
    content = content:gsub('<fn%s+id="([^"]+)">', '<fn fn-type="other" id="%1">')
    
    -- Return the modified element if changes were made
    if content ~= el.text then
        el.text = content
        return el
    end

    -- Return unchanged if no modifications were needed
    return el
  end
  
  function RawBlock(el)

    -- Look for footnote pattern <fn id="...">
    local content = el.text
    -- Use pattern matching to find and replace the footnote format
    content = content:gsub('<fn%s+id="([^"]+)">', '<fn fn-type="other" id="%1">')
    
    -- Return the modified element if changes were made
    if content ~= el.text then
    el.text = content
    return el
    end

    -- Return unchanged if no modifications were needed
    return el
  end




  return {
    RawInline = RawInline,
    RawBlock = RawBlock
  }
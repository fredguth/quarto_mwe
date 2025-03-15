
function RawBlock(el)
    print(':::', el.format)
    if el.format == "html" then
        print(':::', el.text)
      el.text = el.text:gsub('<fn%s+id="([^"]+)">', '<fn fn-type="other" id="%1">')
      print(':::', el.text)
    end
    return el
  end
  

  
  return {
    RawBlock = RawBlock,
    
  }
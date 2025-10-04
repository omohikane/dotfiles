function ddc#custom#patch_global(key_or_dict, value = '') abort
  const dict = s:normalize_key_or_dict(a:key_or_dict, a:value)
  call s:notify('patchGlobal', [dict])
endfunction
function ddc#custom#patch_filetype(ft, key_or_dict, value = '') abort
  const dict = s:normalize_key_or_dict(a:key_or_dict, a:value)
  for filetype in s:normalize_string_or_list(a:ft)
    call s:notify('patchFiletype', [dict, filetype])
  endfor
endfunction
function ddc#custom#patch_buffer(key_or_dict, value = '') abort
  const dict = s:normalize_key_or_dict(a:key_or_dict, a:value)
  const n = bufnr('%')
  call s:notify('patchBuffer', [dict, n])
endfunction

function ddc#custom#set_global(dict) abort
  call s:notify('setGlobal', [a:dict])
endfunction
function ddc#custom#set_filetype(ft, dict) abort
  for filetype in s:normalize_string_or_list(a:ft)
    call s:notify('setFiletype', [a:dict, filetype])
  endfor
endfunction
function ddc#custom#set_buffer(dict) abort
  const n = bufnr('%')
  call s:notify('setBuffer', [a:dict, n])
endfunction
function ddc#custom#set_context_global(func) abort
  const id = denops#callback#register(a:func)
  call s:notify('setContextGlobal', [id])
endfunction
function ddc#custom#set_context_filetype(ft, func) abort
  const id = denops#callback#register(a:func)
  for filetype in s:normalize_string_or_list(a:ft)
    call s:notify('setContextFiletype', [id, filetype])
  endfor
endfunction
function ddc#custom#set_context_buffer(func) abort
  const n = bufnr('%')
  const id = denops#callback#register(a:func)
  call s:notify('setContextBuffer', [id, n])
endfunction

function ddc#custom#load_config(path) abort
  if !a:path->filereadable()
    call ddc#util#print_error(printf('"%s" is not found.', a:path))
    return
  endif

  return s:notify('loadConfig', [a:path])
endfunction

function ddc#custom#alias(type, alias, base) abort
  call ddc#denops#_notify('alias', [a:type, a:alias, a:base])
endfunction

" This should be called manually, so wait until DenopsPluginPost:ddc by the
" user himself.
function ddc#custom#get_global() abort
  return ddc#denops#_request('getGlobal', [], {})
endfunction
function ddc#custom#get_filetype() abort
  return ddc#denops#_request('getFiletype', [], {})
endfunction
function ddc#custom#get_buffer() abort
  let buffer = ddc#denops#_request('getBuffer', [], {})
  return buffer->type() == v:t_dict ? get(buffer, bufnr('%'), {}) : {}
endfunction
function ddc#custom#get_context() abort
  return ddc#denops#_request('getContext', [], {})
endfunction
function ddc#custom#get_current() abort
  return ddc#denops#_request('getCurrent', [], {})
endfunction

function s:notify(method, args) abort
  " Save notify args
  if !'g:ddc#_customs'->exists()
    let g:ddc#_customs = []
  endif

  call add(g:ddc#_customs, #{ method: a:method, args: a:args })

  return ddc#denops#_notify(a:method, a:args)
endfunction

function s:normalize_key_or_dict(key_or_dict, value) abort
  if a:key_or_dict->type() == v:t_dict
    return a:key_or_dict
  elseif a:key_or_dict->type() == v:t_string
    let base = {}
    let base[a:key_or_dict] = a:value
    return base
  endif
  return {}
endfunction

function s:normalize_string_or_list(string_or_list) abort
  if a:string_or_list->type() == v:t_list
    return a:string_or_list
  elseif a:string_or_list->type() == v:t_string
    return [a:string_or_list]
  endif
  return []
endfunction

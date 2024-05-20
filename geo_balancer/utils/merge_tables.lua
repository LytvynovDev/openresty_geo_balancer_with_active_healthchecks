local function merge_tables(t1, t2)
  local merged = {}
  for k, v in pairs(t1) do
    merged[k] = v
  end
  for k, v in pairs(t2) do
    merged[k] = v
  end
  return merged
end

return merge_tables

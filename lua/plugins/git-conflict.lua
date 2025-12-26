if not vim.g.jeff_enable_git_conflict then
  return {}
end

-- keys:
-- ct — choose theirs
-- cb — choose both
-- c0 — choose none
-- ]x — move to previous conflict
-- [x — move to next conflict
return {
  'akinsho/git-conflict.nvim',
  version = 'v2.1.0',
  config = true
}

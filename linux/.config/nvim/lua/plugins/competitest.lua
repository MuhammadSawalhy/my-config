local function sanitize(path)
  return path:gsub('[<>:"\\|?*]', '_')
end

local function trim(s)
   return s:match'^%s*(.*%S)' or ''
end

local function relative_path(task, file_extension)
  local hyphen = string.find(task.group, ' %- ')
  local problem_name = trim(task.name)
  local judge, contest

  if not hyphen then
    judge = task.group
    contest = 'unknown_contest'
  else
    judge = trim(string.sub(task.group, 1, hyphen - 1))
    contest = trim(string.sub(task.group, hyphen + 3))
  end

  local file_name = 'main'
  if file_extension == 'java' then
    file_name = task.languages.java.taskClass
  end

  if judge == 'Codeforces' then
    local contest_id = string.match(task.url, '%w+/(%d+)')
    contest = contest_id .. ' - ' .. contest
  end

  return sanitize(string.format('%s/%s/%s/%s.%s', judge, contest, problem_name, file_name, file_extension))
end

local function full_path(...)
  return string.format('%s/myp/problem-solving/%s', vim.loop.os_homedir(), relative_path(...))
end

return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  opts = {
    -- output_compare_method = 'exact',
    compile_command = {
      c = { exec = 'gcc', args = { '-DSAWALHY', '-Wall', '$(FNAME)', '-O3', '-o', '$(FNOEXT)' } },
      cpp = { exec = 'g++', args = { '-std=c++17', '-DSAWALHY', '-Wall', '$(FNAME)', '-O3', '-o', '$(FNOEXT)' } },
      rust = { exec = 'rustc', args = { '$(FNAME)' } },
      java = { exec = 'javac', args = { '$(FNAME)' } },
    },

    template_file = '~/myp/problem-solving/template.$(FEXT)',
    received_files_extension = 'cpp',
    received_problems_path = full_path,
    received_contests_problems_path = relative_path,
    received_contests_directory = '$(HOME)/myp/problem-solving',

    evaluate_template_modifiers = true,
    received_problems_prompt_path = false,
    received_contests_prompt_directory = false,
    received_contests_prompt_extension = false,
  },
  keys = {
    { 'cpd', ":silent ! g++ -g '%' -o '%:p:r'<CR>", desc = 'Compile cpp file with -g flag' },
    { 'cpt', ':CompetiTest receive testcases<CR>',  desc = 'Receive test cases' },
    { 'cpp', ':CompetiTest receive problem<CR>',    desc = 'Receive a problem' },
    { 'cpc', ':CompetiTest receive contest<CR>',    desc = 'Receive a contest' },
    { 'cpr', ':CompetiTest run<CR>',                desc = 'Run the current file' },
    { 'cpR', ':CompetiTest run_no_compile<CR>',     desc = 'Run the current file without compiling' },
    { 'cpe', ':CompetiTest edit_testcase<CR>',      desc = 'Edit test cases' },
    { 'cpa', ':CompetiTest add_testcase<CR>',       desc = 'Add new test case' },
  }
}

local function sanitize(path)
  return path:gsub("[%^#*!@?$%%&]", "_")
end

local function relative_path(task, file_extension)
  local hyphen = string.find(task.group, " - ")
  local judge, contest
  if not hyphen then
    judge = task.group
    contest = "unknown_contest"
  else
    judge = string.sub(task.group, 1, hyphen - 1)
    contest = string.sub(task.group, hyphen + 3)
  end

  local file_name = "main"
  if file_extension == "java" then
    file_name = task.languages.java.taskClass
  end

  if judge == "Codeforces" then
    local contest_id = string.match(task.url, "%w+/(%d+)")
    contest = contest_id .. " - " .. contest
  end

  return sanitize(string.format("%s/%s/%s/%s.%s", judge, contest, task.name, file_name, file_extension))
end

local function full_path(...)
  return string.format("%s/myp/problem-solving/%s", vim.loop.os_homedir(), relative_path(...))
end

require('competitest').setup({
  -- output_compare_method = "exact",
  compile_command = {
    c = { exec = "gcc", args = { "-DSAWALHY", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
    cpp = { exec = "g++", args = {  "-std=c++17", "-DSAWALHY", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
    rust = { exec = "rustc", args = { "$(FNAME)" } },
    java = { exec = "javac", args = { "$(FNAME)" } },
  },

  template_file = "~/myp/problem-solving/template.$(FEXT)",
  received_files_extension = "cpp",
  received_problems_path = full_path,
  received_contests_problems_path = relative_path,
  received_contests_directory = "$(HOME)/myp/problem-solving",

  evaluate_template_modifiers = true,
  received_problems_prompt_path = false,
  received_contests_prompt_directory = false,
  received_contests_prompt_extension = false,
})

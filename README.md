# My Config Files

As-salamu alaykum, this was my approach in the past: I was struggling to automate synchronization of my configurations, until I had an idea. I wanted to hard-link my config files putting them is a sub-directory `linux` in a repo also containing my window's configs.

But it seems easier to just `git init` in my ~, `$HOME`, ignore all files, exclude my config files. Unfortunately, there was some problems:
1. When I open my editor `neovim`, I have a filemanager called `NERDTree`, the workspace directory is set by default to the directory containing `.git`, in which we have `git init`ed, in our case it is `$HOME`.
2. I was using zsh in my terminal, there is a git plugin to show my current status and branch, it will always be there even if your are in `Desktop` for example.


## How I Manage Linux's config

Just hard-link all config files inside `$HOME` directory into `./linux`, we are done. But I had hard time build scripts to do this linking. See `./linux-hard-link-files.bash`, `./linux-linked*`.

To target config files, you have to include them in `./linux-linked-files.txt` the same way you ignore in `.gitignore`.

## Notes

* I don't include `.npmrc` as it contains my registry `_authToken`.

## License

MIT

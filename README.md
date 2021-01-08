# My Config Files

As-salamu alaykum, this was my approach in the past: I was struggling to automate synchronization of my configurations, until I had an idea. I wanted to hard-link my config files putting them is a sub-directory `linux` in a repo also containing my window's configs.

But it seems easier to just `git init` in my ~, `$HOME`.

Content of `.gitignore` file:

1. Ignore all: `/*`
2. Exclude a config dir, `!.config`
3. Ignore all what is inside it: `.config/*`
4. Exclude a config sub-dir, `!.config/nvim`
5. Ignore any other unnecessary stuff: `.config/nvim/plugins`

The 5th step could be replaced by add another `.gitignore` inside `~/.config/nvim`.

But what about now.

## How I Manage Linux's config

Just hard-link all config files inside `$HOME` directory into `./linux`, we are done. But I had hard time build scripts to do this linking. See `./linux-hard-link-files.bash`, `./linux-linked*`.

To target config files, you have to include them in `./linux-linked-files.txt` the same way you ignore in `.gitignore`.

## Notes

* I don't include `.npmrc` as it contains my registry `_authToken`.

## License

MIT

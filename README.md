> ##### ✋ Psst! Migrating from v1.x to v2.x? We got you. Check our [**migration guide**](https://github.com/rafaelrinaldi/pure/releases/tag/v2.0.0) and happy upgrading!

# pure [![travis-badge]][travis-link] ![fish-2.5] ![fish-2.6] ![fish-2.7.1] ![fish-3.0.0] 

> Pretty, minimal and fast Fish 🐟 prompt, ported from [`zsh`](https://github.com/sindresorhus/pure).

## Install

**:warning: requirements**: fish `≥2.5`.

### Manually

Via [cURL](https://curl.haxx.se):

```sh
# Download the installer to `/tmp`
curl https://raw.github.com/tough-griff/pure/master/tools/installer.fish --output /tmp/pure_installer.fish --location --silent
# Source and trigger the installer
source /tmp/pure_installer.fish; and install_pure
```

### [Fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher add tough-griff/pure
```

## Features

- Fully **customizable** ;
- Excellent prompt character `❯` ;
- Display current directory tail ;
- Display `git` branch name ;
  - Display `*` when `git` repository is _dirty_ ;
  - Display `⇡` when branch is _ahead_ (commits to push) ;
  - Display `⇣` when branch is _behind_ (commits to pull) ;
- Display `node` version when inside a node project ;
- Change `❯` to red when previous command has failed ;
- Update terminal title with _current folder_ and _command_ ;
- Display _username_ and _hostname_ when in an `SSH` session ;
- Display _duration_ when command run more that `5` seconds ;
- Display `Python` _virtualenv_ when activated ;
- Fine control over **colors** ;
- Right prompt control.
- Display `VI` mode and custom symbol for non-insert mode.

## Configuration

You can tweak pretty much everything in `pure` by overriding variables in your `config.fish` file.

#### Prompt Symbol

| Option                                 | Default | Description                                          |
| :------------------------------------- | :------ | :--------------------------------------------------- |
| **`pure_symbol_prompt`**               | `❯`     | Prompt symbol.                                       |
| **`pure_symbol_reverse_prompt`**       | `❮`     | VI non-insert mode symbol.                           |
| **`pure_right_prompt`**                | ` `     | Content of the right prompt.                         |
| **`pure_symbol_git_unpulled_commits`** | `⇣`     | Branch is behind upstream (commits to pull).         |
| **`pure_symbol_git_unpushed_commits`** | `⇡`     | Branch is ahead upstream (commits to push).          |
| **`pure_symbol_git_dirty`**            | `*`     | Repository is Dirty (uncommitted/untracked changes). |
| **`pure_symbol_title_bar_separator`**  | `—`     |                                                      |

:information_source:: Need [safer `git` symbols](https://github.com/sindresorhus/pure/wiki#safer-symbols)?

#### Features

| Option                                | Default | Description                                                       |
| :------------------------------------ | :------ | :---------------------------------------------------------------- |
| **`pure_threshold_command_duration`** | `5`     | Show command duration when above this value (seconds).            |
| **`pure_separate_prompt_on_error`**   | `false` | Show last command [exit code as a separate character][exit-code]. |
| **`pure_begin_prompt_with_current_directory`** | `true` | `true`: _`pwd` `git`, `SSH`, duration_.<br/>`false`: _`SSH` `pwd` `git`, duration_. |
| **`pure_reverse_prompt_symbol_in_vimode`** | `true` | `true`: `❮` indicate a non-insert mode.<br/>`false`: indicate vi mode with `[I]`, `[N]`, `[V]`.

#### Colors

| Option                   | Default               |
| :----------------------- | :-------------------- |
| **Base Colors**          |                       |
| **`pure_color_primary`** | `(set_color blue)`    |
| **`pure_color_info`**    | `(set_color cyan)`    |
| **`pure_color_mute`**    | `(set_color brblack)` |
| **`pure_color_success`** | `(set_color magenta)` |
| **`pure_color_normal`**  | `(set_color normal)`  |
| **`pure_color_danger`**  | `(set_color red)`     |
| **`pure_color_light`**   | `(set_color white)`   |
| **`pure_color_warning`** | `(set_color yellow)`  |
| **`pure_color_dark`**    | `(set_color black)`   |

:information_source:: Want more customization? See `$HOME/.config/fish/conf.d/pure.fish` for available variables.


## Tests

**requirements:** [`fishtape`](https://github.com/fisherman/fishtape).

    fishtape tests/*.test.fish

## Maintainers

- [Rafael Rinaldi](https://github.com/rafaelrinaldi)
- [Édouard Lopez](https://github.com/edouard-lopez)
- [Andrei Borisov](https://github.com/schrodincat)

Kudos to all our awesome [:yellow_heart: contributors :yellow_heart:](../..//graphs/contributors)

## License

MIT © [Rafael Rinaldi](http://rinaldi.io)

vim-pivotal-tracker-jump
========================

Using the [GitHub integration](https://www.pivotaltracker.com/help/articles/github_integration/), Pivotal Tracker stories can be referenced in Git commit messages like `[#TRACKER_STORY_ID]`.

This plugin adds functionality to `gx`, which normally opens URLs in your
default web browser. When the cursor is on a story reference press `gx` to jump
to the story in your web browser.

Installation
------------

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'm1foley/vim-pivotal-tracker-jump'
```

Customization
-------------

The URL can be customized, like for enterprise accounts which have their own
domain:

```vim
" This is the default value
let g:pivotal_tracker_jump_url = 'https://www.pivotaltracker.com/story/show/'
```

License
-------

MIT

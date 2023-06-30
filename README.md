# Dev tools

Set of scripts etc that I pull onto every computer I use.

## Installation

Install `~/.bash_profile` with this one liner. If you have an existing bash_profile file this will create a backup at
`~/.bash_profile.[current_date].backup`:
```bash
curl -o bash_profile_download https://raw.githubusercontent.com/Will-Howard/dev-tools/master/bash_profile && mv ~/.bash_profile ~/.bash_profile.$(date +%Y%m%d%H%M).backup && mv bash_profile_download ~/.bash_profile
```

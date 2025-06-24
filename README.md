# Minimal nvim configuration

My personal Neovim configuration, designed to be minimal and efficient. It includes essential plugins and settings to enhance the development experience, including VSCode integration.

## VSCode settings

Create a file named `.git/hooks/pre-commit` with the following content:

```bash
#!/bin/bash

# Run the sync script to update settings.json
$HOME/.config/nvim/.vscode/sync_settings.sh

# Exit with success to allow the commit to proceed
exit 0
```

Then run `chmod +x .git/hooks/pre-commit` to make the script executable.

This script will run before every commit, ensuring that your VSCode settings are always up to date.


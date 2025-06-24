# This script syncs the VS Code settings.json file with the Neovim configuration repository.

REPO_DIR="$HOME/.config/nvim"
SOURCE_FILE="$HOME/Library/Application Support/Code/User/settings.json"
TARGET_FILE="$REPO_DIR/.vscode/settings.json"

cd "$REPO_DIR"

# Ensure settings.json is a regular file (not a symlink) in the repo
if [ -L "$TARGET_FILE" ]; then
    rm "$TARGET_FILE"  # Remove any existing symlink
    cp "$SOURCE_FILE" "$TARGET_FILE"  # Copy the content as a regular file
fi

# Copy the latest content from the source file
cp "$SOURCE_FILE" "$TARGET_FILE"

# Stage the file if it has changed
if git status --porcelain | grep "settings.json"; then
    git add settings.json
    echo "Updated settings.json with latest content from $SOURCE_FILE"
else
    echo "No changes to settings.json"
fi

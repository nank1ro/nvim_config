# This script syncs VS Code settings and snippets with the Neovim configuration repository.

REPO_DIR="$HOME/.config/nvim"

# --- Change to repo directory ---
cd "$REPO_DIR" || exit 1

# --- Sync settings.json ---

# Settings paths
SETTINGS_SOURCE_FILE="$HOME/Library/Application Support/Code/User/settings.json"
SETTINGS_TARGET_FILE=".vscode/settings.json" # Relative to REPO_DIR

# Ensure settings.json is a regular file (not a symlink) in the repo
if [ -L "$SETTINGS_TARGET_FILE" ]; then
    rm "$SETTINGS_TARGET_FILE"
fi

# Copy the latest content from the source file
cp "$SETTINGS_SOURCE_FILE" "$SETTINGS_TARGET_FILE"

# Stage the file if it has changed
if git status --porcelain -- "$SETTINGS_TARGET_FILE" | grep -q "."; then
    git add "$SETTINGS_TARGET_FILE"
    echo "Updated settings.json with latest content."
else
    echo "No changes to settings.json."
fi

# --- Sync all snippets ---

# Source and target directories for snippets
SNIPPETS_SOURCE_DIR="$HOME/Library/Application Support/Code/User/snippets"
SNIPPETS_TARGET_DIR=".vscode/snippets" # Relative to REPO_DIR

# Create target snippets directory if it doesn't exist
mkdir -p "$SNIPPETS_TARGET_DIR"

# Check if source directory exists
if [ ! -d "$SNIPPETS_SOURCE_DIR" ]; then
    echo "Source snippets directory not found: $SNIPPETS_SOURCE_DIR"
    exit 0 # Exit gracefully if there are no snippets to sync
fi

# Loop through all json files in the source snippets directory
for snippet_source_file in "$SNIPPETS_SOURCE_DIR"/*.json; do
    # Check if it's a file and the glob found something
    if [ -f "$snippet_source_file" ]; then
        snippet_filename=$(basename "$snippet_source_file")
        snippet_target_file="$SNIPPETS_TARGET_DIR/$snippet_filename"

        # Ensure the target is a regular file (not a symlink)
        if [ -L "$snippet_target_file" ]; then
            rm "$snippet_target_file"
        fi

        # Copy the latest content from the source file
        cp "$snippet_source_file" "$snippet_target_file"

        # Stage the file if it has changed
        if git status --porcelain -- "$snippet_target_file" | grep -q "."; then
            git add "$snippet_target_file"
            echo "Updated $snippet_filename."
        else
            echo "No changes to $snippet_filename."
        fi
    fi
done

echo "Snippet sync complete."

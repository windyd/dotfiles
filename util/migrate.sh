#!/bin/bash
set -e

echo "Starting migration to home-directory targeting..."

# 1. Update .stowrc
echo "Updating .stowrc..."
cat >.stowrc <<EOF
--target=~
--ignore=.stowrc
--ignore=.DS_Store
--ignore=util
EOF

# 2. Function to migrate standard .config packages
migrate_to_config() {
  pkg=$1
  if [ -d "$pkg" ]; then
    echo "Migrating $pkg..."
    # Create a temp dir to hold current contents
    mkdir -p "${pkg}_temp"
    mv "$pkg"/* "${pkg}_temp/"

    # Create new structure inside the original package folder
    mkdir -p "$pkg/.config/$pkg"

    # Move the contents into the deep structure
    mv "${pkg}_temp"/* "$pkg/.config/$pkg/"
    rmdir "${pkg}_temp"
  else
    echo "Skipping $pkg (not found)"
  fi
}

# 3. Migrate standard packages
# These currently map to ~/.config/<pkg>/
for p in aerospace ghostty navi nvim opencode zellij; do
  migrate_to_config "$p"
done

# 4. Migrate navi-cheats specifically
# Maps to ~/.local/share/navi/cheats/
if [ -d "navi-cheats" ]; then
  echo "Migrating navi-cheats..."
  mkdir -p "navi-cheats_temp"
  mv navi-cheats/* navi-cheats_temp/

  mkdir -p "navi-cheats/.local/share/navi/cheats"

  mv navi-cheats_temp/* "navi-cheats/.local/share/navi/cheats/"
  rmdir "navi-cheats_temp"
else
  echo "navi-cheats not found, creating empty structure..."
  mkdir -p navi-cheats/.local/share/navi/cheats
  touch navi-cheats/.local/share/navi/cheats/.keep
fi

echo "Migration complete."
echo "You can now run 'stow *' or stow specific packages."

#!/bin/bash

# Ref: https://openrouter.ai/docs/guides/guides/claude-code-integration

# Name of the Bitwarden item containing the OpenRouter API key
# Change this if your item is named differently
OR_BW_ITEM_NAME="openrouter-api-key"

# Check if Bitwarden CLI is available
if ! command -v bw &>/dev/null; then
  echo "Error: 'bw' command not found. Please install Bitwarden CLI."
  return 1 2>/dev/null || exit 1
fi

# Check if logged into Bitwarden
if ! bw login --check >/dev/null 2>&1; then
  echo "Bitwarden is locked or not logged in. Please run 'bw login' or 'bw unlock' first."
  return 1 2>/dev/null || exit 1
fi

echo "Fetching OpenRouter API key from Bitwarden item: '$OR_BW_ITEM_NAME'..."
OPENROUTER_KEY=$(bw get notes "$OR_BW_ITEM_NAME")

if [ -z "$OPENROUTER_KEY" ]; then
  echo "Error: Could not retrieve API key. Check if the item '$OR_BW_ITEM_NAME' exists and has notes."
  return 1 2>/dev/null || exit 1
fi

# Configure Claude Code environment variables for OpenRouter
export ANTHROPIC_BASE_URL="https://openrouter.ai/api/v1"
export ANTHROPIC_API_KEY="$OPENROUTER_KEY"
export ANTHROPIC_AUTH_TOKEN="" # Must be empty

# Optional: Override default models if needed (examples commented out)
# export ANTHROPIC_DEFAULT_SONNET_MODEL="anthropic/claude-3.5-sonnet"
# export ANTHROPIC_DEFAULT_OPUS_MODEL="anthropic/claude-3-opus"

echo "Claude Code has been configured to use OpenRouter."

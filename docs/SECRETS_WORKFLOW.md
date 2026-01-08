# A Hitchhiker's Guide to Handling Secrets (the 1Password Way)

> **A Quick Word on Over-Engineering**
> 
> Is this whole setup a bit of over-engineering when you currently have no secrets to manage? Absolutely. But think of this as future-proofing your setup. It's far easier to build the spaceship hangar now than it is when the spaceship is actively on fire in your driveway. This document is the blueprint for that hangar.

So, you've done a great job keeping your dotfiles clean of secrets. But let's be real, you're a developer. It's only a matter of time before you need an API token for *something*. This guide is your plan for that day.

## 1. The Big Idea (aka "The Cache-to-File Trick")

We don't want to authenticate with 1Password every time we open a new terminal. That would be a drag.

The plan is simple:
1.  **You run a script ONCE.**
2.  The script asks 1Password for all your secrets.
3.  It saves them to a local, protected file (your "cache").
4.  Your shell (`zsh`) is smart enough to load this file automatically every time you open a new terminal.

**The result:** Your secrets are instantly available, every time, with no lag. It's the perfect balance between paranoid security and daily convenience.

## 2. The Moving Parts

There are three key components to this system.

### The Treasure Map (`~/.dotfiles/.config/op/secrets_manifest.json`)

This is a simple JSON file that lives in your dotfiles. It contains **no secrets**, only a map telling the script *where* to find them in 1Password.

**Example `secrets_manifest.json`:**
```json
{
  "GITHUB_TOKEN": "op://Personal/GitHub Token/token",
  "WEATHER_API_KEY": "op://Personal/Weather App/api_key"
}
```

### The Butler (`~/.dotfiles/scripts/generate-secrets.sh`)

This script is your personal butler. You hand it the treasure map, it goes to the 1Password vault, fetches everything you asked for, and neatly arranges it in your local cache file for the shell to use.

**The Butler's Code (a draft):**
```bash
#!/bin/bash
# This script reads the manifest, fetches secrets from 1Password,
# and writes them to a local cache file.

SECRETS_MANIFEST_PATH="${HOME}/.dotfiles/.config/op/secrets_manifest.json"
OUTPUT_SECRETS_FILE="${HOME}/.local/state/secrets_cache.sh"

echo "Calling the 1Password butler to prepare the secrets..."

# First, make sure the butler (op) is present and signed in.
if ! op whoami &> /dev/null; then
    echo "You need to sign in to 1Password first. Run 'op signin'."
    exit 1
fi

# Prepare the place where the secrets will be served.
mkdir -p "$(dirname "${OUTPUT_SECRETS_FILE}")"
> "${OUTPUT_SECRETS_FILE}" # Clear the old file.

# Read the map and ask the butler to fetch each item.
jq -r 'keys_unsorted[] as $key | "\($key) \(.[$key])"' "${SECRETS_MANIFEST_PATH}" | while read -r VAR_NAME OP_URI;
    echo "export ${VAR_NAME}=\"$(op read "${OP_URI}" --no-newline)\"" >> "${OUTPUT_SECRETS_FILE}"
done

# Only you are allowed to read what the butler brought.
chmod 600 "${OUTPUT_SECRETS_FILE}"

echo "Done! Secrets have been served to ${OUTPUT_SECRETS_FILE}."
```

### The Welcome Mat (`~/.zshrc`)

Add this one-liner to your `.zshrc`. It's like a welcome mat at your shell's front door that says, "Hey, before you get started, load up the secrets from here."

```bash
# Load cached secrets if they exist
if [[ -f "${HOME}/.local/state/secrets_cache.sh" ]]; then
    source "${HOME}/.local/state/secrets_cache.sh"
fi
```

## 3. How to Add a New Secret (Your Future Self Will Thank You)

When that inevitable day comes, here's the process:

1.  **Stash your secret** in 1Password.
2.  **Add a line** to your "Treasure Map" (`secrets_manifest.json`).
3.  **Summon the "Butler"**: Run `~/dotfiles/scripts/generate-secrets.sh`.
4.  **Open a new terminal.** Boom. Done. Your secret is now an environment variable.

---

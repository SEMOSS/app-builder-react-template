# App Building Agent Template

This repository provides a starting point for building and maintaining an app-building agent workspace.

## Sync Skills

Use the `sync-skills.sh` script to copy the latest skills from the [SEMOSS Platform Skills repository](https://github.com/SEMOSS/Platform-Skills) into the local `assets/client/.claude/skills` directory.

This is useful when you want the template to reflect the latest shared skill definitions.

## Important Note

Running the sync script deletes the current contents of `assets/client/.claude/skills` and replaces them with the contents from the platform skills repository.

The platform skills repository does not include this repository's `CLAUDE.md`, so review local agent-specific files after syncing.

## Run The Sync Script

```bash
cd scripts
chmod +x sync-skills.sh
./sync-skills.sh
```

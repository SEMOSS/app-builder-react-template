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

## Build And Package

Use the `build-and-package.sh` script to build the client and produce a distributable zip of the `assets/` directory.

The script will:

1. Run `pnpm install` in `assets/client`
2. Run `pnpm run build` in `assets/client`
3. Delete `assets/client/node_modules` so it isn't included in the archive
4. Create `assets.zip` at the repository root containing everything inside `assets/` (the contents are at the root of the zip — there is no wrapping `assets/` folder)
5. Run `pnpm install` again in `assets/client` to restore the local dev environment

The resulting `assets.zip` is overwritten on each run.

## Run The Build And Package Script

```bash
cd scripts
chmod +x build-and-package.sh
./build-and-package.sh
```

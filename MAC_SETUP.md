# Scratch Kitchen — Mac Setup via Opencode or Kilo

## Why Muse could not create the GitHub repo

Muse's GitHub App token returned: `403 Resource not accessible by integration`
when calling `create_repository`. That is not a setting Muse can flip in chat.
The GitHub App is installed on selected repositories only, and its token does
not have repository-creation scope. Creating a repo must be done as *you*,
not as the App — either on github.com, or with `gh` on your Mac where you
are authenticated as hamanakam1.

This file is the workaround. Paste the prompt below into Opencode or Kilo
on your MacBook. They have a shell on the Mac; Muse does not.

## Prompt to paste into Opencode / Kilo on the Mac

```
Create the public, open-source GitHub repo for Scratch Kitchen, MIT licensed.

Repo: hamanakam1/scratch-kitchen, public, MIT license.
Source files: the full scaffold is in Muse's workspace at
~/workspace/scratch-kitchen/ — copy that whole folder to
~/Projects/scratch-kitchen on this Mac first, then work from there.
If you cannot read Muse's workspace from this Mac, ask me to send the
folder, and stop — do not invent files.

Steps, in order:
1. cd ~/Projects/scratch-kitchen
2. Check git and gh: git --version, gh auth status
   - If gh is not authenticated, stop and tell me to run: gh auth login
   - Do NOT ask me for a token in chat, and do NOT paste a token anywhere.
3. git init, git add ., git commit -m "Scratch Kitchen v0.1.0 scaffold: Elixir core, SwiftUI face, MIT, extensive README"
4. Create the repo as me, public, from this folder, and push:
   gh repo create hamanakam1/scratch-kitchen --public --source=. --remote=origin --push
   - If gh repo create fails because the repo already exists, do NOT
     force-push, do NOT delete anything. Stop and report the exact error.
   - If gh is not available, stop and tell me: create the repo at
     https://github.com/new (name: scratch-kitchen, public, MIT license),
     then run: git remote add origin https://github.com/hamanakam1/scratch-kitchen.git
     and: git push -u origin main (or master, whichever git init created).
5. Verify on GitHub itself: gh repo view hamanakam1/scratch-kitchen
   Report the repo URL, visibility (must be public), and the file list.
6. Then, and only then, select scratch-kitchen in the Muse GitHub App
   installation at https://github.com/apps/meta-muse-ai/installations/new
   so Muse can read it — tell me when that selection is done.

Constraints:
- Public, open source, MIT — do not make it private unless I say so in this session.
- No credentials, no tokens, no household addresses, no real people's
  private details in any file, commit message, or repo description.
- No send, sale, delivery, or contact with any charity, neighbour, or
  delivery service. This is repo creation only.
- If any step fails, report the exact error and stop — do not retry
  blindly, do not force-push, do not delete a repo.
```

## After the repo exists

1. You select `scratch-kitchen` in the Muse GitHub App installation.
2. Tell Muse "selected" in chat.
3. Muse verifies it via GitHub (a read of the repo, not a claim that it exists).
4. From then on, Muse and Opencode can both work from the same repo —
   Opencode on the Mac with a shell, Muse via the GitHub App.

**English** | [한국어](README.ko.md)

# make-better — a Claude Code skill for vague "make it better" requests

The procedure Claude follows when asked to improve something **without being told what to change or how** — "I don't like it", "something feels off", "polish this up".

People often can't say *what* is wrong, but they can pick *which one is better*.
So instead of interrogating, Claude looks for itself, diagnoses, shows **several options that differ in direction, as real things to look at**, and lets the person choose. It never decides taste on their behalf.

Works for any target: UI · mockups · writing · design docs · code structure · balance numbers · motion · sound.

## Flow

```
 ① Look           the real thing, not memory or guesses — screenshot the screen, read the whole text, read the code
 ② Reference      don't invent "good" — past feedback · confirmed docs · parts the person was happy with · given material
                  none? → run explore-reference to find references and build one
 ③ Diagnose       3–7 pointable issues, each "what · which part of the reference it breaks"
 ④ 2–3 options    different directions (a recolor or a stronger/weaker version counts as the same one), shown as real artifacts
 ⑤ Self-filter    does it fix the diagnosis · did it drift to a bland average · does it stay in scope + mark one recommendation
 ⑥ Stop           nothing is changed before the pick — "#2" or "#1 but lighter" is enough of an answer
 ⑦ Narrow down    apply the pick → fix only what each one-line note touches → look again → save revealed taste to memory
```

| Target | How options are shown |
| --- | --- |
| Screen · UI · motion | One page with the current screen and the options side by side |
| Writing · docs | The same passage rewritten per option |
| Code structure | A draft diff of one representative file |
| Numbers · balance | Current vs. per-option values in one table + the difference in outcome |
| Sound · SFX | A loudness-matched listening page + measured comparison |

## Bundled skill — explore-reference

Called from step ② when there's no reference point. Also usable on its own: "find me references", "what has this kind of feel?".

Gathers wide (8–12 items, half deliberately scattered in direction) → takes likes/dislikes as numbers only → reads what the likes share, narrows, widens again — until "that's it", then sums up a **reference board**. It never makes options or edits the original.

## Install

```bash
git clone https://github.com/changhwan-exe/make-better.git
cd make-better
bash install.sh                     # ~/.claude/skills/ — for all your projects
bash install.sh /path/to/your-repo  # <repo>/.claude/skills/ — that repo only, shared with the team
```

Or by hand: copy `files/make-better/` and `files/explore-reference/` under `~/.claude/skills/` or `<repo>/.claude/skills/`.

## Usage

No need to call it. Say "I don't like this screen" or "polish this paragraph" and Claude reads the skill from its description. To call it directly: `/make-better` · `/explore-reference`.

- Screens, mockups and reference boards assume Claude can show an HTML page (an artifact). Where it can't, files or tables stand in.
- Claude can't hear. With a sound-analysis tool (MCP · CLI) it speaks only from the tool's results; without one it asks you to listen.
- Project instructions (`CLAUDE.md`, code rules, branch rules) are never skipped — the skill runs inside them.

> **Note:** the skill bodies are written in Korean. The procedure works the same in an English conversation.

## License

[MIT](LICENSE)

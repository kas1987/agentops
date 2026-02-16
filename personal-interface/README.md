# Personal Interface Toolkit (MVP)

Build a personal, queryable career interface from your profile + resume.

## What this includes

- `app/index.html`: local UI with
  - clean profile landing section
  - `Ask AI About Me` query experience
  - experience cards with `View AI Context` narrative layer
  - explicit skills transparency columns: Strong / Moderate / Gaps
  - bidirectional JD fit analyzer with verdicts: `strong fit`, `worth conversation`, `probably not`
- `data/profile.json`: profile data model to populate from LinkedIn/resume
- `data/resume.md`: raw resume text source
- `prompts/system-prompt.md`: anti-sycophancy prompt stack for AI-assisted mode

## Quick start

1. Edit `data/profile.json` with your real info.
2. Paste your latest resume into `data/resume.md`.
3. Run a local server from this folder:

```bash
python -m http.server 8000
```

4. Open `http://localhost:8000/app/`.

No API key is required for the deterministic MVP analyzer.

## How fit scoring works (MVP)

- Extracts role requirements from JD text (skills/keywords)
- Matches against your declared skills, domain experience, and evidence bullets
- Produces:
  - overall match score
  - confidence
  - verdict (`strong fit`, `worth conversation`, `probably not`)
  - strengths, gaps, and recommended next action

## Next step (optional AI mode)

Use `prompts/system-prompt.md` with your preferred model (Claude/OpenAI) and pass in:
- `profile.json`
- `resume.md`
- pasted JD text

This gives richer narrative reasoning while keeping the same verdict classes.

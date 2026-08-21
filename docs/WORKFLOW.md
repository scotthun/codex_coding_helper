# CCH Ideal Workflow

This diagram shows how the five CCH skills are meant to be chained together, from
picking up a ticket to getting a PR merged. Each skill is a separate Codex
invocation — you move to the next one manually once you're happy with the output
of the current one.

```mermaid
flowchart TD
    Start([New ticket / task]) --> Plan

    subgraph S1["1. Plan"]
        Plan["cch-pr-plan<br/>Analyze ticket + codebase,<br/>propose design patterns"]
        Branch["Create feature branch"]
        Blueprint["Write blueprint<br/>.cch/&lt;TICKET&gt;_blueprint.md"]
        Plan --> Branch --> Blueprint
    end

    Blueprint --> ReviewPlan{"Human reviews<br/>blueprint"}
    ReviewPlan -- "needs changes" --> Plan
    ReviewPlan -- "approved" --> Mode{"How to execute?"}

    subgraph S2a["2a. Code — step by step"]
        StepCommit["cch-code-pr-commit<br/>Next unchecked commit:<br/>tests → impl → typecheck → lint"]
        ReviewCommit{"Human reviews<br/>the commit"}
        MoreCommits{"More commits<br/>left?"}
        StepCommit --> ReviewCommit
        ReviewCommit -- "changes requested" --> StepCommit
        ReviewCommit -- "approved, commit made" --> MoreCommits
        MoreCommits -- "yes" --> StepCommit
    end

    subgraph S2b["2b. Code — all at once"]
        AllCommits["cch-code-all-pr-commits<br/>Runs every remaining commit:<br/>tests → impl → typecheck → lint → commit"]
    end

    Mode -- "one commit at a time" --> StepCommit
    Mode -- "run the whole blueprint" --> AllCommits

    MoreCommits -- "no" --> Push["Push branch to remote"]
    AllCommits --> Push

    Push --> CreatePR

    subgraph S3["3. PR"]
        CreatePR["cch-create-pr<br/>Summary, tech notes,<br/>QA scenarios from commits/diff"]
        PRDraft["Write PR description<br/>.cch/&lt;TICKET&gt;_pr.md"]
        CreatePR --> PRDraft
    end

    PRDraft --> ReviewDesc{"Human reviews<br/>PR description"}
    ReviewDesc -- "needs changes" --> CreatePR
    ReviewDesc -- "approved" --> OpenPR["gh pr create"]

    OpenPR --> ReviewPR

    subgraph S4["4. Review"]
        ReviewPR["cch-review-pr<br/>Architecture, SOLID, code smells,<br/>tests, perf, security"]
        Findings{"Findings?"}
        ReviewPR --> Findings
    end

    Findings -- "critical / important issues" --> StepCommit
    Findings -- "clean, or only minor nits" --> Merge([Merge PR])
```

## Notes on the flow

- **Plan (`cch-pr-plan`)** is the only skill allowed to touch `.cch/<TICKET>_blueprint.md`
  before code exists — no implementation happens until a human approves the blueprint.
- **Code** has two interchangeable paths that both read from the same blueprint:
  - `cch-code-pr-commit` — one commit per invocation, with a human sign-off before
    each individual commit. Best when the change is risky or exploratory.
  - `cch-code-all-pr-commits` — runs every remaining commit in one session and
    defers all human review to the PR stage. Best for well-scoped, low-risk blueprints.
- **PR (`cch-create-pr`)** only writes a description from what's already committed —
  it never changes code.
- **Review (`cch-review-pr`)** can be invoked independently of this pipeline (e.g. a
  teammate reviewing someone else's PR), but in the ideal end-to-end flow it's the
  final gate before merge. Critical/Important findings loop back into another round
  of `cch-code-pr-commit`; Minor findings don't block merging.

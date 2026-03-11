# Clean Code & Refactoring Reference

Apply these principles when writing and reviewing code. They should inform every commit, not just specific tasks.

**These are guidelines, not rigid rules.** Use judgment — readability and maintainability always win over dogma.

**Language-specific examples:** Refactoring Guru provides examples in multiple languages. For code smells, visit the smell page and follow the suggested refactoring links. For refactoring techniques, each page includes before/after examples.

---

## Core Principles

### Meaningful Names
- Names should reveal intent — a reader shouldn't need to guess what a variable, function, or class does
- Avoid abbreviations, single-letter names (except loop counters), and generic names like `data`, `info`, `temp`, `result`
- Use domain vocabulary consistently

### Small, Focused Functions
- A function should do one thing and do it well
- If you need a comment to explain what a block of code does, extract it into a well-named function
- Fewer parameters is better — if a function takes more than 3, consider an options object or breaking it up

### Single Responsibility
- Each class/module should have one reason to change
- If you find yourself describing what a class does with "and", it probably does too much

### DRY (Don't Repeat Yourself)
- Duplicated logic should be extracted — but only when the duplication is **actual** (same intent), not **coincidental** (same code, different reasons)
- Premature abstraction is worse than duplication

### Minimal Comments
- Code should be self-documenting through clear naming and structure
- Comments should explain **why**, never **what** — the code already says what
- Delete commented-out code — that's what version control is for

### Error Handling
- Handle errors at the right level — don't swallow exceptions or log-and-ignore
- Prefer exceptions over error codes
- Don't use exceptions for control flow

---

## SOLID Principles

### S — Single Responsibility Principle
A class should have only one reason to change.

[freeCodeCamp — SOLID Principles Explained](https://www.freecodecamp.org/news/solid-principles-explained-in-plain-english/)

### O — Open/Closed Principle
Open for extension, closed for modification. Add new behavior through new code, not by changing existing code.

### L — Liskov Substitution Principle
Subtypes must be substitutable for their base types without breaking behavior.

### I — Interface Segregation Principle
Clients shouldn't be forced to depend on interfaces they don't use. Prefer small, focused interfaces.

### D — Dependency Inversion Principle
Depend on abstractions, not concretions. High-level modules shouldn't depend on low-level modules.

---

## Code Smells

Code smells are indicators of deeper problems. When you spot one, consider the suggested refactoring.

[Refactoring Guru — Code Smells Catalog](https://refactoring.guru/refactoring/smells)

### Bloaters
Code that has grown too large to work with easily.

| Smell | Signal | Link |
|-------|--------|------|
| Long Method | Method is hard to follow or needs comments to explain sections | [Details](https://refactoring.guru/smells/long-method) |
| Large Class | Class has too many fields, methods, or responsibilities | [Details](https://refactoring.guru/smells/large-class) |
| Primitive Obsession | Using primitives instead of small objects (money, ranges, phone numbers) | [Details](https://refactoring.guru/smells/primitive-obsession) |
| Long Parameter List | Method takes more than 3-4 parameters | [Details](https://refactoring.guru/smells/long-parameter-list) |
| Data Clumps | Same group of variables appears together repeatedly | [Details](https://refactoring.guru/smells/data-clumps) |

### Object-Orientation Abusers
Misuse of OO principles.

| Smell | Signal | Link |
|-------|--------|------|
| Switch Statements | Complex conditionals that should use polymorphism | [Details](https://refactoring.guru/smells/switch-statements) |
| Refused Bequest | Subclass doesn't use what it inherits | [Details](https://refactoring.guru/smells/refused-bequest) |
| Temporary Field | Fields only populated in certain cases | [Details](https://refactoring.guru/smells/temporary-field) |

### Change Preventers
Code that makes changes ripple across the codebase.

| Smell | Signal | Link |
|-------|--------|------|
| Divergent Change | One class changed for many different reasons | [Details](https://refactoring.guru/smells/divergent-change) |
| Shotgun Surgery | One change requires edits across many classes | [Details](https://refactoring.guru/smells/shotgun-surgery) |

### Dispensables
Code that adds no value.

| Smell | Signal | Link |
|-------|--------|------|
| Duplicate Code | Same logic in multiple places | [Details](https://refactoring.guru/smells/duplicate-code) |
| Dead Code | Unreachable or unused code | [Details](https://refactoring.guru/smells/dead-code) |
| Lazy Class | Class doesn't do enough to justify its existence | [Details](https://refactoring.guru/smells/lazy-class) |
| Speculative Generality | Abstractions built for imagined future needs | [Details](https://refactoring.guru/smells/speculative-generality) |

### Couplers
Excessive dependency between classes.

| Smell | Signal | Link |
|-------|--------|------|
| Feature Envy | Method uses another class's data more than its own | [Details](https://refactoring.guru/smells/feature-envy) |
| Inappropriate Intimacy | Classes accessing each other's internals | [Details](https://refactoring.guru/smells/inappropriate-intimacy) |
| Message Chains | Long chains of method calls (a.b().c().d()) | [Details](https://refactoring.guru/smells/message-chains) |
| Middle Man | Class that only delegates without adding value | [Details](https://refactoring.guru/smells/middle-man) |

---

## Common Refactoring Techniques

When you identify a smell, apply the appropriate technique.

[Refactoring Guru — Refactoring Techniques Catalog](https://refactoring.guru/refactoring/catalog)

| Technique | When to Use | Link |
|-----------|-------------|------|
| Extract Method | Long method, duplicated code, code needing a comment | [Details](https://refactoring.guru/extract-method) |
| Extract Class | Large class, divergent change | [Details](https://refactoring.guru/extract-class) |
| Move Method | Feature envy — method belongs in another class | [Details](https://refactoring.guru/move-method) |
| Replace Conditional with Polymorphism | Switch statements, complex conditionals | [Details](https://refactoring.guru/replace-conditional-with-polymorphism) |
| Introduce Parameter Object | Long parameter list, data clumps | [Details](https://refactoring.guru/introduce-parameter-object) |
| Replace Magic Number with Constant | Unexplained numeric literals | [Details](https://refactoring.guru/replace-magic-number-with-symbolic-constant) |
| Decompose Conditional | Complex if/else chains | [Details](https://refactoring.guru/decompose-conditional) |
| Replace Nested Conditional with Guard Clauses | Deep nesting from edge-case checks | [Details](https://refactoring.guru/replace-nested-conditional-with-guard-clauses) |

---

## How to Apply During Development

**During planning (cch-pr-plan):**
- Note any code smells observed in the areas you'll be modifying
- Propose refactoring as part of the commit plan when it directly supports the task
- Don't plan large refactoring detours unless the ticket calls for it

**During coding (cch-code-pr-commit):**
- Follow the core principles in every line you write
- If you spot a smell in code you're modifying, fix it in the same commit if the fix is small
- For larger smells, note them but don't scope-creep — flag them for a future ticket

**During review (cch-review-pr):**
- Flag code smells by category and severity
- Suggest specific refactoring techniques with file/line references
- Distinguish between "must fix" smells and "nice to have" improvements

---

*References:*
- *[Refactoring Guru — Code Smells](https://refactoring.guru/refactoring/smells)*
- *[Refactoring Guru — Refactoring Catalog](https://refactoring.guru/refactoring/catalog)*
- *[freeCodeCamp — SOLID Principles](https://www.freecodecamp.org/news/solid-principles-explained-in-plain-english/)*

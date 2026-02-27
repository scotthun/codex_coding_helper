# Design Patterns Reference

Use this reference when analyzing a codebase and proposing an implementation approach. Identify which patterns are already in use and which would benefit the planned work.

**Do not force patterns where they aren't needed.** Only propose a pattern when it solves a real problem in the current task.

When proposing a pattern, include a short pseudocode or language-specific example showing how it maps to the current task's classes and modules.

**Language-specific examples:** Each pattern link below goes to the main Refactoring Guru page. For code examples in a specific language, append the language to the URL (e.g., `.../strategy/ruby`, `.../strategy/python`, `.../strategy/typescript`).

---

## Creational Patterns

### Factory Method
Creates objects without specifying exact classes. The creation logic is delegated to subclasses or factory functions.

**Use when:** You need to create objects of different types based on input, configuration, or context — and want to avoid a growing chain of conditionals.

[Refactoring Guru — Factory Method](https://refactoring.guru/design-patterns/factory-method)

### Builder
Constructs complex objects step-by-step, separating construction from representation.

**Use when:** An object requires many optional parameters, complex initialization, or multiple valid configurations.

[Refactoring Guru — Builder](https://refactoring.guru/design-patterns/builder)

### Singleton
Ensures a class has only one instance with a global access point.

**Use when:** Exactly one instance is needed (database connections, configuration, logging). Use sparingly — often a sign of hidden global state.

[Refactoring Guru — Singleton](https://refactoring.guru/design-patterns/singleton)

---

## Structural Patterns

### Adapter
Makes incompatible interfaces work together by wrapping one interface to match another.

**Use when:** Integrating third-party libraries, legacy code, or external APIs that don't match your internal interfaces.

[Refactoring Guru — Adapter](https://refactoring.guru/design-patterns/adapter)

### Decorator
Adds behavior to objects dynamically without modifying existing code.

**Use when:** You need to layer on responsibilities (logging, caching, validation, retry logic) without subclassing.

[Refactoring Guru — Decorator](https://refactoring.guru/design-patterns/decorator)

### Facade
Provides a simplified interface to a complex subsystem.

**Use when:** A subsystem has many classes/methods and callers only need a fraction of the functionality. Reduces coupling.

[Refactoring Guru — Facade](https://refactoring.guru/design-patterns/facade)

### Composite
Treats individual objects and compositions uniformly through a shared interface.

**Use when:** Working with tree structures (menus, file systems, org charts, UI component trees).

[Refactoring Guru — Composite](https://refactoring.guru/design-patterns/composite)

---

## Behavioral Patterns

### Strategy
Encapsulates interchangeable algorithms behind a common interface.

**Use when:** You have multiple ways to do the same thing (sorting, pricing, validation, formatting) and want to swap them without changing the caller.

[Refactoring Guru — Strategy](https://refactoring.guru/design-patterns/strategy)

### Observer
Notifies multiple objects when state changes, without tight coupling between them.

**Use when:** One object's state change should trigger updates in others (event systems, pub/sub, reactive UI).

[Refactoring Guru — Observer](https://refactoring.guru/design-patterns/observer)

### Command
Encapsulates a request as an object, allowing parameterization, queuing, and undo.

**Use when:** You need to queue operations, support undo/redo, or decouple the sender of a request from the handler.

[Refactoring Guru — Command](https://refactoring.guru/design-patterns/command)

### Template Method
Defines the skeleton of an algorithm in a base class, letting subclasses override specific steps.

**Use when:** Multiple classes share the same workflow but differ in specific steps (data processing pipelines, report generation).

[Refactoring Guru — Template Method](https://refactoring.guru/design-patterns/template-method)

### State
Alters an object's behavior based on its internal state, as if changing its class.

**Use when:** An object behaves differently depending on its current state and you want to avoid large conditional blocks.

[Refactoring Guru — State](https://refactoring.guru/design-patterns/state)

### Chain of Responsibility
Passes a request along a chain of handlers, each deciding whether to process or forward it.

**Use when:** Multiple handlers might process a request (middleware stacks, validation chains, approval workflows).

[Refactoring Guru — Chain of Responsibility](https://refactoring.guru/design-patterns/chain-of-responsibility)

---

## How to Propose Patterns in a Plan

When writing the **Design Patterns** section of a blueprint:

1. **Identify the problem** — What design challenge does this task present?
2. **Check existing patterns** — What patterns are already used in the codebase? Follow them for consistency.
3. **Propose a pattern** — Name the pattern, explain why it fits, and include a short pseudocode or language-specific example showing how it maps to the current task's classes/modules.
4. **Keep it practical** — One or two well-chosen patterns is better than over-engineering with many.

### Example

```markdown
## Design Patterns

**Strategy Pattern** — The pricing calculation varies by plan type (monthly, annual, enterprise).
Implementing a `PricingStrategy` interface with concrete strategies for each plan type keeps the
billing service clean and makes adding new plan types trivial.

**Adapter Pattern** — The new payment gateway has a different API shape than our existing
`PaymentProcessor` interface. An adapter will let us integrate without modifying existing code.
```

---

*Reference: [Refactoring Guru — Design Patterns Catalog](https://refactoring.guru/design-patterns/catalog)*

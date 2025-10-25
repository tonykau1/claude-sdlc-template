# ADR [NUMBER]: [TITLE]

**Date:** [YYYY-MM-DD]

**Status:** [Proposed | Accepted | Deprecated | Superseded]

**Deciders:** [List of people involved in the decision]

**Tags:** [architecture, database, api, frontend, etc.]

---

## Context

**What is the issue that we're seeing that is motivating this decision or change?**

Describe the forces at play, including:
- Technical constraints
- Business requirements
- Team considerations
- Timeline pressures
- Cost factors
- User needs

Be specific about the problem you're trying to solve. Include relevant background information that future readers will need to understand why this decision was necessary.

## Decision

**What is the change that we're proposing and/or doing?**

Clearly state the decision in a declarative sentence. For example:
- "We will use PostgreSQL as our primary database"
- "We will implement authentication using OAuth 2.0"
- "We will deploy using Docker containers on AWS ECS"

Explain the reasoning behind the decision. Why is this the best approach given the context?

## Consequences

**What becomes easier or more difficult to do because of this change?**

### Positive Consequences ✅
- List benefits and positive outcomes
- What problems does this solve?
- What capabilities does this enable?
- What risks does this mitigate?

### Negative Consequences ⚠️
- List drawbacks and tradeoffs
- What becomes more difficult?
- What new risks are introduced?
- What are we giving up?

### Neutral Consequences ℹ️
- Changes that are neither clearly positive nor negative
- Things we'll need to be aware of
- Future considerations

## Alternatives Considered

**What other options did we evaluate?**

For each alternative:

### Alternative 1: [Name]

**Description:** Brief description of the approach

**Pros:**
- Benefit 1
- Benefit 2

**Cons:**
- Drawback 1
- Drawback 2

**Why not chosen:** Explain why this wasn't selected

### Alternative 2: [Name]

**Description:** Brief description of the approach

**Pros:**
- Benefit 1
- Benefit 2

**Cons:**
- Drawback 1
- Drawback 2

**Why not chosen:** Explain why this wasn't selected

## Implementation Notes

**Practical details about implementation:**

- Key implementation steps
- Timeline considerations
- Dependencies or prerequisites
- Migration path (if applicable)
- Rollback strategy

## Validation

**How will we know if this decision was correct?**

- Success criteria
- Metrics to monitor
- Timeline for evaluation
- Conditions that might trigger reconsideration

## References

**Related resources:**

- Links to documentation
- Related ADRs
- Research articles
- Team discussions (Slack threads, meeting notes)
- Proof of concepts
- Benchmark results

## Notes

**Additional context:**

- Assumptions made
- Open questions
- Future considerations
- Related work

---

## Template Usage Guidelines

### When to Create an ADR

Create an ADR for decisions that:
- Are architecturally significant
- Affect multiple teams or components
- Have long-term implications
- Are difficult or expensive to reverse
- Involve significant tradeoffs
- Establish patterns others will follow

### When NOT to Create an ADR

Don't create ADRs for:
- Trivial decisions (naming a variable)
- Obvious choices with no alternatives
- Temporary workarounds
- Implementation details

### ADR Naming Convention

```
[NUMBER]-[BRIEF-DESCRIPTION].md

Examples:
001-database-choice.md
002-api-authentication.md
003-frontend-framework.md
```

### ADR Status Definitions

- **Proposed:** Decision is suggested but not yet approved
- **Accepted:** Decision is approved and active
- **Deprecated:** Decision is no longer recommended but may still be in use
- **Superseded:** Decision has been replaced (link to new ADR)

### Tips for Good ADRs

1. **Be specific:** Vague decisions lead to confusion
2. **Include context:** Future readers won't have your background
3. **Document alternatives:** Show you considered options
4. **Be honest about tradeoffs:** Every decision has costs
5. **Keep it concise:** Aim for 1-2 pages
6. **Update status:** Mark as deprecated when superseded
7. **Link related ADRs:** Build a narrative over time

### Example Real-World ADR

See `001-example-database-choice.md` for a filled-out example.

---

**Remember:** ADRs are historical records. Once accepted, they should generally not be edited (except for minor corrections). If a decision changes, create a new ADR and mark the old one as superseded.

# What's New: Auto-Activating Skills

## TL;DR

Your template now has **auto-activating skills** inspired by the [claude-code-infrastructure-showcase](https://github.com/diet103/claude-code-infrastructure-showcase). Skills appear automatically when you need them, no manual invocation required.

## Quick Comparison

| Before | After |
|--------|-------|
| Remember to check checklists | Checklists suggested automatically |
| Manually invoke agents | Skills activate based on context |
| Static documentation | Dynamic, context-aware guidance |
| Good for planned workflows | Great for both planned AND reactive work |

## What Changed?

### New: Auto-Activation System

**Before:**
```
You: "I want to implement a feature"
Claude: "Sure, let me help with that..."
```

**After:**
```
You: "I want to implement a feature"

Claude: 🎯 SKILL ACTIVATION CHECK
        📚 RECOMMENDED SKILLS:
          → sdlc-practices
          → backend-dev-guidelines

        Loading relevant guidance...
```

### New: Smart Triggering

Skills activate based on:

1. **Keywords** - "authentication", "feature", "testing", etc.
2. **Intent Patterns** - "I want to create...", "how do I...", etc.
3. **File Context** - Editing .tsx files → frontend skill
4. **Content Patterns** - Code contains "import React" → React patterns

### New: Priority System

- **Critical**: Security, guardrails (must-follow)
- **High**: Best practices (strongly recommended)
- **Medium**: Helpful suggestions
- **Low**: Optional enhancements

## What Stayed the Same?

✅ **All existing features** - Nothing removed, only enhanced
✅ **Agents** - orchestrator, architect, qa, etc. all work as before
✅ **Checklists** - Still accessible, now also auto-suggested
✅ **ADRs** - Architecture decision records unchanged
✅ **Templates** - All templates still available

## Installation (One-Time)

```bash
cd .claude/hooks
npm install
chmod +x *.sh
```

Done! Skills will now auto-activate.

## Examples

### Example 1: Implementing a Feature

**You type:** "Let me implement user authentication"

**Auto-activates:**
- ✓ sdlc-practices (quality gates)
- ✓ security-review (auth best practices)
- ✓ backend-dev-guidelines (if backend)

**Result:** Guidance appears automatically, quality gates enforced.

### Example 2: Creating UI Components

**You type:** "Create a new dashboard component"

**Auto-activates:**
- ✓ frontend-dev-guidelines (React/UI patterns)
- ✓ sdlc-practices (testing requirements)

**Result:** Component best practices loaded, testing checklist available.

### Example 3: Debugging

**You type:** "There's a bug in the payment flow"

**Auto-activates:**
- ✓ backend-dev-guidelines (if backend bug)
- ✓ testing-strategy (debugging approaches)

**Result:** Context-specific debugging guidance.

## Customization

### Adjust for Your Stack

Edit [.claude/skills/skill-rules.json](.claude/skills/skill-rules.json):

```json
{
  "backend-dev-guidelines": {
    "promptTriggers": {
      "keywords": [
        "API",
        "YOUR-FRAMEWORK",  // ← Add your terms
        "YOUR-LIBRARY"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "your-backend/**/*.ts"  // ← Your structure
      ]
    }
  }
}
```

### Add Project-Specific Skills

1. Create: `.claude/skills/my-domain/SKILL.md`
2. Configure in: `.claude/skills/skill-rules.json`
3. Test with relevant keywords

**Example:**
```json
{
  "payment-processing": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "high",
    "description": "Payment processing patterns",
    "promptTriggers": {
      "keywords": ["payment", "stripe", "checkout"]
    }
  }
}
```

## FAQ

### Q: Will this slow down Claude Code?
**A:** No. Hooks run in <100ms, skills load only when matched.

### Q: Can I disable auto-activation?
**A:** Yes. Remove hooks from `.claude/settings.json` or uninstall dependencies.

### Q: Do skills replace agents?
**A:** No, they complement them:
- **Skills**: Ongoing guidance (auto)
- **Agents**: Complex tasks (manual)

### Q: Can I create my own skills?
**A:** Absolutely! Follow the pattern in `.claude/skills/skill-developer/SKILL.md`

### Q: What if I don't have Node.js?
**A:** Skills won't auto-activate, but everything else works normally. Install Node.js to enable the feature.

### Q: Are skills compatible with my existing setup?
**A:** Yes, 100% backward compatible. Existing workflows unchanged.

## Migration Guide

### If You're Already Using This Template

**Good news:** No breaking changes!

**To enable new features:**
```bash
cd .claude/hooks
npm install
```

**To customize:**
1. Review `.claude/skills/skill-rules.json`
2. Adjust file patterns for your structure
3. Add project-specific keywords

**To disable:**
Remove hooks section from `.claude/settings.json` (but why would you? 😊)

### If You're New to This Template

Everything works out of the box after running:
```bash
cd .claude/hooks && npm install
```

## Technical Details

### Architecture

```
User Prompt
    ↓
[UserPromptSubmit Hook]
    ↓
TypeScript Analyzer
    ↓
skill-rules.json
    ↓
Match Skills
    ↓
Inject Guidance
    ↓
Claude Processes
```

### Files Added

**Core System:**
- `.claude/hooks/skill-activation-prompt.ts` - TypeScript implementation
- `.claude/hooks/UserPromptSubmit-skill-activation.sh` - Bash wrapper
- `.claude/skills/skill-rules.json` - Configuration

**Dependencies:**
- `.claude/hooks/package.json` - npm dependencies
- `.claude/hooks/tsconfig.json` - TypeScript config

**Documentation:**
- `docs/SHOWCASE-INTEGRATION.md` - Full integration guide
- `docs/WHATS-NEW.md` - This file
- `.claude/QUICK-START.md` - Quick reference

### Configuration Format

```json
{
  "skill-name": {
    "type": "domain" | "guardrail",
    "enforcement": "suggest" | "warn" | "block",
    "priority": "critical" | "high" | "medium" | "low",
    "description": "What this skill does",
    "promptTriggers": {
      "keywords": ["word1", "word2"],
      "intentPatterns": ["regex patterns"]
    },
    "fileTriggers": {
      "pathPatterns": ["**/*.ext"],
      "pathExclusions": ["**/*.test.*"],
      "contentPatterns": ["code patterns"]
    }
  }
}
```

## Credits

This enhancement is inspired by and adapted from:
- [claude-code-infrastructure-showcase](https://github.com/diet103/claude-code-infrastructure-showcase) by diet103
- 6 months of production usage managing TypeScript microservices
- Battle-tested patterns and best practices

We've adapted their auto-activation system while maintaining our comprehensive SDLC framework, creating a best-of-both-worlds solution.

## Learn More

- **Quick Start**: [.claude/QUICK-START.md](.claude/QUICK-START.md)
- **Full Guide**: [docs/SHOWCASE-INTEGRATION.md](docs/SHOWCASE-INTEGRATION.md)
- **Settings Help**: [docs/CLAUDE-SETTINGS.md](docs/CLAUDE-SETTINGS.md)
- **Hooks System**: [.claude/hooks/README.md](.claude/hooks/README.md)
- **Skills System**: [.claude/skills/README.md](.claude/skills/README.md)

## Feedback

Found a bug? Have a suggestion? Want to contribute a skill?

Issues and PRs welcome!

---

**Status:** ✅ Production Ready

Install dependencies (`npm install`) and start coding with auto-activating skills!

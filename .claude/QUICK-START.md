# Quick Start: Auto-Activating Skills

## What's New?

Your template now has **auto-activating skills** that appear when you need them!

## Zero Configuration Usage

Just use Claude Code normally. Skills will suggest themselves based on:
- **What you type**: Keywords and intent in your prompts
- **What files you edit**: File types and content patterns  
- **What you're doing**: Development phase and task type

## Example

```
You: "I want to implement a new payment feature"

Claude: 🎯 SKILL ACTIVATION CHECK
        📚 RECOMMENDED SKILLS:
          → sdlc-practices
            SDLC best practices including checklists
          → backend-dev-guidelines  
            Backend development patterns
          → security-review
            Security best practices

        Loading skills and proceeding...
```

## Installation (One-Time Setup)

```bash
cd .claude/hooks
npm install
chmod +x *.sh
```

That's it!

## How It Works

1. **You type a prompt** → Hook analyzes it
2. **Relevant skills matched** → Based on keywords, files, patterns
3. **Skills auto-load** → Context-aware guidance provided
4. **You build better code** → Quality gates enforced automatically

## Customization

### Adjust for Your Project

Edit `.claude/skills/skill-rules.json`:

```json
{
  "backend-dev-guidelines": {
    "fileTriggers": {
      "pathPatterns": [
        "YOUR-PATH/**/*.ts"  // ← Change to your structure
      ]
    }
  }
}
```

### Add Your Own Skills

1. Create: `.claude/skills/my-skill/SKILL.md`
2. Add to: `.claude/skills/skill-rules.json`
3. Test by using relevant keywords

## Troubleshooting

**Skills not activating?**
```bash
cd .claude/hooks && npm install && chmod +x *.sh
```

**Need different patterns?**
Edit `.claude/skills/skill-rules.json` to match your:
- File structure
- Keywords/terminology  
- Workflow

## Learn More

- Full guide: `docs/SHOWCASE-INTEGRATION.md`
- Settings help: `docs/CLAUDE-SETTINGS.md`
- Hook system: `.claude/hooks/README.md`
- Skills system: `.claude/skills/README.md`

---

**TL;DR**: Install deps once (`npm install`), then skills activate automatically as you code. Magic!

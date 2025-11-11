#!/usr/bin/env node
/**
 * Skill Activation Hook (TypeScript Implementation)
 *
 * This hook analyzes user prompts and file context to automatically
 * suggest relevant skills based on configured rules in skill-rules.json.
 *
 * Features:
 * - Keyword matching in user prompts
 * - Intent pattern matching with regex
 * - File path pattern matching
 * - Content pattern detection
 * - Priority-based skill grouping
 * - Enforcement levels (suggest, block, warn)
 *
 * Usage: Called automatically by Claude Code's UserPromptSubmit hook
 */

import { readFileSync } from 'fs';
import { join } from 'path';

interface HookInput {
  session_id: string;
  transcript_path: string;
  cwd: string;
  permission_mode: string;
  prompt: string;
  files_context?: string[];
}

interface PromptTriggers {
  keywords?: string[];
  intentPatterns?: string[];
}

interface FileTriggers {
  pathPatterns?: string[];
  pathExclusions?: string[];
  contentPatterns?: string[];
}

interface SkillRule {
  type: 'guardrail' | 'domain';
  enforcement: 'block' | 'suggest' | 'warn';
  priority: 'critical' | 'high' | 'medium' | 'low';
  description: string;
  promptTriggers?: PromptTriggers;
  fileTriggers?: FileTriggers;
  blockMessage?: string;
  skipConditions?: {
    sessionSkillUsed?: boolean;
    fileMarkers?: string[];
    envOverride?: string;
  };
}

interface SkillRules {
  version: string;
  description: string;
  skills: Record<string, SkillRule>;
  notes?: any;
}

interface MatchedSkill {
  name: string;
  matchType: 'keyword' | 'intent' | 'file-path' | 'file-content';
  config: SkillRule;
  matchDetails?: string;
}

/**
 * Check if prompt matches any keywords
 */
function matchesKeywords(prompt: string, keywords: string[]): boolean {
  const promptLower = prompt.toLowerCase();
  return keywords.some(kw => promptLower.includes(kw.toLowerCase()));
}

/**
 * Check if prompt matches any intent patterns
 */
function matchesIntentPatterns(prompt: string, patterns: string[]): boolean {
  return patterns.some(pattern => {
    try {
      const regex = new RegExp(pattern, 'i');
      return regex.test(prompt);
    } catch (err) {
      console.error(`Invalid regex pattern: ${pattern}`, err);
      return false;
    }
  });
}

/**
 * Check if any file context matches path patterns
 */
function matchesFilePatterns(
  filesContext: string[] | undefined,
  pathPatterns: string[],
  pathExclusions?: string[]
): { matches: boolean; matchedFile?: string } {
  if (!filesContext || filesContext.length === 0) {
    return { matches: false };
  }

  for (const file of filesContext) {
    // Check exclusions first
    if (pathExclusions) {
      const excluded = pathExclusions.some(exclusion => {
        try {
          const regex = new RegExp(exclusion.replace(/\*\*/g, '.*').replace(/\*/g, '[^/]*'));
          return regex.test(file);
        } catch {
          return false;
        }
      });
      if (excluded) continue;
    }

    // Check inclusions
    const included = pathPatterns.some(pattern => {
      try {
        const regex = new RegExp(pattern.replace(/\*\*/g, '.*').replace(/\*/g, '[^/]*'));
        return regex.test(file);
      } catch {
        return false;
      }
    });

    if (included) {
      return { matches: true, matchedFile: file };
    }
  }

  return { matches: false };
}

/**
 * Main hook execution
 */
async function main() {
  try {
    // Read input from stdin
    const input = readFileSync(0, 'utf-8');
    let data: HookInput;

    try {
      data = JSON.parse(input);
    } catch (parseError) {
      // If JSON parse fails, try to extract prompt from raw input
      console.error('Failed to parse input as JSON, attempting fallback');
      process.exit(0);
    }

    const prompt = data.prompt?.toLowerCase() || '';
    const filesContext = data.files_context || [];

    // Load skill rules
    const projectDir = process.env.CLAUDE_PROJECT_DIR || data.cwd || process.cwd();
    const rulesPath = join(projectDir, '.claude', 'skills', 'skill-rules.json');

    let rules: SkillRules;
    try {
      rules = JSON.parse(readFileSync(rulesPath, 'utf-8'));
    } catch (err) {
      console.error('Could not load skill-rules.json. Skill activation disabled.');
      process.exit(0);
    }

    const matchedSkills: MatchedSkill[] = [];

    // Check each skill for matches
    for (const [skillName, config] of Object.entries(rules.skills)) {
      let matched = false;
      let matchType: MatchedSkill['matchType'] = 'keyword';
      let matchDetails = '';

      // Check prompt triggers
      const promptTriggers = config.promptTriggers;
      if (promptTriggers && prompt) {
        // Keyword matching
        if (promptTriggers.keywords && matchesKeywords(prompt, promptTriggers.keywords)) {
          matched = true;
          matchType = 'keyword';
          matchDetails = 'Prompt keyword match';
        }

        // Intent pattern matching
        if (!matched && promptTriggers.intentPatterns && matchesIntentPatterns(prompt, promptTriggers.intentPatterns)) {
          matched = true;
          matchType = 'intent';
          matchDetails = 'Prompt intent pattern match';
        }
      }

      // Check file triggers
      const fileTriggers = config.fileTriggers;
      if (!matched && fileTriggers) {
        // Path pattern matching
        if (fileTriggers.pathPatterns) {
          const fileMatch = matchesFilePatterns(
            filesContext,
            fileTriggers.pathPatterns,
            fileTriggers.pathExclusions
          );
          if (fileMatch.matches) {
            matched = true;
            matchType = 'file-path';
            matchDetails = `File match: ${fileMatch.matchedFile}`;
          }
        }
      }

      if (matched) {
        matchedSkills.push({
          name: skillName,
          matchType,
          config,
          matchDetails
        });
      }
    }

    // Generate output if matches found
    if (matchedSkills.length > 0) {
      // Sort by priority
      const priorityOrder = { critical: 0, high: 1, medium: 2, low: 3 };
      matchedSkills.sort((a, b) => {
        return priorityOrder[a.config.priority] - priorityOrder[b.config.priority];
      });

      let output = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n';
      output += '🎯 SKILL ACTIVATION CHECK\n';
      output += '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n';

      // Group by priority
      const critical = matchedSkills.filter(s => s.config.priority === 'critical');
      const high = matchedSkills.filter(s => s.config.priority === 'high');
      const medium = matchedSkills.filter(s => s.config.priority === 'medium');
      const low = matchedSkills.filter(s => s.config.priority === 'low');

      if (critical.length > 0) {
        output += '⚠️  CRITICAL SKILLS (REQUIRED):\n';
        critical.forEach(s => {
          output += `  → ${s.name}\n`;
          output += `    ${s.config.description}\n`;
          if (s.config.enforcement === 'block') {
            output += `    🚫 BLOCKS execution until used\n`;
          }
        });
        output += '\n';
      }

      if (high.length > 0) {
        output += '📚 RECOMMENDED SKILLS:\n';
        high.forEach(s => {
          output += `  → ${s.name}\n`;
          output += `    ${s.config.description}\n`;
        });
        output += '\n';
      }

      if (medium.length > 0) {
        output += '💡 SUGGESTED SKILLS:\n';
        medium.forEach(s => {
          output += `  → ${s.name}\n`;
          output += `    ${s.config.description}\n`;
        });
        output += '\n';
      }

      if (low.length > 0) {
        output += '📌 OPTIONAL SKILLS:\n';
        low.forEach(s => {
          output += `  → ${s.name}\n`;
        });
        output += '\n';
      }

      output += 'ACTION: Use Skill tool to load relevant skills before responding\n';
      output += '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n';

      console.log(output);
    }

    process.exit(0);
  } catch (err) {
    console.error('Error in skill-activation-prompt hook:', err);
    process.exit(1);
  }
}

main().catch(err => {
  console.error('Uncaught error:', err);
  process.exit(1);
});

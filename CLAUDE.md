# Project Instructions for Claude

## File Operations

**IMPORTANT**: NEVER use bash commands (cat, echo, printf, etc.) with output redirection (`>`, `>>`, `<<`) for file operations.

- ALWAYS use the **Write tool** for creating new files
- ALWAYS use the **Edit tool** for modifying existing files
- Reserve bash exclusively for actual system commands and terminal operations (git, npm, docker, etc.)

This ensures better error handling, proper file permissions, and a better user experience.

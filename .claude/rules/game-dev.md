# Game Development Session Rules

- All code lives in a single `index.html` — never create separate JS/CSS files
- Every edit must leave the game openable and testable in Chrome
- Use geometric primitives (fillRect, arc) — no external assets
- All timers use delta-time accumulation in the game loop, NOT setTimeout/setInterval
- Speed formula: `baseSpeed * tokenMultiplier * (stunned ? 0 : 1)`
- AABB collision: simple rectangle overlap checks for all entities
- Named constants at top of script for all magic numbers
- Section banners: `// === SECTION ===` to organize code
- resetState() returns a fresh object — never mutate existing state on restart

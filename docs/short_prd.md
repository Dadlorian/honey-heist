This is the perfect way to execute this project. You want to hand the AI a blueprint that is so specific it doesn't have room to hallucinate complex 3D rendering or massive file systems.

Here is your detailed PRD, the tech stack, asset sourcing, and the exact prompt to feed your coding AI.

### The Master Prompt for Your AI Agent

*Copy and paste this exact block into the AI you are using to code the game.*

> **Role:** You are an expert front-end game developer specializing in vanilla JavaScript and HTML5 Canvas.
> **Task:** Build a complete, playable 2D arcade game called "Cyber-Thor's Honey Heist". The entire game must exist within a single `index.html` file. All HTML, CSS, and JavaScript must be inline. The game must run natively in Google Chrome with no build steps, no external libraries (no React, no Phaser), and no local server required.
> **Visuals:** For now, use simple geometric primitives (`fillRect`, `arc`) to represent the player, enemies, and items.
> **Mechanics & Logic:**
> * **Canvas:** Fixed resolution (e.g., 800x600), centered on the screen with a dark '#111' background.
> * **Player:** A blue square ("Blocky Thor"). Moves using WASD or Arrow keys. Bounded by the canvas edges.
> * **Items (Spawn randomly, disappear on collection):**
> * *Pollen (Yellow circles):* Fills a "Pollen Bar". When the bar reaches 10, it converts into "Honey" (Score +100) and the bar resets.
> * *Tokens (Gold squares):* Spawns rarely. Collecting one permanently increases player speed by 10%.
> 
> 
> * **Enemies (Spawn randomly at edges, move in straight lines across the screen):**
> * *Queen Bee (Red rectangles):* Fast, small.
> * *Loki/Doom (Purple rectangles):* Slow, large, tracks the player's position slightly.
> 
> 
> * **Collision:** If the player touches an enemy, they lose 1 of 3 lives. If lives reach 0, trigger a Game Over screen with a Restart button.
> * **Wildcard Events (Use `setTimeout` / `setInterval`):**
> * *Lightning Zap:* Every 15-20 seconds, the screen flashes white, and the player is "stunned" (speed becomes 0) for 1.5 seconds.
> * *God Cloud:* Every 30 seconds, display floating text at the top: "YOU ARE THE BEE! GET OUT OF MY BUSINESS!" for 3 seconds.
> * *Optimus Rage:* If the player collects a rare Blue Token, they turn red, double in size, and become invincible to enemies for 5 seconds (destroying enemies on touch for +50 bonus points).
> 
> 
> 
> 
> **Output:** Provide ONLY the raw code for `index.html`. Ensure the game loop uses `requestAnimationFrame`.

---

### Image Generation Prompts (For Gemini)

When you are ready to replace the colored squares with actual graphics, you can use my image generation capabilities (powered by the Nano Banana model, which is excellent at 2D compositions).

Here are the prompts to generate your assets. *Note: Ask me to generate these one at a time so we can refine them!*

* **Blocky Thor:** "A 2D 16-bit pixel art sprite of a blocky, Minecraft-style character dressed as Thor, holding a small hammer. Clean white background, flat lighting, facing right."
* **Enemies:** "A 2D 16-bit pixel art sprite sheet featuring a mechanical Queen Bee and a blocky, comic-book style villain in a green hood. Clean white background, simple arcade style."
* **Background:** "A seamless 2D scrolling background for a video game. The scene is a cybernetic cloud-scape: fluffy clouds mixed with glowing neon blue circuitry and metallic structures. Dark sky, cyberpunk aesthetic, 16-bit pixel art style."
* **Collectibles:** "A 2D 16-bit pixel art sprite of a glowing yellow pollen orb and a shiny gold tech-token. Clean white background."

*(Pro-tip: Once generated, you can use a free online tool to remove the white background and save them as transparent `.png` files, then convert those PNGs to Base64 strings to paste directly into your AI's `index.html` file!)*

---

### Sourcing Free Sound Effects (No Paywalls or Ads)

Do not waste time on sites that require credit card sign-ups or blast you with pop-ups. Use these two resources for completely free, public domain audio:

1. **Freesound.org:** This is a massive, community-driven platform where you can easily filter your search engine to only show CC0 (Creative Commons Zero) results. Setting the search to CC0 means the sounds are public domain, completely free for commercial or personal use, and require absolutely no attribution. You do need to create a free account to download the files, but there is no paywall.
2. **ZapSplat (CC0 Section):** While ZapSplat operates on a freemium model for their premium library, they have a dedicated CC0 1.0 Universal License section. The sounds under this specific license are dedicated to the public domain, meaning you can download and modify them for your game without asking permission or paying.

*For this game, search for:* "8-bit jump", "retro coin pickup", "synth laser", and "thunder strike".

Would you like me to go ahead and run that AI prompt myself to generate the foundational `index.html` code right now so you can immediately test the movement and mechanics?
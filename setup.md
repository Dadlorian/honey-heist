This is a brilliant project. Game jams with 13-year-olds are a blast, but you are 100% correct to worry about scope. If you don't box them in, they will ask for a multiplayer open-world RPG, and the AI will spit out a broken, unplayable mess that takes days to fix.

To get a working 2D browser game generated and playable in 30 to 60 minutes, the game needs a single core mechanic, a basic win/loss state, and zero complex level design.

Here are the six targeted questions to give your son and his friends. They are phrased to sound fun to a teenager while secretly acting as strict parameters for the AI.

The 6 Scope-Controlling Questions
1. The Action: "What is the one main thing your character does?"

(Give them choices: Jump over obstacles, catch falling items, dodge things coming at you, or click targets.)

Why this works: It forces them to pick a single "verb" (jumping, dodging, catching). This dictates the entire physics engine the AI needs to write.

2. The Hero: "Who or what are you playing as?"

(Tell them to keep it simple: a flying taco, a neon cube, a grumpy cat, a guy on a skateboard.)

Why this works: It gives the game its flavor without adding mechanical complexity. The AI will represent this as a simple square or a basic emoji/placeholder image in the browser.

3. The Danger: "What is the one main thing trying to stop you?"

(Examples: falling anvils, lasers shooting across the screen, a giant rolling boulder.)

Why this works: It limits the enemy logic. Instead of pathfinding AI or complex combat, the AI just has to code objects moving in a straight line that the player must avoid.

4. The World: "Where does this take place?"

(Examples: outer space, a messy bedroom, inside a volcano, a retro neon grid.)

Why this works: This gives the AI the color palette and background aesthetic. It sets the vibe without requiring actual level design.

5. The Rules: "How do you win or get a high score?"

(Give them choices: Survive for 60 seconds to win, collect 20 items to win, or just survive as long as possible for a high score before losing 3 lives.)

Why this works: This is the most important scoping question. It gives the AI a definitive, mathematically simple win/loss state to code.

6. The Wildcard: "What is one funny or weird 'bonus' that happens?"

(Examples: When you grab a power-up you get massive for 3 seconds, a funny sound effect plays when you jump, or the enemies speed up over time).

Why this works: 13-year-olds love absurd humor. This gives them a sense of creative ownership and a fun "twist" without breaking the underlying code.

How the AI Will Build It
When you take their answers and feed them to the AI, the AI is going to construct a standard HTML5 Canvas game. To help you understand what the AI is actually generating (and why keeping the answers simple is so vital), it helps to visualize the core engine running under the hood.

Every game the AI makes will rely on that loop: reading the kid's keyboard input, updating the math (moving the Taco left, moving the Anvil down), and drawing the new frame to the screen. By restricting their answers to simple movements and a single goal, you ensure the "Update" and "Draw" phases are lightweight enough for the AI to code perfectly on the first or second try.

Tips for Your AI Prompt
When you are ready to "sic the AI on it," use a prompt structured like this:

"Write a complete, single-file HTML5 Canvas 2D game. It must contain all HTML, CSS, and JavaScript in one file so I can just double-click it in my browser. Here is the design:

Mechanic: [Answer 1]

Player: [Answer 2]

Enemy: [Answer 3]

Setting: [Answer 4]

Win Condition: [Answer 5]

Twist: [Answer 6]
Use simple primitive shapes (squares, circles) or basic emojis for the graphics. Do not use external image files. Keep the physics simple and ensure there is a clear 'Game Over' screen with a restart button."

Would you like me to act as the game engine right now, so we can run a quick 3-minute practice round where I generate a game based on some dummy answers?
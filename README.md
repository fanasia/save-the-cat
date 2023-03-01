# Save The Cats v.1.0.1

This game is my first game! 

**Game Concept**

You are a little girl in a small village. You like cats so much, thus you have a lot of them. But! The witches are trying to steal them, because for them, more cats means more power. Therefore, you try to keep them protected. But again! Cats are uncontrollable by nature. They will do what they want, they will go whenever they want. So you endlessly save as many cats as you can!

**Control**

Save as many cats as you can before the time runs out by putting them in the center circle of the map. The center circle is a safe zone, which means the witch can not steal the cat when it’s inside the circle. But cats are uncontrollable! This means that even after you put the cats in the circle, they will move again not long after. You also need to protect them before the witch steals them. The game will end when the time runs out and your score will be counted by the number of cats inside the circle when the game ends.

The input in this game is keyboard.

Arrow Key (Up, Right, Down, Left) / AWSD: Control movement of the player
Space bar: pick up and put down cats
Alt: pause game

**Technology**
Godot

**Working Demo (Google Drive)**
https://drive.google.com/file/d/1w3P2R0NwuzBq1itstSdgN0CWw6LvyuUE/view?usp=sharing

**Link Free Assets**
Maps: https://cainos.itch.io/pixel-art-top-down-basic
Character: Commission by my friend Naufal Tan (https://naufaltan.itch.io/) 
https://drive.google.com/drive/folders/1OINLY1ugZfp29Ux7BrsW0KJyv33uohB0
Music: 
Rhythmic 8Bit Audio https://musicbroz.itch.io/free-samples-of-musicbroz-1 
Cat SFX: Sweet Kitty Meow
https://mixkit.co/free-sound-effects/cat/


**Current Bugs**

There are still some bugs that I haven’t succeeded in fixing them yet. There are:
1. Fix the direction of the cat sprite
This is half-fixed. Sometimes, the sprite of the cat still not correct, for example when the cat move the left, the sprite is to the right. Or even it’s upside down. Still could not fixed this even though I already spent the last 2 days only for this. 
2. Also when you pick up 2 cats it will only become 1
This bug is happened because I loop all the cats in the player cat-detection zone and pick it up without counting the cats in the zone, or put any limitation to be able only pick 1 cat. 
3. When moving diagonally, the player animation stuck in 1 frame
This bug is because I only code for the 4 movement and not handling the diagonal one. Have no idea how to fix this yet, and this is also minor.
Further Improvement

**Next Version**
My initial vision for this game is the girl is also a witch and will have some spells she can use depending on the number of cats she currently has. The spell will have an effect for example time stop, barrier around the safe zone so the cats can not go out anymore, mimics, etc. 

Another improvement is to put more levels and make things difficult bit by bit. There will be more challenges at further levels such as the safe zone becoming smaller, or the witches who steal cats can also do some spells.

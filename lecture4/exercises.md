## Exercise 2:
Find the number of words (in `/usr/share/dict/words`) that contain at least three `a`s and don’t have a `'s` ending. What are the three most common last two letters of those words? `sed`’s `y` command, or the `tr` program, may help you with case insensitivity. How many of those two-letter combinations are there? And for a challenge: which combinations do not occur?

#### a) First, find all words with 3 `a`'s on them: (help of chat gpt)

That can be acomplished using this regex: `[^a]*a[^a]*a[^a]*a`
## Exercise 3:
To do in-place substitution it is quite tempting to do something like `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a bad idea, why? Is this particular to `sed`? `Use man sed` to find out how to accomplish this.

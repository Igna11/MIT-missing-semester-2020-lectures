## Exercise 2:
Find the number of words (in `/usr/share/dict/words`) that contain at least three `a`s and don’t have a `'s` ending. What are the three most common last two letters of those words? `sed`’s `y` command, or the `tr` program, may help you with case insensitivity. How many of those two-letter combinations are there? And for a challenge: which combinations do not occur?

- a) First, find all words with 3 `a`'s on them: (help of chat gpt)

That can be acomplished using this regex: `[^a]*a[^a]*a[^a]*a`. While `[^a]*` takes care of not matching any non `a`characters, the literal `a` matches a literal `a`. Repeating the patterns ensures that we are matching the desired number of `a`'s.

- b) Avoid all words that end in `'s`:
Adding the following: `[^('s)]$` ensures that words finished in `'s` are not being matched.Here `^('s)` means that the regex has to avoid the group `'s`. The `$` sign means that it has to be the end of the line.
	- b.1) By now the regex has a problem. Words like `Antofagasta` will be matched and it has 4 `a`'s. That is because I am not considering uppercase letters. So, the regex should be `
[^(A|a)]*(A|a)[^a]*a[^a]*a` so it ignores `A`'s at the begining of the word if there is already 3 `a`'s and to match `A` if there is 3 `a`'s. And finally, I have to add the `\b` at the beggining of the regex in order to specify the word boundary. Without the `\b`, the regex will match words like `parliamentarian` with 4 `a`'s.

- c) Top 3 letters most common letters of the two ending letters of every word. With help of chatgpt.
	- c.1) Reverse the words with `rev`, so for example `malarial -> lairalam`
	- c.2) Insert a white space every two characters: `lairalam -> la ir al am` using `sed's/(..)/\1/g'`
	- c.3) Keep only the first two letters: `la ir al am -> la` using `awk {print $1}`
	- c.4) Sort using  `sort`
	- c.5) Count repetitions using `uniq -c` 

### Complete solution:
```sh
cat /usr/share/dict/wrds | grep -P "\b[^(a|A)]*(a|A)[^a]*a[^a]*a[^('s)]$" | rev | sed -r 's/(..)/\1 /g' | awk '{print $1}' | sort | uniq -c
```
## Exercise 3:
To do in-place substitution it is quite tempting to do something like `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a bad idea, why? Is this particular to `sed`? `Use man sed` to find out how to accomplish this.

- a) According to chatgpt, this is a bad idea because: "because the shell will first truncate the file input.txt before sed even starts processing it. This means that the input file will be empty before sed can read it, and therefore, nothing will be written back to it. So, instead of performing the substitution in-place, you should use a temporary file to write the output and then move the temporary file back to the original file." 
- b) To accomplish this I can do `sed 's/REGEX/REPLACE/' --in-place input.txt`.

## Exercise 4:
Find your average, median, and max system boot time over the last ten boots. Use journalctl on Linux and log show on macOS, and look for log timestamps near the beginning and end of each boot. 
I used this [link](https://github.com/shapeng1998/missing-semester-solutions/blob/main/Lecture%204/Solutions.md) as a reference to solve this excercise.

- a) I need to capture the following log: `Startup finished in`, so I use `grep` as follows:
```sh
journalctl | grep -E "Startup finished in (\w.?)+ (kernel)+"
```
which takes care of fetching the logs containing the desired message. The result is a message of this form
```sh
abr 07 22:25:27 igna-[...]systemd[1]: Startup finished in 6.644s (kernel) + 12.495s (userspace) = 19.139s.
```
- b) Now I need to keep the last seconds. But I don't want the `s.`. So, lets remove it using `sed -E "s/s.$//"` The result would be
```sh
abr 07 22:25:27 igna-[...]systemd[1]: Startup finished in 6.644s (kernel) + 12.495s (userspace) = 19.139
```
- c) Now I only want the last seconds, so I remove everything else using `sed` again: `sed -E "s/(.*) = (.*)/\2/"`. Where there are two groups defined and I am telling `sed` to replace both groups with only the last one, in this case the seconds. The result would be
```sh
19.139
```
- d) Finally, I will use python to manipulate the data and get the statistics:
```sh
python -c 'import sys; x = sys.stdin.read().split("\n"); x.pop(); times = list(map(float, x)); import numpy as np; print("mean:", np.mean(times)); print("median:", np.median(times));print("max:", np.max(times))'
``` 
The whole solution is:
```sh
journalctl | grep -E "Startup finished in (\w\.?)+ \(kernel\) \+" | sed -E "s/s.$//" | sed -E "s/(.*) = (.*)/\2/" | python -c 'import sys; x = sys.stdin.read().split("\n"); x.pop(); times = list(map(float, x)); import numpy as np; print("mean:", np.mean(times)); print("median:", np.median(times));print("max:", np.max(times))'
```
## Exercise 5:
Look for boot messages that are not shared between your past three reboots (see journalctl’s -b flag). Break this task down into multiple steps. First, find a way to get just the logs from the past three boots. There may be an applicable flag on the tool you use to extract the boot logs, or you can use `sed '0,/STRING/d'` to remove all lines previous to one that matches STRING. Next, remove any parts of the line that always varies (like the timestamp). Then, de-duplicate the input lines and keep a count of each one (`uniq` is your friend). And finally, eliminate any line whose count is 3 (since it was shared among all the boots).

## Exercise 6:
Find an online data set like [this one](https://stats.wikimedia.org/EN/TablesWikipediaZZ.htm), [this one](https://ucr.fbi.gov/crime-in-the-u.s/2016/crime-in-the-u.s.-2016/topic-pages/tables/table-1), or maybe one [from here](https://www.springboard.com/blog/data-science/free-public-data-sets-data-science-project/>). Fetch it using curl and extract out just two columns of numerical data. If you’re fetching HTML data, `pup` might be helpful. For JSON data, try `jq`. Find the min and max of one column in a single command, and the difference of the sum of each column in another.

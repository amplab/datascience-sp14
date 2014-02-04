## Regular Expressions

#### Basic Expressions

The simplest regular expressions are alphanumeric strings, e.g., `/pattern/`,
will match the substring `"pattern"`.

#### Wild Cards and Quantifiers

The character `.` matches any character, so for example, the pattern `/.ed/`
will match all of `"sed"` and `"bed"` and `"1ed"`.

Quantifiers match the preceding expression multiple times.  There are several
quantifier expressions:

* `*` matches the preceding expression 0 or more times 
* `+` matches the prededing expression 1 or more times 
* `?` matches the preceding expression 0 or 1 times
* `{n}` matches the preceding expression `n` times, where `n` is a number

Combine wild cards with quantifiers to match arbitrary strings, e.g., `/.*ed/`
matches all of `"sed"`, `"ed"`, and `"foo bar baz ed"`.

#### Character Sets

Sometimes `.` is too powerful a wildcard, and what you really want is to match
some characters but not others.  Character sets let you do that.  A character
set is composed of square brackets around the characters you want to match.

For example, `[AEIOU]` matches any uppercase vowel.  You can also invert the
character set with a `^` after the `[`, i.e., `[^AEIOU]` matches anything BUT an
uppercase vowel.  For convenience, you may also list character ranges, e.g.,
`[A-Z]` or `[0-9]`.

#### Beginning and End of a String

You can match the start and end of a string with `^` and `$`, respectively.  As
we will see with `sed` and `awk`, regular expressions are often evaluated line
by line over a file, and in these instances `^` and `$` refer to the start and
end of the line.



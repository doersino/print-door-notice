# print-door-notice

*Fire off a single command to print out a notice that's ready to be taped to a door, letting passers-by know about room changes or other matters.*

For an example output, see [`door-notice.pdf`](door-notice.pdf).


## Usage

```
./print-door-notice.sh [--print] HEADING [DETAILS]
```

If the `--print` flag is supplied, the script invokes the `lpr` utility, which will attempt to send the generated PDF to the default printer configured on your system. If the flag is missing, the generated PDF `door-sign.pdf` will end up in your current working directory.

Requires `pdftex` and some packages that should come with most LaTeX distributions.

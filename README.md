# *Timewave* / *I Ching* 
Appendix I (pages 201 to 207) and Appendix III (pages 223 to 227) from the 1975 print of *The Invisible Landscape* contained three *Fortran* programs, which appear to be of the *Fortran 66* dialect.

The goal of this repository is to get these original *Fortran* programs updated to work with modern compilers.

Currenly, there is nothing which runs found in this repository.

### Barriers
- The programs were originally written for a *CDC 6400* mainframe,
  - All files have a header which states:
    - `RUN FORTRAN COMPILER VERSION 2.3 B.3`
- All copies of the 1975 text print were flawed, the source code is nearly illegible.
- The `WAVEC` subroutine was not included in the text, and does not appear to be a standard definition available anywhere.

# Build
The `tests/` directory contains two *Fortran IV* programs for checking the development environment, they are [from wikibooks.org](https://en.wikibooks.org/wiki/Fortran/Fortran_examples#Simple_Fortran_IV_program).

After installing `f2c`, they may be compiled like so:

`f2c -ext -h -72 -onetrip test1.f && cc -o test1 test1.c -lf2c -lm`

**or**

After installing `gfortran`, they may be compiled like so:
`gfortran -ffixed-form -fmax-identifier-length=7 ./test1.f`

# Standards 
The [*Fortran 66* standard](https://archive.org/details/ansi-x-3.9-1966-fortran-66/page/n7/mode/2up?view=theater) was inspired by *Fortran IV*.

### Column Numbers are *Minus One*
Note that in the above [linked standard, section *3.2*](https://archive.org/details/ansi-x-3.9-1966-fortran-66/page/8/mode/2up?view=theater), talks about the first column as *Column 1*, but most modern text editors call this *Column 0*.

The standard dictates that statements must begin on **column 7**, which will reflect as **column 6** in most modern text editors.

Furthermore, *line continuation* characters (any character other than the digit 0 or the character blank) are dictated to appear in **column 6**, which will reflect as **column 5** in most modern text editors.

...and so on.

# Credits
*McKenna's Timewave* is the original work of *Terence K. McKenna* and *Dennis J. McKenna*, they were assisted by at least *Leon Taylor* with their *Fortran* program -- their original work is found in the `originals/` directory of this repository.

Their original work was published in Appendix I and III of *The Invisible Landscape*.

The code was painfully transcribed by *ultasun* after much squinting, and after that it did not compile -- so the modified versions which do compile will be found in the top level of this repository.

### Outside help so far

The fortran channel, on libera.chat, user `Irvise` contributed [this patch](https://paste.debian.net/1256532/), and this compilation string for `iching.f`
- `gfortran -ffixed-form -ffixed-line-length-none -w -std=legacy`
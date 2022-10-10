# *I Ching* in *Fortran 66*

Fortran 66 programs.

# Build
After installing `f2c`, this may be used:

`f2c -ext -h -72 -onetrip test1.f && cc -o test1 test1.c -lf2c -lm`

**or**

`gfortran -ffixed-form -fmax-identifier-length=7 ./test1.f`

# Standards 
The [*Fortran 66* standard](https://archive.org/details/ansi-x-3.9-1966-fortran-66/page/n7/mode/2up?view=theater) was inspired by *Fortran IV*.

### Column Numbers are *Minus One*
Note that in the above [linked standard, section *3.2*](https://archive.org/details/ansi-x-3.9-1966-fortran-66/page/8/mode/2up?view=theater), talks about the first column as *Column 1*, but most modern text editors call this *Column 0*.

The standard dictates that statements must begin on **column 7**, which will reflect as **column 6** in most modern text editors.

Furthermore, *line continuation* characters (any character other than the digit 0 or the character blank) are dictated to appear in **column 6**, which will reflect as **column 5** in most modern text editors.

...and so on.

# Credits

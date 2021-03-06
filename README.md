# Code review - Intro to make

[Manual available here.](https://www.gnu.org/software/make/manual/make.html)

Main content of a makefile: rules

```
targets … : prerequisites …
        recipe
        …
        …
```

TAB character at the beginning of every recipe line!

***

```sh
$ cd /to/the/git/repo
```

Normally you should call your makefile either `makefile` or `Makefile`. 
If not, use `-f` or `--file` option.

makefile_test1:

```makefile
test1_double.txt : test1.txt
  cp test1.txt test1_double.txt
```

```sh
$ make -f makefile_test1
```

Run again:

```sh
$ make -f makefile_test1
```

***

Let's try to create a pipeline.

makefile_test2:

```makefile
test1_double.txt : test1.txt
  cp test1.txt test1_double.txt
  
test2_double.txt : test2.txt
  cp test2.txt test2_double.txt
```

```sh
$ make -f makefile_test2
```

By default, make starts with the first target which is called the _default_goal_ 
and processes only rules whose targets are prerequisits of the goal.  

Makefiles are usually written so that the first target is for compiling 
the entire program.

Or you can tell make which targets to update:

```sh
$ make -f makefile_test2 test2_double.txt
```

## Phony Targets

makefile_test2b:

```makefile
.PHONY: all
all : test1_double.txt test2_double.txt

test1_double.txt : test1.txt
  cp test1.txt test1_double.txt
  
test2_double.txt : test2.txt
  cp test2.txt test2_double.txt
```

```sh
$ make -f makefile_test2b
```

## % and $*

makefile_test2c:

```makefile
.PHONY: all
all : test1_double.txt test2_double.txt

%_double.txt : %.txt
  cp $*.txt $*_double.txt
```

```sh
$ make -f makefile_test2c
```


## Variables

To make your life simpler.

makefile_cool1:

```makefile
VAR := Gosia

.PHONY: one

one:
  echo "$(VAR) is coool!"
```


```sh
$ make -f makefile_cool1
```

```sh
$ make -f makefile_cool1 VAR="Helen"
```

## Multiple line definition

```makefile
VAR := Gosia
VARS := Gosia Padu Cate Luka

.PHONY: all one multiple

all: one multiple

one:
  echo "$(VAR) is coool!"

multiple: $(foreach i,$(VARS),multiple_$(i))

define print_name
multiple_$(1):
  echo "$(1) is coool!"
endef
$(foreach i,$(VARS),$(eval $(call print_name,$(i))))
```

```sh
$ make -f makefile_cool2 VAR="Helen Lukas"
$ make -f makefile_cool2 VARS="Helen Lukas"
```

Other useful functions:

- returns the n-th word of text *`$(word n,text)`*

```makefile
SERVERS := penticton taupo
$(word, 1, $(SERVERS))
```

## R CMD BATCH

makefile_r1:

```makefile
RWD := .
RCODE := rcode
ROUT := rout

FILES := test1 test2

### Define the default rule
.PHONY: all
all: mkdir_rout plot_barplot_goal

### Make sure no intermediate files are deleted
.SECONDARY:

.PHONY: mkdir_rout
mkdir_rout:
  mkdir -p $(ROUT)


define calculate_sum
$(1)_sum.txt: $(1).txt $(RCODE)/01_calculate_sum.R
  R CMD BATCH --no-restore --no-save "--args rwd='$(RWD)' outdir='.' \
path_file='$(1).txt' prefix='$(1)_'" \
$(RCODE)/01_calculate_sum.R $(ROUT)/01_calculate_sum.Rout
endef
$(foreach i,$(FILES),$(eval $(call calculate_sum,$(i))))


.PHONY: plot_barplot_goal
plot_barplot_goal: $(foreach i,$(FILES),$(i)_barplot.pdf)

define plot_barplot
$(1)_barplot.pdf: $(1)_sum.txt $(RCODE)/02_barplot.R 
  R CMD BATCH --no-restore --no-save "--args rwd='$(RWD)' \
outdir='.' path_file='$(1)_sum.txt' prefix='$(1)_' color='red'" \
$(RCODE)/02_barplot.R $(ROUT)/02_barplot.Rout
endef
$(foreach i,$(FILES),$(eval $(call plot_barplot,$(i))))
```

```sh
$ make -f makefile_r1
```


## .SECONDARY

Make sure no intermediate files are deleted.
 
```makefile
.SECONDARY:
```

## --touch or -t

Marks targets as up to date without actually changing them.

## JSON

`rjson` [package](https://www.tutorialspoint.com/r/r_json_files.htm) 
to import jason files into R.


























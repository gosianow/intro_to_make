### Code review - Intro to make

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
cd /to/the/git/repo
```

Normally you should call your makefile either `makefile` or `Makefile`. If not, use `-f` or `--file` option.

makefile_test1:

```makefile
test1_double.txt : test1.txt
  cp test1.txt test1_double.txt
```

```sh
make -f makefile_test1
```

Run again:

```sh
make -f makefile_test1
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
make -f makefile_test2
```

By default, make starts with the first target which is called the _default_goal_ and processes only rules whose targets are prerequisits of the goal.  

You can tell make which targets to update:

```sh
make -f makefile_test2 test2_double.txt
```

***
# Phony Targets

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
make -f makefile_test2b
```













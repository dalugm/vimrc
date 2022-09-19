let current_compiler = "c"
CompilerSet makeprg=clang\ %\ -o\ %<
CompilerSet errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m

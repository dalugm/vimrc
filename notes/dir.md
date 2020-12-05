# directory

## general

```
./vim
  ├── after
  ├── autoload
  ├── colors
  ├── compiler
  ├── doc
  ├── ftdetect
  ├── ftplugin
  ├── indent
  ├── plugin
  ├── spell
  └── syntax
```

- `~/.vim/after` 这里面的文件也会在 `vim` 每次启动的时候加载，不过是等待`~/.vim/plugin/` 加载完成之后才加载 `after` 里的内容，所以叫做`after` 。

- `~/.vim/autoload` 它是一个非常重要的目录，尽管听起来比实际复杂。简而言之，它里面放置的是当你真正需要的时候才被自动加载运行的文件，而不是在`vim` 启动时就加载。library functions (loaded lazily)

- `~/.vim/colors` 是用来存放 `vim` 配色方案的。

- `~/.vim/plugin` 存放的是每次启动 `vim` 都会被运行一次的插件，也就是说只要你想在`vim` 启动时就运行的插件就放在这个目录下。global commands/mappings (loaded on startup)

- `~/.vim/ftdetect` 中的文件同样也会在 `vim` 启动时就运行。有些时候可能没有这个目录。`ftdetect` 代表的是 `filetype detection（文件类型检测）` 。此目录中的文件应该用自动命令（autocommands）来检测和设置文件的类型，除此之外并无其他。也就是说，它们只该有一两行而已。

- `~/.vim/ftplugin` 此目录中的文件有些不同。filetype plugin functions (loaded for the specified filetype)当 `vim` 给缓冲区的 `filetype` 设置一个值时， `vim` 将会在 `~/.vim/ftplugin` 目录下来查找和`filetype` 相同名字的文件。例如你运行 `set filetype=derp` 这条命令后，`vim` 将查找 `~/.vim/ftplugin/derp.vim` 此文件，如果存在就运行它。

    不仅如此，它还会运行 `ftplugin` 下相同名字的子目录中的所有文件，如`~/.vim/ftplugin/derp` 这个文件夹下的文件都会被运行。每次启用时，应该为不同的文件类型设置局部缓冲选项，如果设置为全局缓冲选项的话，将会覆盖所有打开的缓冲区。

- `~/.vim/indent` 这里面的文件和 `ftplugin` 中的很像，它们也是根据它们的名字来加载的。它放置了相关文件类型的缩进。例如 `python` 应该怎么缩进， `java` 应该怎么缩进等等。其实放在 `ftplugin` 中也可以，但单独列出来只是为了方便文件管理和理解。

- `~/.vim/compiler` 和 `indent` 很像，它放的是相应文件类型应该如何编译的选项。

- `~/.vim/doc` 是为插件放置文档的地方。例如 `:help` 的时候可以用到。

- `~/.vim/spell` 拼写检查脚本。

- `~/.vim/syntax` 语法描述脚本。

## plugin

On vim8, vim has a internal package mananger.

Details can be finded in `:help packages`

### Global plugin

```
GLOBAL PLUGIN (macros/plugin)

system       plugin directory ~
Unix         ~/.vim/plugin/
PC           $HOME/vimfiles/plugin or $VIM/vimfiles/plugin
Amiga        s:vimfiles/plugin
Macintosh    $VIM:vimfiles:plugin
macOS        ~/.vim/plugin/
```

### Filetype plugin

```
FileType PLUGIN (ftplugin)

The scripts in $VIMRUNTIME/macros are global ones, the filetype
plugins are in $VIMRUNTIME/ftplugin.

If for some files there is already a ftplugin, you can separate
them by a underscore (_)

The underscore is used to separate the name of the filetype from the rest,
```

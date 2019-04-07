## Vim-Settings

This is a vim setting for Yuchen Wang, a dev in Microsoft MMX team.  

### Build

To build this vim setting is very simple:  

First, clone it into your local computer:  

```
git clone https://github.com/Aaron19960821/vim_settings ~/.vim
```

We use vim-plug to manage all plugins we install, please update the plugins
with the following command:
```
:PlugInstall
```

Currently we use **cquery** for code completion. To install cquery, please follow this way:
```
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
cmake --build .
cmake --build . --target install
```



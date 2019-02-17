# Py_make | Python Makefile [![Build Status](https://travis-ci.org/jaytarang92/py_make.svg?branch=master)](https://travis-ci.org/jaytarang92/py_make)

Py_make is a Makefile that builds a python version you desire in a local work space.

## Prerequisites
  - Ubuntu/Debian
    ```sh
    $ sudo apt install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev
    $ sudo apt install libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev libffi-dev
    ```

## Examples

  - Build Python 3.8.0a1
    ```sh
    $ make PYTHON_VERSION=3.8.0 PYTHON_SUB_VERSION=a1
    ```
  - Build Python 3.7.2
      ```sh
      $ make PYTHON_VERSION=3.7.2
      ```
  - Build Python 3.7.2 in a specific location
    *Default is $HOME/py_$PYTHON_VERSION*
    ```sh
    $ make PYTHON_VERSION=3.7.2 PYTHON_INSTALL_PATH=/tmp/py_tmp_install
    ```

# ssh-keychain-stub

Workaround for the Big Sur issue that prevents `ssh-keychain.dylib` from working with ssh-add.

## Pre-requisites

- XCode Command Line Tools

## Installation

```shell
make install
```

## Usage

```shell
$ ssh-add -s /usr/local/lib/ssh-keychain-stub.dylib
Enter passphrase for PKCS#11: 
Card added: /usr/local/lib/ssh-keychain-stub.dylib

$ ssh-add -e /usr/local/lib/ssh-keychain-stub.dylib
Card removed: /usr/local/lib/ssh-keychain-stub.dylib
```

This is a project for creating vm image with latest ubuntu and some tools for cpp development using packer.

- [ubuntu-clang.pkr.hcl](ubuntu-clang.pkr.hcl)  Settings for packer
- [user-data](http/user-data)  Settings for ubuntu's autoinstall
- [dockerfile](http/dockerfile)  Dockerfile for check user-data's script
- [check.sh](http/check.sh) check user-data's script
- [meta-data](http/meta-data) Mandatory file for ubuntu's autoinstall

In directory "download" it needs to download iso of ubuntu desktop 24.10 and named it as ubuntu.iso

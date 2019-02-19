@echo off
set path=c:\tools\cygwin\bin;%path%
set
echo %path%
set VS140COMNTOOLS=""
rem libetpan
rem cyg-get dos2unix patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget libsasl2_3 libsasl2-devel
rem cyg-get dos2unix libiconv-devel patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget gcc doxygen libllvm5 libclang5 libedit0 libxapian30 cmake libsasl2_3 libsasl2-devel
cyg-get patch alternatives autoconf autoconf2 autoconf2 automake base-cygwin base-files bash binutils bzip2 ca-certificates cmake coreutils cygutils cygwin cygwin-devel dash desktop-file-utils diffutils dos2unix editrights file findutils gamin gawk gcc-core gcc-g++ getent grep groff gsettings-desktop-schemas gzip hostname info ipc-utils less libarchive13 libargp libatomic1 libattr1 libblkid1 libbz2_1 libcom_err2 libcrypt0 libcurl4 libdb5 libexpat1 libext2fs2 libfam0 libfdisk1 libffi6 libgc1 libgcc1 libgdbm4 libglib2 libgmp10 libgnutls30 libgomp1 libgssapi_krb5_2 libguile2 libhogweed4 libiconv libiconv2 libidn2_0  libintl8 libisl15 libjson-c-common libjson-c-devel libjson-c2 libjsoncpp19 libk5crypto3 libkrb5_3 libkrb5support0 libltdl7 liblz4_1 liblzma5 libmpc3 libmpfr6 libncursesw10 libnettle6 libnghttp2_14 libopenldap2_4_2 libopenssl100 libp11-kit0 libpcre1 libpipeline1 libpopt-common libpopt0 libpsl5 libquadmath0 libreadline7 librhash0 libsasl2-devel libsasl2_3 libsigsegv2 libslang2 libsmartcols1 libsqlite3-devel libsqlite3_0 libssh2_1 libssp0 libstdc++6 libtasn1_6 libtool libunistring2 libuuid-devel libuuid1 libuv1 libxml2 login m4 make man-db mc mintty nano ncurses openssl openssl-devel p11-kit p11-kit-trust perl perl-Carp perl-Test-Harness perl-TimeDate perl_autorebase perl_base pkg-config publicsuffix-list-dafsa python3 rebase run sed shared-mime-info tar terminfo texinfo tzcode tzdata unzip util-linux vim-minimal w32api-headers w32api-runtime wget which windows-default-manifest xz zlib-devel zlib0 git
echo check installed
sh cygcheck -c
uname -a
dos2unix step1-bzip.sh
sh step1-bzip.sh

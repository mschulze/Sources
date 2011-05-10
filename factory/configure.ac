dnl # emacs edit mode for this file is -*- sh -*-
dnl # $Id$

dnl #
dnl # configure.in - process this file with `autoconf' to generate
dnl #	a `configure' script.
dnl #
dnl # See the `INSTALL' file for information on how the `configure'
dnl # script works.
dnl #

#
# - initialisation.
#
AC_INIT([factory], [3.1.2.sw])
AC_CONFIG_SRCDIR(canonicalform.cc)
AC_CONFIG_MACRO_DIR([../m4])
AC_CONFIG_HEADER(config.h)
AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE

AC_PROG_YACC

#
# Do not change version here!!!
#
dnl #
dnl # Change version here, do not believe the comment in the
dnl # preceding lines.
dnl #
factory_version="3.1.3"
factory_configuration="'$ac_configure_args' in `pwd`"

#
# - check withs and enables.
#
AC_ARG_WITH(
  memman,
  [  --with-memman(=<memman>) specify Factory memory manager.
                          <memman> is either \`old' (default), \`new', or \`no'.],
  ,
  [ if test "x$with_Singular" = xyes; then
      with_memman=no
    else
      with_memman=old
    fi ])

# font-lock-trick: '

AC_ARG_WITH(
  omalloc,
  [  --with-omalloc           build for use with omalloc])

AC_ARG_WITH(
  Singular,
  [  --with-Singular         build for use with computer algebra system Singular.],
  ,
  with_Singular=no)

AC_ARG_ENABLE(
  cf-inline,
  [  --enable-cf-inline      build Factory with \"configurable inline methods\"
                          enabled.],
  ,
  enable_cf_inline=no)

AC_ARG_ENABLE(
  streamio,
  [  --disable-streamio      build Factory without stream IO],
  ,
  [ if test "x$with_Singular" = xyes; then
      enable_streamio=no
    else
      enable_streamio=yes
    fi ])

AC_ARG_ENABLE(
  memdebug,
  [  --enable-memdebug=<level> switch on memory management debugging.  Meaningful
                          with \`--with-memman=new' only.  <level> may be either
                          \`no' (default), \`normal', or \`full'.],
  ,
  enable_memdebug=no)

AC_ARG_ENABLE(
  assertions,
  [  --enable-assertions     build Factory with assertions activated],
  ,
  enable_assertions=no)

AC_ARG_ENABLE(
  timing,
  [  --enable-timing         build Factory so it will print timing information],
  ,
  enable_timing=no)

AC_ARG_ENABLE(
  debugoutput,
  [  --enable-debugoutput    build Factory so it will print debugging information],
  ,
  enable_debugoutput=no)

#
# - check for CC and CXX but be careful about CFLAGS.
#
test "${CFLAGS+set}" = set || cflags_expl_set=no
AC_PROG_CC
test "${CXXFLAGS+set}" = set || cxxflags_expl_set=no
AC_PROG_CXX
if test "x$GCC" != xyes && test "x$GXX" != xyes; then
  AC_MSG_WARN(you better use gcc to compile Factory)
else
  if test "x$GXX" = xyes && test "x$cxxflags_expl_set" = xno; then
    AC_MSG_WARN([we use \`-O2 -fomit-frame-pointer' as default for \`CXXFLAGS'
                    (instead of the configure default \`-g -O')])
  fi
  if test "x$GCC" = xyes && test "x$cflags_expl_set" = xno; then
    AC_MSG_WARN([we use \`-O2 -fomit-frame-pointer' as default for \`CFLAGS'
                    (instead of the configure default \`-g -O')])
  fi
fi

#
# - check for some other programs.
#
AC_PROG_CPP
AC_PROG_CXXCPP
AC_PROG_LN_S
AC_PROG_INSTALL
AC_PROG_RANLIB
AC_PROG_MAKE_SET
AC_CHECK_PROG(AR, ar, ar, where-is-your-ar)
AC_CHECK_PROG(M4, m4, m4, where-is-your-m4)
AC_CHECK_PROG(BISON, bison, bison, where-is-your-bison)
DX_INIT_DOXYGEN($PACKAGE_NAME, MYDOXYGENCONFIG)

# do not use `MKINSTALLDIRS' and `MAKEHEADER' since there may be
# name clashes with other peoples configure scripts via
# `config.cache'.  Furthermore, we do not use cache at all to
# avoid some nasty problems with our own development environment.
unset ac_cv_path_FACTORY_MKINSTALLDIRS
unset ac_cv_path_FACTORY_MAKEHEADER
save_path="$PATH"
PATH="$PATH:$srcdir/bin"
AC_PATH_PROG(FACTORY_MKINSTALLDIRS, mkinstalldirs, -mkdir)
PATH="$srcdir/bin:$save_path"
AC_PATH_PROG(FACTORY_MAKEHEADER, makeheader)
PATH="$save_path"

#
# - expand paths.
#

AC_MSG_CHECKING(and generating explicit install paths)

# generate Makefile
save_prefix="$prefix"
save_exec_prefix="$exec_prefix"
test "x$prefix" = xNONE && prefix=$ac_default_prefix
test "x$exec_prefix" = xNONE && exec_prefix='${prefix}'
for dir in prefix exec_prefix bindir sbindir libexecdir \
	   datadir sysconfdir sharedstatedir localstatedir libdir \
	   includedir oldincludedir infodir mandir; do
  eval "dir_value=\$$dir"
  cat >> ./conftest.mk << EXPLPATHEOT
$dir=$dir_value
explicit_$dir:
	@ echo \$($dir)
	@ if echo \$($dir) | grep '^/'; \\
	then echo \$($dir) > ./conftest.dir; \\
	else echo \`pwd\`/\$($dir) > ./conftest.dir; fi
EXPLPATHEOT
done
prefix="$save_prefix"
exec_prefix="$save_exec_prefix"

# generate the explicit paths
make >&5 2>&1 -f ./conftest.mk explicit_datadir
explicit_datadir=`cat ./conftest.dir`
make >&5 2>&1 -f ./conftest.mk explicit_libdir
explicit_libdir=`cat ./conftest.dir`
make >&5 2>&1 -f ./conftest.mk explicit_includedir
explicit_includedir=`cat ./conftest.dir`

# clean up
rm -f ./conftest.mk ./conftest.dir

AC_MSG_RESULT(done)

#
# - check for libraries.
#
AC_CHECK_LIB(m, atof, , [ AC_MSG_ERROR(libm.a not found) ])

LB_CHECK_GMP(3.1.1,,AC_MSG_ERROR([Unable to find GMP on your machine: please use --with-gmp=PATH_TO_DIR_CONTAINING_LIB_AND_INCLUDE (see also ./configure --help if you do not understand what we are talking about)]))

LB_CHECK_NTL(5.0,,AC_MSG_WARN([Unable to find NTL (which is strongly recommended) on your machine: please use --with-ntl=PATH_TO_DIR_CONTAINING_LIB_AND_INCLUDE (see also ./configure --help if you do not understand what we are talking about)]))

# arithmetic shift
#AC_MSG_CHECKING(whether your compiler does arithmetic shifts)
#AC_CACHE_VAL(ac_cv_shift,
#  [ LDFLAGS="-L$explicit_libdir $LDFLAGS"
#	AC_TRY_RUN(
#      [ int main() { if (-2 >> 1 == -1) return(0); else return(1); } ],
#      ac_cv_shift=yes, ac_cv_shift=no, ac_cv_shift=yes) ])
#if test "x$ac_cv_shift" = xyes; then   
#  AC_MSG_RESULT(yes)
#else
#  AC_MSG_RESULT(no)
#fi

#
# - check for header files.
#
AC_LANG_CPLUSPLUS

AC_CHECK_HEADERS(stdio.h stdlib.h string.h time.h math.h, ,
  [ AC_MSG_ERROR(C header files not found) ])
AC_CHECK_HEADERS(cstdio)

if test "x$enable_streamio" != xno; then
  AC_CHECK_HEADERS(iostream.h strstream.h fstream.h iostream string fstream)
  AC_CHECK_HEADERS(ctype.h, , [ AC_MSG_ERROR(standard C header files not found) ])

  # since the FTE will compile only with stream IO enabled we will not
  # check for the necessary header files if stream IO is disabled
  AC_CHECK_HEADERS(stdarg.h signal.h errno.h unistd.h, ,
    [ AC_MSG_WARN(C/C++ header files not found.
                    You will not be able to build the Factory Test Environment
                    (though Factory itself should compile)) ])
fi

if test "x$enable_timing" != xno; then
  AC_CHECK_HEADERS(sys/param.h sys/times.h, ,
    [ AC_MSG_ERROR(\`sys/times.h' or \`sys/param.h' not found.  Try
                  \`configure --disable-timing') ])
fi

AC_CHECK_HEADERS(omalloc.h,,)

# font-lock-trick: '

#
# - check for compiler characteristics.
#

# use C to check compiler characteristics instead of C++.  On
# nextstep, checking with C++ may fail.
AC_LANG_C

# cross-compiling ?!
#AC_C_CROSS
#if test "x$cross_compiling" = xyes; then
#  AC_MSG_WARN([you better specify a cache file to get the values for
#                    cross-compiling right (e.g., call \`configure
#                    --cache-file=yourTarget.cache').  In particular, you
#                    should make sure that your target machine supports
#                    arithmetic shift.])
#fi

# font-lock-trick: '

#
# - paths.
#

# note that Singular has its own mechanism to search the tables,
# hence we do not need to mind it here
gftabledir='${datadir}/factory/gftables'
explicit_gftabledir="$explicit_datadir/factory/gftables"

# for installation of the templates
templatedir='${includedir}/templates'

#
# - the name of the game and the targets to create.
#
if test "x$with_Singular" = xyes; then
  libfactory=libfactory.a

  factorysrc='$(basefactorysrc) $(singfactorysrc)'
  factoryincl='$(basefactoryincl) $(singfactoryincl)'
  memmansrc=
  memmanincl=

  alltargets=cf
  installtargets=installcf
  uninstalltargets=uninstallcf
else
  libfactory=libcf.a

  factorysrc='$(basefactorysrc)'
  factoryincl='$(basefactoryincl)'
  memmansrc='$(basememmansrc)'
  memmanincl=

  alltargets=cf
  installtargets=installcf
  uninstalltargets=uninstallcf
fi

#
# - set defines and variables according to our tests.
#

# CFLAGS
if test "x$GCC" = xyes && test "x$cflags_expl_set" = xno; then
  CFLAGS="-O2 -fomit-frame-pointer"
fi

# CXXFLAGS
if test "x$GXX" = xyes && test "x$cxxflags_expl_set" = xno; then
  CXXFLAGS="-O2 -fomit-frame-pointer"

AC_LANG_SAVE
AC_LANG_CPLUSPLUS
# check whether CXX accepts -fno-rtti
AC_MSG_CHECKING(whether gcc accepts -fno-rtti)
tmp_flags=${CXXFLAGS}
CXXFLAGS="${CXXFLAGS} -fno-rtti"
AC_CACHE_VAL(ac_cv_cxx_have_rtti,
AC_TRY_COMPILE(,,ac_cv_cxx_have_rtti=yes,ac_cv_cxx_have_rtti=no)
)
AC_MSG_RESULT(${ac_cv_cxx_have_rtti})
CXXFLAGS=$tmp_flags
if test "${ac_cv_cxx_have_rtti}" = yes; then
CXXFLAGS="$CXXFLAGS -fno-rtti"
fi

AC_MSG_CHECKING(whether gcc accepts -fno-exceptions)
tmp_flags=${CXXFLAGS}
CXXFLAGS="${CXXFLAGS} -fno-exceptions"
AC_CACHE_VAL(ac_cv_cxx_have_exceptions,
AC_TRY_LINK(,,ac_cv_cxx_have_exceptions=yes,ac_cv_cxx_have_exceptions=no)
)
AC_MSG_RESULT(${ac_cv_cxx_have_exceptions})
CXXFLAGS=$tmp_flags
if test "${ac_cv_cxx_have_exceptions}" = yes; then
CXXFLAGS="$CXXFLAGS -fno-exceptions"
fi
AC_LANG_RESTORE

fi

# ARFLAGS
test "${ARFLAGS+set}" = set || ARFLAGS=cr

# M4FLAGS
test "${M4FLAGS+set}" = set || M4FLAGS=

# Singular
if test "x$with_Singular" = xyes; then
  AC_DEFINE([SINGULAR],[1],[SINGULAR])
fi

# arithmetic shift
#if test "x$ac_cv_shift" = xyes; then   
#  AC_DEFINE([HAS_ARITHMETIC_SHIFT],[1],[HAS_ARITHMETIC_SHIFT])
#fi

AC_MSG_CHECKING(whether to use omalloc)

if test "$with_omalloc" = yes; then
  if test "$ac_cv_header_omalloc_h" != yes; then
    if test "$enable_omalloc" = yes; then
       warn_omalloc=yes
    else
       with_omalloc=no
    fi
  fi
else
  if test "$with_omalloc" != no; then
    if test "$enable_omalloc" = yes; then
      if test "$ac_cv_header_omalloc_h" != yes; then
        warn_omalloc=yes
      fi
      with_omalloc=yes
    else
      with_omalloc=no
    fi
  fi
fi
if test "$with_omalloc" = yes; then
  AC_DEFINE([HAVE_OMALLOC],[1],[HAVE_OMALLOC])
  with_memman=no 
fi
AC_MSG_RESULT($with_omalloc)
if test "$warn_omalloc" = yes; then
  AC_MSG_WARN(did not find omalloc.h -- install before compiling)
fi

    
# memory manager
if test "x$with_memman" = xyes; then
  alltargets="$alltargets mem"
  installtargets="$installtargets installmem"
  uninstalltargets="$uninstalltargets uninstallmem"
  AC_DEFINE([USE_MEMUTIL],[1],[USE_MEMUTIL])

  if test "x$with_memman" != xnew; then
    memmansrc="$memmansrc \$(oldmemmansrc)"
    memmanincl='$(oldmemmanincl)'
    AC_DEFINE([USE_OLD_MEMMAN],[1],[USE_OLD_MEMMAN])
  else
    memmansrc="$memmansrc \$(newmemmansrc)"
    memmanincl='$(newmemmanincl)'

    if test "x$enable_memdebug" = xfull; then
      AC_DEFINE([MDEBUG], [1], [MDEBUG])
    elif test "x$enable_memdebug" != xno; then
      AC_DEFINE([MDEBUG], [0], [MDEBUG])
    fi
  fi
fi

# "configurable inline methods"
if test "x$enable_cf_inline" != xno; then
  AC_DEFINE([CF_USE_INLINE],[1],[CF_USE_INLINE])
fi

# iostream
if test "x$enable_streamio" = xno; then
  AC_DEFINE([NOSTREAMIO],[1],[NOSTREAMIO])
else
  factorysrc="$factorysrc \$(useiofactorysrc)"
  factoryincl="$factoryincl \$(useiofactoryincl)"
fi

# assertions
if test "x$enable_assertions" = xno; then
  AC_DEFINE([NOASSERT],[1],[NOASSERT])
fi

# timing
if test "x$enable_timing" != xno; then
  AC_DEFINE([TIMING],[1],[TIMING])
fi

# debugoutput
if test "x$enable_debugoutput" != xno; then
  AC_DEFINE([DEBUGOUTPUT],[1],[DEBUGOUTPUT])
fi

#
# - complete and substitute variables, defines.
#
AC_SUBST(gftabledir)
AC_SUBST(templatedir)

AC_SUBST(factory_version)

AC_SUBST(libfactory)

AC_SUBST(ARFLAGS)
AC_SUBST(M4FLAGS)
AC_SUBST(MAKEHEADERFLAGS)

AC_SUBST(factorysrc)
AC_SUBST(factoryincl)
AC_SUBST(memmansrc)
AC_SUBST(memmanincl)

AC_SUBST(alltargets)
AC_SUBST(installtargets)
AC_SUBST(uninstalltargets)

AC_DEFINE_UNQUOTED([FACTORYVERSION], "$factory_version", [FACTORYVERSION])
AC_DEFINE_UNQUOTED([FACTORYCONFIGURATION], "$factory_configuration", [FACTORYCONFIGURATION])
AC_DEFINE_UNQUOTED([GFTABLEDIR], "$explicit_gftabledir", [GFTABLEDIR])

AC_OUTPUT(Makefile ftest/GNUmakefile)
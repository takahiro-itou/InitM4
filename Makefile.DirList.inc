
##
##    共通設定ファイル。
##

##
##
##    List of Directories.
##

PROJECT_SOURCE_DIR      =  @top_srcdir@
PROJECT_BINARY_DIR      =  @top_builddir@

inctop_dir_name         =  @inctop_dir_name@
INCPKG_DIR_NAME         =  @INCPKG_DIR_NAME@
libtop_dir_name         =  @libtop_dir_name@

INCTOP_SOURCE_DIR       =  ${PROJECT_SOURCE_DIR}/${inctop_dir_name}
INCTOP_BINARY_DIR       =  ${PROJECT_BINARY_DIR}/${inctop_dir_name}
LIBTOP_SOURCE_DIR       =  ${PROJECT_SOURCE_DIR}/${libtop_dir_name}
LIBTOP_BINARY_DIR       =  ${PROJECT_BINARY_DIR}/${libtop_dir_name}

INCPKG_SOURCE_DIR       =  ${INCTOP_SOURCE_DIR}/${INCPKG_DIR_NAME}
INCPKG_BINARY_DIR       =  ${INCTOP_BINARY_DIR}/${INCPKG_DIR_NAME}

INCLIB_SOURCE_DIR       =  ${INCPKG_SOURCE_DIR}/${MODULE_DIR_NAME}
INCLIB_BINARY_DIR       =  ${INCPKG_BINARY_DIR}/${MODULE_DIR_NAME}


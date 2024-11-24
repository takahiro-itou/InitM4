
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
incpkg_dir_name         =  @incpkg_dir_name@
libtop_dir_name         =  @libtop_dir_name@

INCTOP_SOURCE_DIR       =  ${PROJECT_SOURCE_DIR}/${inctop_dir_name}
INCTOP_BINARY_DIR       =  ${PROJECT_BINARY_DIR}/${inctop_dir_name}
LIBTOP_SOURCE_DIR       =  ${PROJECT_SOURCE_DIR}/${libtop_dir_name}
LIBTOP_BINARY_DIR       =  ${PROJECT_BINARY_DIR}/${libtop_dir_name}

INCPKG_SOURCE_DIR       =  ${INCTOP_SOURCE_DIR}/${incpkg_dir_name}
INCPKG_BINARY_DIR       =  ${INCTOP_BINARY_DIR}/${incpkg_dir_name}

inclib_source_dir       =  ${INCPKG_SOURCE_DIR}/${MODULE_DIR_NAME}
inclib_binary_dir       =  ${INCPKG_BINARY_DIR}/${MODULE_DIR_NAME}


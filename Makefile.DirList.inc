
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

inctop_source_dir       =  ${PROJECT_SOURCE_DIR}/${inctop_dir_name}
inctop_binary_dir       =  ${PROJECT_BINARY_DIR}/${inctop_dir_name}
libtop_source_dir       =  ${PROJECT_SOURCE_DIR}/${libtop_dir_name}
libtop_binary_dir       =  ${PROJECT_BINARY_DIR}/${libtop_dir_name}

incpkg_source_dir       =  ${inctop_source_dir}/${incpkg_dir_name}
incpkg_binary_dir       =  ${inctop_binary_dir}/${incpkg_dir_name}

inclib_source_dir       =  ${incpkg_source_dir}/${MODULE_DIR_NAME}
inclib_binary_dir       =  ${incpkg_binary_dir}/${MODULE_DIR_NAME}



##
##    List of Installs.
##

package_includedir      =  ${includedir}/${incpkg_dir_name}
package_libdir          =  ${libdir}

module_includedir       =  ${package_includedir}/${module_dir_name}
module_libdir           =  ${package_libdir}/${module_dir_name}

module_include_HEADERS  =  ${inclib_header_files}
module_lib_HEADERS      =  ${LIBRARY_INSTALL_SRCFILES}
module_lib_LTLIBRARIES  =  ${SHARED_LIBRARIES_LIST}
module_lib_LIBRARIES    =  ${STATIC_LIBRARIES_LIST}

dist_noinst_DATA        =  ${dist_noinst_data_files}
dist_noinst_HEADERS     =  ${dist_noinst_header_files}

##
##    List of (No Dist) Installs.
##

nodist_module_include_HEADERS   =  ${INCLIB_NODIST_HEADER_FILES}


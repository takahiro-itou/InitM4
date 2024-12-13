
##
##    List of Installs.
##

package_includedir      =  ${includedir}/${incpkg_dir_name}
package_libdir          =  ${libdir}

module_includedir       =  ${package_includedir}/${module_dir_name}
module_libdir           =  ${package_libdir}/${module_dir_name}

module_include_HEADERS  =  ${inclib_header_files}
module_lib_HEADERS      =  ${library_install_srcfiles}
module_lib_LTLIBRARIES  =  ${shared_libraries_list}
module_lib_LIBRARIES    =  ${static_libraries_list}

dist_noinst_DATA        =  ${dist_noinst_data_files}
dist_noinst_HEADERS     =  ${dist_noinst_header_files}

##
##    List of (No Dist) Installs.
##

nodist_module_include_HEADERS   =  ${inclib_nodist_header_files}


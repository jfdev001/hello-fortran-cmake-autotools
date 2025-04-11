# Links the supplied library
function(link_library targ lib include_dir)
    target_link_libraries(${targ} PUBLIC ${lib})
    target_include_directories(${targ} PUBLIC $<BUILD_INTERFACE:${include_dir}>)
endfunction()

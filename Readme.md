Fresh app with motion-cocoapods and sugarcube gems, google-cast-sdk pod, and setup google cast in the app delegate

rake and rake device abort with sugarcube’s repl.rb :

Undefined symbols for architecture i386:
  "_NSString", referenced from:
      _MREP_8634E3CDE5674B5A89ECBA3580FEE3DA in repl.rb.o
     (maybe you meant: _Init_NSString)
ld: symbol(s) not found for architecture i386
clang: error: linker command failed with exit code 1 (use -v to see invocation)
rake aborted!


Note: the pod is an dylib, so ?needs to be added in embedded_frameworks.
But this will need to be commented out until after running rake pod:install, so the path to the framework exists.

# AB readme

### Compiling the binary

In the root folder
```
ndk-build
```

It should output `libs\x86\androidvncserver`

### Running the server

```
$ adb connect *device ip*
$ adb root
$ adb connect *device ip*
$ adb push *project folder*\libs\x86\androidvncserver \system\bin
$ adb shell
  # chmod 755 \system\bin\androidvncserver
  # androidvncserver
```

### Connecting to the device

Using a VNC client - RealVNC/UltraVNC, connect to `*device ip*:5901`

### AWS workaround

- To workaround the AWS mmap issues, we've commented out the undocumented `Droid workaround` code in `framebuffer.c`. It seems like it has no effect on usability and performance.

# Original readme

The droid-VNC-server projects consists in three main modules parts: the daemon, wrapper libs and the GUI.

- Daemon - provides the vnc server functionality, injects input/touch events, clipboard management, etc
Available in the `jni/` folder

- Wrapper libs - compiled against the AOSP so everyone can build the daemon/GUI without having to fetch +2GB files.
Currently there are 2 wrappers, `gralloc` and `flinger`.

Available in the `nativeMethods/` folder, and precompiled libs in `nativeMethods/lib/`

- GUI - 
GUI handles user-friendly control.
Connects to the daemon using local IPC.

-------------- Compile C daemon ---------------------

On project folder:
```
  $ ndk-build
  $ ./updateExecsAndLibs.sh
```

-------------- Compile Wrapper libs -----------------
```
  $ cd <aosp_folder>
  $ . build/envsetup.sh
  $ lunch
  $ ln -s <droid-vnc-folder>/nativeMethods/ external/
```

To build:
```
  $ cd external/nativeMethods
  $ mm .
  $ cd <droid-vnc-folder>
  $ ./updateExecsAndLibs.sh
```

-------------- Compile GUI--------------------------

Import using eclipse as a regular Android project
